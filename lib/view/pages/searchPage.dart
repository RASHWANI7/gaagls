import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/view/pages/resturantDetailsPage.dart';
import 'package:gaagls/view/pages/roomsPage.dart';
import 'package:gaagls/view/pages/tripDetailsPage.dart';
import 'package:gaagls/view/widgets/destinationCard.dart';
import 'package:gaagls/view/widgets/destinationPageCard.dart';
import '../../controller/cubits/RestaurantsCubit/restaurantsCubit.dart';
import '../../controller/cubits/hotelsCubit/hotelsCubit.dart';
import '../../controller/cubits/searchCubit/searchCubit.dart';
import '../../controller/cubits/tripCubit/tripCubit.dart';
import '../widgets/carBrandCard.dart';
import '../widgets/hotelPageCard.dart';
import '../widgets/resturantPageCard.dart';
import '../widgets/secondSnackBar.dart';
import '../widgets/tripPageCard.dart';
import 'airlinePage.dart';
import 'carsPage.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final SearchCubit _cubit;
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _cubit = SearchCubit();
    _searchController = TextEditingController();
    _focusNode  = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _cubit.close();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      _cubit.fetchSearchResults(query);
      // لإخفاء لوحة المفاتيح بعد الضغط
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                focusNode: _focusNode,
                autofocus: false,                // مهم جداً: لا تفتح الكيبورد تلقائياً
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onTap: () {
                  // يفتح الكيبورد فقط عند النقر الفعلي على الحقل
                  if (!_focusNode.hasFocus) {
                    _focusNode.requestFocus();
                  }
                },
                onSubmitted: (_) {
                  _focusNode.unfocus();
                  _submitSearch();
                  },
                onEditingComplete: _submitSearch,
              ),
              const SizedBox(height: 10),
              _FilterBar(),
              const SizedBox(height: 10),
              Expanded(child: _SearchResults()),
            ],
          ),
        ),
      ),
    );
  }
}


class _FilterBar extends StatelessWidget {
  final filters = [
    'all',
    'cars',
    'hotels',
    'restaurants',
    'trips',
    'destinations'
  ];

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<SearchCubit>().state.selectedFilter;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = selected == filter;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              selectedColor: Theme.of(context).primaryColor,                 // لون الشيب عندما يكون مُحدد
              backgroundColor: Theme.of(context).secondaryHeaderColor,       // لون الشيب الافتراضي
              side: BorderSide(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade400,
              ),
              onSelected: (_) =>
                  context.read<SearchCubit>().changeFilter(filter),
            ),
          );
        }).toList(),
      ),
    );
  }
}












