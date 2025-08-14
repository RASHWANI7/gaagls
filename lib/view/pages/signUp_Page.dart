// import 'package:drop_down_list/drop_down_list.dart';
// import 'package:drop_down_list/model/selected_list_item.dart';
// import 'package:flutter/material.dart';
// import 'package:gaagls/view/pages/signIn_Page.dart';
// import '../widgets/buildTextField.dart';
// import '../widgets/customCountryPicker.dart';
// import '../widgets/signUpButton.dart';
//
//
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   TextEditingController country = TextEditingController();
//   bool _obscurePassword1 = true;
//   bool _obscurePassword2 = true;
//
//   final List<SelectedListItem<String>> _listOfCountries = [
//     SelectedListItem<String>(data: 'Syria'),
//     SelectedListItem<String>(data: 'Egypt'),
//     SelectedListItem<String>(data: 'Turkey'),
//     SelectedListItem<String>(data: 'Jordan'),
//     SelectedListItem<String>(data: 'UAE'),
//     SelectedListItem<String>(data: 'Palestine'),
//     SelectedListItem<String>(data: 'Palestine'),
//   ];
//
//   @override
//   void dispose() {
//     country.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//           SizedBox(
//           height: screenHeight * 0.35,
//           width: double.infinity,
//           child: Image.asset(
//             'lib/images/signIn.jpg',
//             fit: BoxFit.cover,
//           ),
//         ),
//         Container(
//             margin: EdgeInsets.only(top: screenHeight * 0.25),
//             padding: EdgeInsets.all(screenWidth * 0.03),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(40),
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//               const Center(
//               child: Text(
//               'Create your account',
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF145371),
//                 ),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             const BuildTextField(hint: 'First name'),
//             SizedBox(height: screenHeight * 0.015),
//             const BuildTextField(hint: 'Last name'),
//             SizedBox(height: screenHeight * 0.015),
//             const BuildTextField(hint: 'Email'),
//             SizedBox(height: screenHeight * 0.015),
//             BuildTextField(
//              hint:  'Password',
//               obscure: _obscurePassword1,
//               toggleObscure: () {
//                 setState(() {
//                   _obscurePassword1 = !_obscurePassword1;
//                 });
//               },
//             ),
//             SizedBox(height: screenHeight * 0.015),
//             BuildTextField(
//              hint:  'Confirm Password',
//               obscure: _obscurePassword2,
//               toggleObscure: () {
//                 setState(() {
//                   _obscurePassword2 = !_obscurePassword2;
//                 });
//               },
//             ),
//             SizedBox(height: screenHeight * 0.015),
//
//                   CustomCountryPicker(
//                     controller: country,
//                     onTap: () => _showCountryPicker(),
//                   ),
//
//                   SizedBox(height: screenHeight * 0.025),
//                   signUpButton(screenWidth: screenWidth, screenHeight: screenHeight),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Already have an account ?',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF377E9F),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(
//                                 builder: (context) => const SignIn()),
//                           );
//                         },
//                         child: const Text(
//                           'SignIn',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF377E9F),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//         ),
//           ],
//         ),
//     );
//   }
//
//   void _showCountryPicker() {
//     DropDownState<String>(
//       dropDown: DropDown<String>(
//         bottomSheetTitle: const Text(
//           'Select Country',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//           ),
//         ),
//         submitButtonText: 'OK',
//         clearButtonText: 'Clear',
//         data: _listOfCountries,
//         onSelected: (selectedItems) {
//           if (selectedItems.isNotEmpty) {
//             country.text = selectedItems.first.data;
//           }
//         },
//         enableMultipleSelection: false,
//       ),
//     ).showModal(context);
//   }
// }

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/signUpCubit/registerCubit.dart';
import 'package:gaagls/controller/cubits/signUpCubit/registerState.dart';
import 'package:gaagls/model/cities.dart';
import 'package:gaagls/view/pages/signIn_Page.dart';
import 'package:gaagls/view/widgets/myDialog.dart';
import 'package:gaagls/view/widgets/mySnackBar.dart';
import '../widgets/buildTextField.dart';
import '../widgets/customCountryPicker.dart';
import '../widgets/signUpButton.dart';
import 'otp_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  ValueNotifier<bool> obscurePassword1 = ValueNotifier(true);
  ValueNotifier<bool> obscurePassword2 = ValueNotifier(true);


  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().getCountries();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    countryController.dispose();

    obscurePassword1.dispose();
    obscurePassword2.dispose();

    super.dispose();
  }

  Cities? selectedCity;
  late final int userId;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight * 0.35,
            width: double.infinity,
            child: Image.asset(
              'lib/images/signIn.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.25),
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration:  BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Create your account',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  BuildTextField(
                    hint: 'First name',
                    controller: firstNameController,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  BuildTextField(
                    hint: 'Last name',
                    controller: lastNameController,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  BuildTextField(
                    hint: 'Email',
                    controller: emailController,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  // BuildTextField(
                  //   hint: 'Password',
                  //   obscure: _obscurePassword1,
                  //   toggleObscure: () {
                  //     setState(() {
                  //       _obscurePassword1 = !_obscurePassword1;
                  //     });
                  //   },
                  // ),

                  ValueListenableBuilder<bool>(
                    valueListenable: obscurePassword1, // المراقبة هنا
                    builder: (context, isObscure, _) {
                      return BuildTextField(
                        hint: 'Password',
                        obscure: isObscure,
                        controller: passwordController,
                        toggleObscure: () {
                          obscurePassword1.value =
                              !obscurePassword1.value; // قلب القيمة
                        },
                      );
                    },
                  ),

                  SizedBox(height: screenHeight * 0.015),
                  // BuildTextField(
                  //   hint: 'Confirm Password',
                  //   obscure: _obscurePassword2,
                  //   toggleObscure: () {
                  //     setState(() {
                  //       _obscurePassword2 = !_obscurePassword2;
                  //     });
                  //   },
                  // ),
                  ValueListenableBuilder<bool>(
                    valueListenable: obscurePassword2, // المراقبة هنا
                    builder: (context, isObscure, _) {
                      return BuildTextField(
                        hint: 'Confirm Password',
                        obscure: isObscure,
                        controller: confirmPasswordController,
                        toggleObscure: () {
                          obscurePassword2.value =
                              !obscurePassword2.value; // قلب القيمة
                        },
                      );
                    },
                  ),

                  SizedBox(height: screenHeight * 0.015),
                  BlocBuilder<RegisterCubit, Registerstate>(
                    builder: (context, state) {
                      final List<Cities> cities =
                          context.read<RegisterCubit>().citiesList;

                      return CustomCountryPicker(
                        controller: countryController,
                        onTap: () => _showCountryPicker(
                            context, cities), // ✅ مرر البيانات هنا
                      );
                    },
                  ),

                  SizedBox(height: screenHeight * 0.025),
                  //signUpButton(city: context.watch<RegisterCubit>().selectedCity,screenWidth: screenWidth, screenHeight: screenHeight),
                  // BlocBuilder<RegisterCubit, Registerstate>(
                  //   builder: (context, state) {
                  //     if(state is registerLoading){
                  //       return CircularProgressIndicator();
                  //     }else if(state is registerSuccess){
                  //       return MyDialog(state.message, context);
                  //     }
                  //     final selectedCity = context.read<RegisterCubit>().selectedCity;
                  //     return signUpButton(
                  //       city: selectedCity,
                  //       screenWidth: screenWidth,
                  //       screenHeight: screenHeight,
                  //       onTap: (){
                  //         if(firstNameController.text.isEmpty||lastNameController.text.isEmpty||emailController.text.isEmpty||passwordController.text.isEmpty||confirmPasswordController.text.isEmpty||countryController.text.isEmpty){
                  //                 MySnackBar('All fields are required', context);
                  //         }
                  //         else{
                  //           context.read<RegisterCubit>().Register(
                  //             firstName: firstNameController.text,
                  //             lastName: lastNameController.text,
                  //             email: emailController.text,
                  //             password: passwordController.text,
                  //             confirmPassword: confirmPasswordController.text,
                  //             cityId: selectedCity!.id,
                  //             context: context
                  //           );
                  //         }
                  //       },
                  //     );
                  //   },
                  // ),

                  BlocConsumer<RegisterCubit, Registerstate>(
                    listener: (context, state) {
                      if (state is registerSuccess) {
                        userId = state.userId as int;
                        // عرض Dialog بعد انتهاء البناء
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          MyDialog(state.message, () {
                            //Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpScreen(
                                        userId: userId,
                                      )),
                              (Route<dynamic> route) => false,
                            );
                          },  context);
                        });
                      } else if (state is registerFailure) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          MySnackBar(state.error, context);
                        });
                      }
                    },
                    builder: (context, state) {
                      final selectedCity =
                          context.read<RegisterCubit>().selectedCity;

                      return state is registerLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              children: [
                                signUpButton(
                                  city: selectedCity,
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  onTap: () {
                                    if (firstNameController.text.isEmpty ||
                                        lastNameController.text.isEmpty ||
                                        emailController.text.isEmpty ||
                                        passwordController.text.isEmpty ||
                                        confirmPasswordController
                                            .text.isEmpty ||
                                        countryController.text.isEmpty ||
                                        selectedCity == null) {
                                      MySnackBar(
                                          'All fields are required', context,isError: true);
                                    } else {
                                      context.read<RegisterCubit>().Register(
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            confirmPassword:
                                                confirmPasswordController.text,
                                            cityId: selectedCity.id,
                                            context: context,
                                          );
                                    }
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account ?',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignIn()),
                                        );
                                      },
                                      child: Text(
                                        'SignIn',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _showCountryPicker(BuildContext context, List<Cities> citiesList) {
  //   final items = citiesList.map((c) => SelectedListItem<String>(data: c.city)).toList();
  //
  //   DropDownState<String>(
  //     dropDown: DropDown<String>(
  //         data: items,
  //         onSelected: (selectedItems) {
  //           if (selectedItems.isNotEmpty) {
  //             final selectedCityName = selectedItems.first.data;
  //             country.text = selectedCityName;
  //             final selectedCity = citiesList.firstWhere((city) => city.city == selectedCityName);
  //             context.read<RegisterCubit>().updateSelectedCity(selectedCity);
  //           }
  //         },
  //
  //     ),
  //   ).showModal(context);
  //
  // }

  void _showCountryPicker(BuildContext context, List<Cities> citiesList) {
    final items = citiesList
        .map((city) => SelectedListItem<Cities>(
              data: city,
            ))
        .toList();

    DropDownState<Cities>(
      dropDown: DropDown<Cities>(
        bottomSheetTitle: const Text(
          'Select City',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        submitButtonText: 'OK',
        clearButtonText: 'Clear',
        data: items,
        onSelected: (selectedItems) {
          if (selectedItems.isNotEmpty) {
            // final selectedCity = selectedItems.first.data; // هذا هو Cities كامل
            // country.text = selectedCity.city;             // عرض الاسم فقط في الـ TextField
            // context.read<RegisterCubit>().selectedCity = selectedCity; // تخزين الـ Cities في cubit
            // print('Selected city: ${selectedCity.city}, id: ${selectedCity.id}');
            // print(context.read<RegisterCubit>().selectedCity?.city.toString());

            final selectedCity = selectedItems.first.data;
            countryController.text = selectedCity.city;
            context.read<RegisterCubit>().updateSelectedCity(selectedCity);
            print(
                'Selected city: ${selectedCity.city}, id: ${selectedCity.id}');
          }
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }
}
