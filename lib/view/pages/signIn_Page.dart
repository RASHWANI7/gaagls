import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/logInCubit/logInCubit.dart';
import 'package:gaagls/controller/cubits/logInCubit/logInState.dart';
import 'package:gaagls/view/pages/customNavBar.dart';
import 'package:gaagls/view/pages/homePage.dart';
import 'package:gaagls/view/pages/otp_page.dart';
import 'package:gaagls/view/pages/signUp_Page.dart';
import 'package:gaagls/view/widgets/buildTextField.dart';
import 'package:gaagls/view/widgets/signInButton.dart';

import '../widgets/myDialog.dart';
import '../widgets/mySnackBar.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> obscurePassword = ValueNotifier(true);
  ValueNotifier<bool> isChecked = ValueNotifier(false);




  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obscurePassword.dispose();
    isChecked.dispose();
    super.dispose();
  }

  late final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.asset(
              'lib/images/signIn.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 250),
            padding: const EdgeInsets.all(20),
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
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 90),
                  BuildTextField(
                    hint: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 30),
                  // BuildTextField(
                  //   hint:  'Password',
                  //   obscure: _obscurePassword,
                  //   toggleObscure: () {
                  //     setState(() {
                  //       _obscurePassword = !_obscurePassword;
                  //     });
                  //   },
                  // ),
                  ValueListenableBuilder<bool>(
                    valueListenable: obscurePassword, // المراقبة هنا
                    builder: (context, isObscure, _) {
                      return BuildTextField(
                        hint: 'Password',
                        obscure: isObscure,
                        controller: passwordController,
                        toggleObscure: () {
                          obscurePassword.value =
                              !obscurePassword.value; // قلب القيمة
                        },
                      );
                    },
                  ),


                  // Login Button

                  //const SignInButton(),

                  BlocConsumer<LoginCubit, Loginstate>(
                    listener: (context, state) {
                      if (state is loginSuccess) {
                        // عرض Dialog بعد انتهاء البناء
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          MyDialog(state.message, () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomNavBar()),
                              (Route<dynamic> route) => false,
                            );
                          }, context);
                        });
                      } else if (state is loginFailure) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          MySnackBar(state.message, context);
                        });
                      } else if (state is loginNeedVerify) {
                        userId = state.userId as int;
                        MyDialog(state.message, () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpScreen(userId: userId)),
                            (Route<dynamic> route) => false,
                          );
                        }, context);
                      }else if(state is loginForgetPassword){
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          MyDialog(state.message, () {
                            Navigator.pop(context);
                          }, context);
                        });
                      }else if(state is loginForgetPasswordFailure){
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          MyDialog(state.message, () {
                            Navigator.pop(context);
                          },  context);
                        });
                      }
                    },
                    builder: (context, state) {
                      return state is loginLoading
                          ? const Padding(
                            padding: EdgeInsets.all(120.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                          : Column(
                              children: [
                                ValueListenableBuilder<bool>(
                                  valueListenable: isChecked,
                                  builder: (context, value, _) {
                                    return CheckboxListTile(
                                      checkColor: Theme.of(context).iconTheme.color,
                                      title: Text("Remember me",style: TextStyle(fontSize: 15,color: Theme.of(context).iconTheme.color),),
                                      value: value,
                                      onChanged: (newValue) {
                                        isChecked.value = newValue!;
                                      },
                                      controlAffinity: ListTileControlAffinity.leading,
                                      contentPadding: EdgeInsets.zero,
                                    );
                                  },
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      if(emailController.text.isEmpty){
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          MySnackBar('The email field is required ', context);
                                        });
                                      }else{
                                        context.read<LoginCubit>().forgetPassword(email: emailController.text, context: context);
                                      }
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                SignInButton(
                                  onTap: () {
                                    if (emailController.text.isEmpty ||
                                        passwordController.text.isEmpty) {
                                      MySnackBar(
                                          'All fields are required', context,isError: true);
                                    } else {
                                      context.read<LoginCubit>().login(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            rememberMe: isChecked.value,
                                            context: context,
                                          );
                                    }
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'do not have an account yet?',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUp()),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                      child: Text(
                                        'SignUp',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
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
}
