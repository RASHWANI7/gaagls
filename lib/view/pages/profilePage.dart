import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/cubits/profileCubit/profileCubit.dart';
import '../../controller/cubits/profileCubit/profileState.dart';
import '../widgets/myDialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProfileCubit>();
    cubit.loadProfileData(); // تحميل البيانات عند الدخول
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cubit = context.read<ProfileCubit>();

    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }  if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.error,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileCubit>().loadProfileData(); // ✅ إعادة المحاولة
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }else if(state is ProfileForgetPassword){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              MyDialog(state.message, () {
                Navigator.pop(context);
                context.read<ProfileCubit>().loadProfileData(); // ⬅️ إعادة تحميل البيانات هنا
              }, context);
            });
          }else if(state is ProfileForgetPasswordFailure){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              MyDialog(state.message, () {
                Navigator.pop(context);
                context.read<ProfileCubit>().loadProfileData(); // ⬅️ إعادة تحميل البيانات هنا
              },  context);
            });
          }


          if (state is ProfileSuccess) {
            firstNameController.text = state.firstName;
            lastNameController.text = state.lastName;
            final imageUrl = state.image;
            final email = state.email;
            File? imageFile;
            if (state is ProfileImagePicked) imageFile = state.image as File?;

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.01),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            // ---------------------- CARD ----------------------
                            Container(
                              width: size.width * 0.9,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: size.height < 600 ? 40 : 80,
                              ),
                              margin: EdgeInsets.only(
                                  top: (size.width < 350 ? 60 : 70) + 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.secondary
                                        .withOpacity(0.7),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: (size.width < 350 ? 60 : 80) + 5),

                                  _buildField(
                                    label: 'First name',
                                    controller: firstNameController,
                                    isDark: isDark,
                                  ),
                                  _buildField(
                                    label: 'Last name',
                                    controller: lastNameController,
                                    isDark: isDark,
                                  ),

                                  const SizedBox(height: 20),

                                  // ---------------------- SAVE BUTTON ----------------------
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        cubit.saveProfile(
                                          firstName:
                                          firstNameController.text.trim(),
                                          lastName:
                                          lastNameController.text.trim(),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'Save',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),



                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        cubit.forgetPassword(
                                          email: email,
                                        );
                                      },
                                      child: Text(
                                        'Change Password ?',
                                        style: TextStyle(
                                          color: Theme.of(context).iconTheme.color,
                                        ),
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),

                            // ---------------------- IMAGE + EMAIL ----------------------
                            Positioned(
                              top: 0,
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        radius: size.width < 350 ? 60 : 80,
                                        backgroundColor:Theme.of(context).primaryColor,
                                        child: ClipOval(
                                          child: imageFile != null
                                              ? Image.file(
                                            imageFile,
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          )
                                              : (imageUrl.isNotEmpty
                                              ? Image.network(
                                            imageUrl,
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          )
                                              : Icon(
                                            Icons.person,
                                            size: 70,
                                            color: Theme.of(context).primaryColor,
                                          )),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.secondary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.edit,
                                              color: Colors.white, size: 20),
                                        ),
                                        onPressed: cubit.pickImage,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    email,
                                    style: TextStyle(
                                      color: Theme.of(context).iconTheme.color,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text("حدث خطأ أثناء تحميل الملف الشخصي"));
        },
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: isDark ? Colors.white70 : Colors.black87,
          ),
          filled: true,
          fillColor: Theme.of(context).secondaryHeaderColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        style: TextStyle(color: Theme.of(context).iconTheme.color),
      ),
    );
  }
}


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../controller/cubits/profileCubit/profileCubit.dart';
// import '../../controller/cubits/profileCubit/profileState.dart';
// import '../widgets/myDialog.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   late TextEditingController firstNameController;
//   late TextEditingController lastNameController;
//
//   @override
//   void initState() {
//     super.initState();
//     final cubit = context.read<ProfileCubit>();
//     cubit.loadProfileData(); // تحميل البيانات عند الدخول
//     firstNameController = TextEditingController();
//     lastNameController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     firstNameController.dispose();
//     lastNameController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final cubit = context.read<ProfileCubit>();
//
//     return Scaffold(
//       body: BlocBuilder<ProfileCubit, ProfileState>(
//         builder: (context, state) {
//           if (state is ProfileLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ProfileError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     state.error,
//                     style: const TextStyle(color: Colors.red),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       context.read<ProfileCubit>().loadProfileData();
//                     },
//                     child: const Text('إعادة المحاولة'),
//                   ),
//                 ],
//               ),
//             );
//           }
//
//           if (state is ProfileSuccess ||
//               state is ProfileImagePicked ||
//               state is ProfileForgetPasswordLoading ||
//               state is ProfileForgetPassword ||
//               state is ProfileForgetPasswordFailure) {
//             final profileState = context.read<ProfileCubit>().state;
//
//             String firstName = "";
//             String lastName = "";
//             String email = "";
//             String imageUrl = "";
//             File? imageFile;
//
//             if (profileState is ProfileSuccess ||
//                 profileState is ProfileImagePicked) {
//               firstNameController.text = (profileState as dynamic).firstName;
//               lastNameController.text = (profileState as dynamic).lastName;
//               email = (profileState as dynamic).email;
//               imageUrl = (profileState as dynamic).image;
//               if (profileState is ProfileImagePicked)
//                 imageFile = profileState.imageFile as File?;
//             }
//
//             return Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(height: size.height * 0.01),
//                       Center(
//                         child: Stack(
//                           alignment: Alignment.center,
//                           clipBehavior: Clip.none,
//                           children: [
//                             Container(
//                               width: size.width * 0.9,
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 20,
//                                 vertical: size.height < 600 ? 40 : 80,
//                               ),
//                               margin: EdgeInsets.only(
//                                   top: (size.width < 350 ? 60 : 70) + 10),
//                               decoration: BoxDecoration(
//                                 color: isDark ? Colors.black : Colors.white,
//                                 borderRadius: BorderRadius.circular(50),
//                                 border: Border.all(
//                                   color: isDark
//                                       ? Colors.white
//                                       : const Color(0xFF002147),
//                                   width: 2,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: (isDark
//                                             ? Colors.white
//                                             : const Color(0xFF002147))
//                                         .withOpacity(0.7),
//                                     blurRadius: 10,
//                                     spreadRadius: 1,
//                                     offset: const Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   SizedBox(
//                                       height: (size.width < 350 ? 60 : 80) + 5),
//                                   _buildField(
//                                     label: 'First name',
//                                     controller: firstNameController,
//                                     isDark: isDark,
//                                   ),
//                                   _buildField(
//                                     label: 'Last name',
//                                     controller: lastNameController,
//                                     isDark: isDark,
//                                   ),
//                                   const SizedBox(height: 20),
//                                   SizedBox(
//                                     width: double.infinity,
//                                     child: ElevatedButton(
//                                       onPressed: () {
//                                         cubit.saveProfile(
//                                           firstName:
//                                               firstNameController.text.trim(),
//                                           lastName:
//                                               lastNameController.text.trim(),
//                                         );
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: isDark
//                                             ? Colors.white
//                                             : const Color(0xFF002147),
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 10),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                       ),
//                                       child: Text(
//                                         'Save',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: isDark
//                                               ? const Color.fromARGB(
//                                                   255, 19, 4, 4)
//                                               : Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 10),
//                                   BlocConsumer<ProfileCubit, ProfileState>(
//                                     listenWhen: (previous, current) =>
//                                         current is ProfileForgetPassword ||
//                                         current is ProfileForgetPasswordFailure,
//                                     listener: (context, state) {
//                                       final message = state
//                                               is ProfileForgetPassword
//                                           ? state.message
//                                           : (state
//                                                   as ProfileForgetPasswordFailure)
//                                               .message;
//
//                                       MyDialog(message, () {
//                                         Navigator.pop(context);
//                                         context
//                                             .read<ProfileCubit>()
//                                             .loadProfileData(); // ⬅️ إعادة تحميل البيانات هنا
//                                       }, context);
//                                     },
//                                     builder: (context, state) {
//                                       final isLoading =
//                                           state is ProfileForgetPasswordLoading;
//                                       return Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: isLoading
//                                             ? const Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 30),
//                                                 child: SizedBox(
//                                                   height: 20,
//                                                   width: 20,
//                                                   child:
//                                                       CircularProgressIndicator(
//                                                           strokeWidth: 5),
//                                                 ),
//                                               )
//                                             : TextButton(
//                                                 onPressed: () {
//                                                   context
//                                                       .read<ProfileCubit>()
//                                                       .forgetPassword(
//                                                           email: email);
//                                                 },
//                                                 child: Text(
//                                                   'Change Password',
//                                                   style: TextStyle(
//                                                     color: isDark
//                                                         ? Colors.white
//                                                         : Colors.blue,
//                                                   ),
//                                                 ),
//                                               ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Positioned(
//                               top: 0,
//                               child: Column(
//                                 children: [
//                                   Stack(
//                                     alignment: Alignment.bottomRight,
//                                     children: [
//                                       CircleAvatar(
//                                         radius: size.width < 350 ? 60 : 80,
//                                         backgroundColor: isDark
//                                             ? Colors.black
//                                             : Colors.white,
//                                         child: ClipOval(
//                                           child: imageFile != null
//                                               ? Image.file(
//                                                   imageFile,
//                                                   width: 150,
//                                                   height: 150,
//                                                   fit: BoxFit.cover,
//                                                 )
//                                               : (imageUrl.isNotEmpty
//                                                   ? Image.network(
//                                                       imageUrl,
//                                                       width: 150,
//                                                       height: 150,
//                                                       fit: BoxFit.cover,
//                                                     )
//                                                   : Icon(
//                                                       Icons.person,
//                                                       size: 70,
//                                                       color: isDark
//                                                           ? Colors.white
//                                                           : const Color(
//                                                               0xFF002147),
//                                                     )),
//                                         ),
//                                       ),
//                                       IconButton(
//                                         icon: Container(
//                                           padding: const EdgeInsets.all(6),
//                                           decoration: const BoxDecoration(
//                                             color: Colors.blue,
//                                             shape: BoxShape.circle,
//                                           ),
//                                           child: const Icon(Icons.edit,
//                                               color: Colors.white, size: 18),
//                                         ),
//                                         onPressed: cubit.pickImage,
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 12),
//                                   Text(
//                                     email,
//                                     style: TextStyle(
//                                       color:
//                                           isDark ? Colors.white : Colors.black,
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold,
//                                       decoration: TextDecoration.underline,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 50),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }
//
//           return const Center(child: Text("حدث خطأ أثناء تحميل الملف الشخصي"));
//         },
//       ),
//     );
//   }
//
//   Widget _buildField({
//     required String label,
//     required TextEditingController controller,
//     required bool isDark,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(
//             color: isDark ? Colors.white70 : Colors.black87,
//           ),
//           filled: true,
//           fillColor: isDark ? Colors.grey[900] : Colors.grey[100],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         style: TextStyle(color: isDark ? Colors.white : Colors.black),
//       ),
//     );
//   }
// }
