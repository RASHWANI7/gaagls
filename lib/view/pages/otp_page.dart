import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/view/pages/customNavBar.dart';
import 'package:gaagls/view/pages/homePage.dart';
import '../../controller/cubits/otp_cubit/otp_cubit.dart';
import '../../controller/cubits/otp_cubit/otp_state.dart';
import '../widgets/myDialog.dart';
import '../widgets/mySnackBar.dart';
import '../widgets/otp_fields.dart';
import '../widgets/shaking_phone_image.dart';

class OtpScreen extends StatelessWidget {
  final int userId;
  const OtpScreen({super.key,required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.06,
                    vertical: MediaQuery.of(context).size.height * 0.06,),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'OTP Verification',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF143D5A),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const ShakingPhoneImage(),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),

                      const Text(
                        'Enter the code sent to your account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 3, 14, 20),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      const OtpFields(),
                      const SizedBox(height: 32),
                      BlocConsumer<OtpCubit, OtpState>(
                        listener: (context, state) {
                          if (state is OtpSuccess) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              MyDialog(state.message,(){
                                Navigator.pop(context);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) =>   CustomNavBar()), (Route<dynamic> route) => false,);
                              } ,context);
                            });

                          } else if (state is OtpFailure) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              MySnackBar(state.error, context);
                            });
                          }
                        },
                        builder: (context, state) {
                          if (state is OtpLoading) {
                            return const CircularProgressIndicator();
                          }else {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                print(userId);
                               // context.read<OtpCubit>().submitCode();
                                context.read<OtpCubit>().printOtp();
                                context.read<OtpCubit>().Otp(userId: userId, context: context);
                                },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF143D5A),
                              ),
                              child: const Text(
                                'Verify',
                                style: TextStyle(color: Color(0xFFF5F5DC)),
                              ),
                            ),
                          );
                          }
                        },
                      ),
                       const SizedBox(height: 15,),
                        BlocConsumer<OtpCubit,OtpState>(
                          listener: (context,state){
                            if(state is ResendOtpSuccess){
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                MyDialog(state.message,(){
                                  Navigator.pop(context);
                                } ,context);
                              });
                            }
                           else if(state is ResendOtpFailure){
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                               MySnackBar(state.error, context);
                             });
                            }
                          },
                          builder: (context,state){
                            if(state is OtpLoading){
                              return SizedBox();
                            }else {
                              return Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(onPressed: (){
                                  context.read<OtpCubit>().reSendOtp(userId: userId, context: context);
                                }, child: const Text('Resend Code',style: TextStyle(
                                  color: Color(0xFF145371),
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                ),)));
                            }
                          },
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}