class _SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchCubit>().state;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.error.isNotEmpty) return Center(child: Text(state.error));

    // 3) لم يُجرِ المستخدم بحثًا بعد
    if (!state.hasSearched) {
      return Center(
        child: Text(
          'Start Search In GAAGLS',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 21, color: Theme.of(context).iconTheme.color),
        ),
      );
    }

    // 4) بعد البحث و لم توجد نتائج في أي قائمة
    final noResults = state.carBrands.isEmpty &&
        state.hotels.isEmpty &&
        state.restaurants.isEmpty &&
        state.trips.isEmpty &&
        state.destinations.isEmpty;
    if (noResults) {
      return  Center(
        child: Text(
          'Sorry, no results found.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 21, color: Theme.of(context).iconTheme.color),
        ),
      );
    }


    Widget buildEmpty(String label) {
      return Center(
        child: Text(
          'No results found in $label.',
          style: TextStyle(fontSize: 16, color: Theme.of(context).iconTheme.color),
        ),
      );
    }


    List<Widget> widgets = [];

    print('>>> carBrands length = ${state.carBrands.length}');
    print('>>> hotels length    = ${state.hotels.length}');

    switch (state.selectedFilter) {
      case 'cars':
        if (state.carBrands.isEmpty) {
          return buildEmpty('cars');
        }
        widgets = state.carBrands
            .map((carBrand) => CarBrandCard(
                  brand: carBrand,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CarsPage(brandName: carBrand.brandName),
                      ),
                    );
                  },
                ))
            .toList();
        break;

      case 'restaurants':
        if (state.restaurants.isEmpty) {
          return buildEmpty('restaurants');
        }
        widgets = state.restaurants
            .map(
              (restaurant) => RestaurantPageCard(
                resturant: restaurant,
                width: double.infinity,
                imageHeight: screenHeight * 0.22,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ResturantDetailsPage(resturant: restaurant),
                    ),
                  );
                },
                onFavoriteTap: () async {
                  final result = await context.read<SearchCubit>().toggleRestaurantFavoriteInSearch(restaurant);
                  SecondSnackBar(result['message'], context, isError: !result['success']);
                },
              ),
            )
            .toList();
        break;


      case 'hotels':
        if (state.hotels.isEmpty) {
          return buildEmpty('hotels');
        }
        widgets = state.hotels
            .map((hotel) => HotelPageCard(
                  hotel: hotel,
                  width: double.infinity,
                  imageHeight: screenHeight * 0.2,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RoomsPage(hotel: hotel),
                      ),
                    );
                  },
          onFavotieTap: () async {
            final result = await context.read<SearchCubit>().toggleHotelFavoriteInSearch(hotel);
            SecondSnackBar(result['message'], context, isError: !result['success']);
          },
                ))
            .toList();
        break;

      case 'trips':
        if (state.trips.isEmpty) {
          return buildEmpty('trips');
        }
        widgets = state.trips
            .map((trip) => TripPageCard(
          trip: trip,
          width: double.infinity,
          imageHeight: screenHeight * 0.24,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    TripDetailsPage(trip: trip),
              ),
            );
          },
          onFavoriteTap: () async {
            final result = await context.read<SearchCubit>().toggleTripFavoriteInSearch(trip);
            SecondSnackBar(result['message'], context, isError: !result['success']);
          },
        ))
            .toList();
        break;

      case 'destinations':
        if (state.destinations.isEmpty) {
          return buildEmpty('destinations');
        }
        widgets = state.destinations
            .map((destination) => DestinationPageCard(
                  destination: destination,
                  width: double.infinity,
                  imageHeight: screenHeight * 0.24,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AirLinesPage(destination: destination),
                      ),
                    );
                  },
          onFavoriteTap: () async {
            final result = await context.read<SearchCubit>().toggleDestinationFavoriteInSearch(destination);
            SecondSnackBar(result['message'], context, isError: !result['success']);
          },
                ))
            .toList();
        break;

      default:
        widgets = [
          ...state.hotels.map((hotel) => HotelPageCard(
                hotel: hotel,
                width: double.infinity,
                imageHeight: screenHeight * 0.2,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RoomsPage(hotel: hotel),
                    ),
                  );
                },
              onFavotieTap: () async {
                final result = await context.read<SearchCubit>().toggleHotelFavoriteInSearch(hotel);
                SecondSnackBar(result['message'], context, isError: !result['success']);
              },
              )),
          ...state.restaurants.map((restaurant) => RestaurantPageCard(
                resturant: restaurant,
                width: double.infinity,
                imageHeight: screenHeight * 0.22,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ResturantDetailsPage(resturant: restaurant),
                    ),
                  );
                },
            onFavoriteTap: () async {
              final result = await context.read<SearchCubit>().toggleRestaurantFavoriteInSearch(restaurant);
              SecondSnackBar(result['message'], context, isError: !result['success']);
            },
              )),
          ...state.trips.map((trip) => TripPageCard(
            trip: trip,
            width: double.infinity,
            imageHeight: screenHeight * 0.24,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      TripDetailsPage(trip: trip),
                ),
              );
            },
            onFavoriteTap: () async {
              final result = await context.read<SearchCubit>().toggleTripFavoriteInSearch(trip);
              SecondSnackBar(result['message'], context, isError: !result['success']);
            },
          )),
          ...state.destinations.map((destination) => DestinationPageCard(
                destination: destination,
                width: screenWidth,
                imageHeight: screenHeight * 0.24,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AirLinesPage(destination: destination),
                    ),
                  );
                },
            onFavoriteTap: () async {
              final result = await context.read<SearchCubit>().toggleDestinationFavoriteInSearch(destination);
              SecondSnackBar(result['message'], context, isError: !result['success']);
            },
              )),
          ...state.carBrands.map((carBrand) => CarBrandCard(
                brand: carBrand,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CarsPage(brandName: carBrand.brandName),
                    ),
                  );
                },
              )),
        ];
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(2,10,2,70),
      children: widgets,
    );
  }
}
