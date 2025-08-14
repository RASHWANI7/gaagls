import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/homeCubit/homeCubit.dart';
import 'package:gaagls/controller/cubits/settingCubit/settingCubit.dart';
import 'package:gaagls/view/pages/favoritesPage.dart';
import 'package:gaagls/view/pages/homePage.dart';
import 'package:gaagls/view/pages/profilePage.dart';
import 'package:gaagls/view/pages/searchPage.dart';
import 'package:gaagls/view/pages/settingPage.dart';
import 'package:gaagls/view/widgets/MyDrawer.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';

import '../../controller/cubits/favoriteCubit/favoriteCubit.dart';

// class CustomNavBar extends StatelessWidget {
//   CustomNavBar({super.key});
//
//   final List<IconData> icons = [
//     Icons.account_circle,
//     Icons.favorite_border,
//     Icons.home_outlined,
//     Icons.search,
//     Icons.settings_outlined,
//   ];
//
//   final List<Widget> pages = [
//     Placeholder(), // Account
//     Placeholder(), // Favorites
//     HomePage(), // Home
//     SearchPage(), // Settings
//     Placeholder(), // Settings
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return BlocBuilder<NavCubit, int>(
//       builder: (context, selectedIndex) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: const Color(0xFF145371),
//             title: const Text(
//               'Gaagles',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 26,
//                 color: Colors.white70,
//               ),
//             ),
//             centerTitle: true,
//           ),
//           drawer: Drawer(
//             child: ListView(
//               children: [
//                 const SizedBox(height: 50),
//                 MaterialButton(
//                   onPressed: () {},
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 70,
//                         height: 70,
//                         child: ClipOval(
//                           child: Image.asset(
//                             'assets/1dece2c8357bdd7cee3b15036344faf5.jpg',
//                             width: 60,
//                             height: 60,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       const Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Lisa Tlij',
//                             style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w900,
//                             ),
//                           ),
//                           Text(
//                             'www.lisa2004@gmail.com',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Divider(),
//                 ListTile(
//                   title: const Text('Language'),
//                   leading: const Icon(Icons.language),
//                   onTap: () {},
//                 ),
//                 // Consumer<ThemeProvider>(
//                 // builder: (context, themeProvider, child) {
//                 // return SwitchListTile(
//                 // title: const Text('Dark Mode'),
//                 // secondary: const Icon(Icons.dark_mode),
//                 // value: themeProvider.isDarkMode,
//                 // onChanged: (val) {
//                 // themeProvider.toggleTheme(val);
//                 // },
//                 // );
//                 // },
//                 // ),
//                 ListTile(
//                   title: const Text('LogOut'),
//                   leading: const Icon(Icons.login_outlined),
//                   onTap: () {},
//                 ),
//               ],
//             ),
//           ),
//           backgroundColor: const Color(0xFFFFFFFF),
//           body: Stack(
//             children: [
//               IndexedStack(
//                 index: selectedIndex,
//                 children: pages,
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 20),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(40),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.15),
//                           blurRadius: 20,
//                           offset: const Offset(0,8),
//                         ),
//                       ],
//                     ),
//                     child: GlassmorphicContainer(
//                       width: screenWidth*0.85,
//                       height: screenHeight*0.08,
//                       borderRadius: 40,
//                       blur: 20,
//                       alignment: Alignment.center,
//                       border: 1,
//                       linearGradient: LinearGradient(
//                         colors: [
//                           const Color(0xFF145371).withOpacity(0.25),
//                           const Color(0xFF145371).withOpacity(0.25),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       borderGradient: LinearGradient(
//                         colors: [
//                           const Color(0xFF145371).withOpacity(0.4),
//                           const Color(0xFF145371).withOpacity(0.4),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         // children: List.generate(icons.length, (index) {
//                         //   final isSelected = selectedIndex == index;
//                         //   return GestureDetector(
//                         //     onTap: () {
//                         //       context.read<NavCubit>().changeIndex(index);
//                         //     },
//                         //     child: AnimatedContainer(
//                         //       duration: const Duration(milliseconds: 50),
//                         //       width: isSelected ? 60 : 70,
//                         //       height: isSelected ? 60 : 70,
//                         //       decoration: isSelected
//                         //           ? const BoxDecoration(
//                         //               shape: BoxShape.circle,
//                         //               gradient: LinearGradient(
//                         //                 colors: [
//                         //                   Color(0xFF145371),
//                         //                   Color(0xFF1F6A8C),
//                         //                 ],
//                         //                 begin: Alignment.topLeft,
//                         //                 end: Alignment.bottomRight,
//                         //               ),
//                         //             )
//                         //           : null,
//                         //       curve: Curves.easeOut,
//                         //       child: AnimatedScale(
//                         //         scale: isSelected ? 1.2 : 1.0,
//                         //         duration: const Duration(milliseconds: 150),
//                         //         curve: Curves.easeOut,
//                         //         child: Icon(
//                         //           icons[index],
//                         //           color: isSelected
//                         //               ? Colors.white
//                         //               : Colors.white70,
//                         //           size: isSelected ? 26 : 24,
//                         //         ),
//                         //       ),
//                         //     ),
//                         //   );
//                         // }),
//
//                         children: List.generate(icons.length, (index) {
//                           final isSelected = selectedIndex == index;
//                           return GestureDetector(
//                             onTap: () {
//                               if (selectedIndex != index) {
//                                 // 1) أزل تركيز أي TextField مفتوح
//                                 FocusScope.of(context).unfocus();
//                                 // 2) ثم غيّر التبويب
//                                 context.read<NavCubit>().changeIndex(index);
//                               }
//                             },
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 50),
//                               width: isSelected ? 50 : 70,
//                               height: isSelected ? 50 : 70,
//                               decoration: isSelected
//                                   ? BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: const LinearGradient(
//                                   colors: [Color(0xFF145371), Color(0xFF1F6A8C)],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.7),
//                                     blurRadius: 8,
//                                     offset: Offset(0, 10),
//                                   ),
//                                 ],
//                               )
//                                   : BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.transparent,
//                               ),
//
//                               curve: Curves.easeOut,
//                               child: AnimatedScale(
//                                 scale: isSelected ? 1.2 : 1.0,
//                                 duration: const Duration(milliseconds: 150),
//                                 curve: Curves.easeOut,
//                                 child: Icon(
//                                   icons[index],
//                                   color: isSelected ? Colors.white : Colors.white70,
//                                   size: isSelected ? 28 : 26,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//
//
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }



class CustomNavBar extends StatelessWidget {
  CustomNavBar({super.key});

  final List<IconData> icons = [
    Icons.account_circle,
    Icons.favorite_border,
    Icons.home_outlined,
    Icons.search,
    Icons.settings_outlined,
  ];

  final List<Widget> pages = [
    ProfileScreen(), // Account
    FavoritePage(), // Favorites
    HomePage(),    // Home
    SearchPage(),  // Search
    SettingsPage(), // Settings
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth  = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // هذا السطر يتحقق ما إذا كانت لوحة المفاتيح ظاهرة:
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return BlocBuilder<NavCubit, int>(
      builder: (context, selectedIndex) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Gaagles',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            centerTitle: true,
          ),
          drawer: MyCustomDrawer(),
          body: Stack(
            children: [
              // هنا محتوى الصفحات
              IndexedStack(
                index: selectedIndex,
                children: pages,
              ),

              // إذا لم تكن الكيبورد مفتوحة فقط، نعرض الـ nav bar
              if (!isKeyboardOpen)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: GlassmorphicContainer(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.08,
                        borderRadius: 40,
                        blur: 20,
                        alignment: Alignment.center,
                        border: 1,
                        linearGradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.25),
                            Theme.of(context).primaryColor.withOpacity(0.25),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderGradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.4),
                            Theme.of(context).primaryColor.withOpacity(0.4),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(icons.length, (index) {
                            final isSelected = selectedIndex == index;
                            return GestureDetector(
                              onTap: () {

                                if (selectedIndex != index) {
                                // 1) أزل تركيز أي TextField مفتوح
                                FocusScope.of(context).unfocus();
                                // 2) ثم غيّر التبويب
                                context.read<NavCubit>().changeIndex(index);

                                // ✅ إذا كان التاب هو المفضلة (رقمه 1)
                                if (index == 1) {
                                  context.read<FavoriteCubit>().getFavorites();
                                }
                                if (index == 2) {
                                  context.read<HomeCubit>().loadHomeData();
                                }
                                if (index == 4) {
                                  context.read<SettingsCubit>().getCountries();
                                }

                              }
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 50),
                                width: isSelected ? 50 : 70,
                                height: isSelected ? 50 : 70,
                                decoration: isSelected
                                    ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [Theme.of(context).colorScheme.secondary,Theme.of(context).primaryColor],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.7),
                                      blurRadius: 8,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                )
                                    : const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                ),
                                curve: Curves.easeOut,
                                child: AnimatedScale(
                                  scale: isSelected ? 1.2 : 1.0,
                                  duration: const Duration(milliseconds: 150),
                                  curve: Curves.easeOut,
                                  child: Icon(
                                    icons[index],
                                    color: isSelected ? Colors.white : Colors.white70,
                                    size: isSelected ? 28 : 26,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}






// lib/bloc/nav_cubit.dart
class NavCubit extends Cubit<int> {
  NavCubit() : super(2); // الصفحة الرئيسية الافتراضية (Home)

  void changeIndex(int newIndex) => emit(newIndex);
}
