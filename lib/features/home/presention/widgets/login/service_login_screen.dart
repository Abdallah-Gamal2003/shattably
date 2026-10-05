// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:shattably/components/components.dart';
// import 'package:shattably/features/home/presention/widgets/login/cubit/cubit.dart';
// import 'package:shattably/features/home/presention/widgets/login/cubit/states.dart';
// import 'package:shattably/features/home/presention/widgets/register/service_register_screen.dart';
// import 'package:shattably/home.dart';
// import 'package:shattably/network/local/cache_helper.dart';
// import 'package:flutter/services.dart';
//
//
// class ServiceLoginScreen extends StatelessWidget {
//   ServiceLoginScreen({Key? key}) : super(key: key);
//
//   final formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return BlocProvider(
//       create: (BuildContext context) => ServiceLoginCubit(),
//       child: BlocConsumer<ServiceLoginCubit, ServiceLoginStates>(
//         listener: (context, state) async {
//           if (state is ServiceLoginErrorState) {
//             AwesomeDialog(
//               context: context,
//               dialogType: DialogType.error,
//               animType: AnimType.rightSlide,
//               title: 'حدث خطأ',
//               desc:
//               'يوجد خطا في البيانات المدخلة. برجاء ادخال البيانات صحيحة',
//             ).show();
//             return;
//           }
//
//           if (state is ServiceLoginSuccessState
//              ) {
//             final credential =
//             await FirebaseAuth.instance.signInWithEmailAndPassword(
//               email: emailController.text,
//               password: passwordController.text,
//             );
//             if( credential.user!.emailVerified) {
//
//               CacheHelper.saveData(
//                 key: 'uId',
//                 value: state.uId,
//               ).then((value) {
//                 navigateAndFinish(context, Home());
//               });
//             }
//             else
//               {
//                 AwesomeDialog(
//                   context: context,
//                   dialogType: DialogType.error,
//                   animType: AnimType.rightSlide,
//                   title: 'حدث خطأ',
//                   desc:
//                   'هذا الايميل لم يتم التحقق منه من خلال اللينك المرسل',
//                 ).show();
//                 return;
//               }
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: Colors.white, // Setting background color to grey
//             body: Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'login',
//                           style:
//                               Theme.of(context).textTheme.headline4?.copyWith(
//                                     color: Colors.black,
//                                 fontFamily: 'Tajawal',
//                                   ),
//                         ),
//                         Text(
//                           'now to see our different services ',
//                           style:
//                               Theme.of(context).textTheme.bodyText1?.copyWith(
//                                 color: Colors.black,
//                                 fontFamily: 'Tajawal',
//                                   ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         defaultFormField(
//                           autoFocus: true,
//                           controller: emailController,
//                           type: TextInputType.emailAddress,
//                           validate: (value) {
//                             if (value!.isEmpty) {
//                               return ('please enter your email address');
//                             }
//                             return null;
//                           },
//                           label: 'email address',
//                           prefix: Icons.email_outlined,
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultFormField(
//                           controller: passwordController,
//                           type: TextInputType.visiblePassword,
//                           suffix: ServiceLoginCubit.get(context).suffix,
//                           onSubmit: (value) {
//                             if (formKey.currentState!.validate()) {
//                               ServiceLoginCubit.get(context).userLogin(
//                                 email: emailController.text,
//                                 password: passwordController.text,
//                               );
//                             }
//                           },
//                           validate: (value) {
//                             if (value!.isEmpty) {
//                               return ('password is too short');
//                             }
//                             return null;
//                           },
//                           isPassword: ServiceLoginCubit.get(context).isPassword,
//                           label: 'password',
//                           prefix: Icons.lock_outline,
//                         ),
//                         InkWell(
//                           onTap: () async {
//                             if(emailController.text=="")
//                               {
//                                 if (!context.mounted) return;
//                                 AwesomeDialog(
//                                   context: context,
//                                   dialogType: DialogType.error,
//                                   animType: AnimType.rightSlide,
//                                   title: 'حدث خطأ',
//                                   desc: 'برجاء كتابة البريد الالكتروني اولا',
//                                 ).show();
//                                 return;
//                               }
//                             try
//                             {
//                               await FirebaseAuth.instance.sendPasswordResetEmail(
//                                   email: emailController.text);
//                               AwesomeDialog(
//                                 context: context,
//                                 dialogType: DialogType.success,
//                                 animType: AnimType.rightSlide,
//                                 title: 'تم بنجاح',
//                                 desc: 'لقد تم ارسال لينك لاعادة تعيين كلمة المرور',
//                               ).show();
//                             }catch(e)
//                             {
//                               AwesomeDialog(
//                                 context: context,
//                                 dialogType: DialogType.error,
//                                 animType: AnimType.rightSlide,
//                                 title: 'Error',
//                                 desc: 'برجاءالتاكد من البريد الالكتروني',
//                               ).show();
//                               return;
//                             }
//
//
//                           },
//
//
//                           child: Container(
//                             margin: const EdgeInsets.only(top: 20, bottom: 20),
//                             alignment: Alignment.topRight,
//                             child: const Text(
//                               "Forgot Password ?",
//
//                               style: TextStyle(
//                                 fontFamily: 'Tajawal',
//                                 fontSize: 15 ,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30.0,
//                         ),
//                         ConditionalBuilder(
//                           condition: state is! ServiceLoginLoadingState,
//                           builder: (context) => Center(
//                             child: defaultButton(
//                               function: () async {
//                                 {
//                                   if (formKey.currentState!.validate()) {
//                                     ServiceLoginCubit.get(context).userLogin(
//                                     email: emailController.text,
//                                     password: passwordController.text,
//                                     );
//
//
//                                   }
//                                 }
//                                 // navigateAndFinish(context, ServiceLayout());
//                               },
//                               text: 'login',
//                               isUpperCase: true,
//                             ),
//                           ),
//                           fallback: (context) => Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'dont have an account?',
//                               style: TextStyle(
//                                 fontFamily: 'Tajawal',
//                                 fontSize: 20 ,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 //Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceRegisterScreen(),),);
//                                 navigateTo(context, ServiceRegisterScreen());
//                               },
//                               child: Text("REGISTER",style: TextStyle(fontFamily: 'Tajawal',color: Colors.black),),
//
//
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 25.0,
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// //
// // class LoginScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Padding(
// //         padding: EdgeInsets.all(20.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
// //             SizedBox(height: 20),
// //             /*ElevatedButton.icon(
// //               onPressed: () {},
// //               icon: Icon(Icons.apple),
// //               label: Text("Login with Apple"),
// //             ),
// //             ElevatedButton.icon(
// //               onPressed: () {},
// //               icon: Icon(Icons.login),
// //               label: Text("Login with Google"),
// //             )*/
// //             SizedBox(height: 10),
// //             TextField(
// //               decoration: InputDecoration(labelText: 'اكتب الايميل', border: OutlineInputBorder()),
// //             ),
// //             SizedBox(height: 10),
// //             TextField(
// //               decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
// //               obscureText: true, // لإخفاء كلمة المرور
// //             ),
// //             Align(
// //               alignment: Alignment.centerRight,
// //               child: TextButton(
// //                 onPressed: () {},
// //                 child: Text('Forgot Password?'),
// //               ),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () {},
// //               child: Text("Login"),
// //             ),
// //             SizedBox(height: 20),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Text("Don’t have an account?"),
// //                 TextButton(
// //                   onPressed: () {
// //                     Navigator.pushNamed(context, '/signup');
// //                   },
// //                   child: Text("Sign up"),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/widgets/login/cubit/cubit.dart';
import 'package:shattably/features/home/presention/widgets/login/cubit/states.dart';
import 'package:shattably/features/home/presention/widgets/register/service_register_screen.dart';
import 'package:shattably/home.dart';
import 'package:shattably/network/local/cache_helper.dart';

class ServiceLoginScreen extends StatelessWidget {
  ServiceLoginScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ServiceLoginCubit(),
      child: BlocConsumer<ServiceLoginCubit, ServiceLoginStates>(
        listener: (context, state) async {
          if (state is ServiceLoginErrorState) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'خطأ',
              desc: 'من فضلك, اددخل البيانات الصحيحة',
            ).show();
          }

          if (state is ServiceLoginSuccessState) {
            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
            if (!context.mounted) return;
            if (credential.user!.emailVerified) {
              CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                if (!context.mounted) return;
                navigateAndFinish(context, const Home());
              });
            } else {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                title: 'التوثيق الزامي',
                desc: 'من فضلك, يرجى توثيق الايميل الخاص بك',
              ).show();
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F7F7),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // App logo or Icon
                        const Center(
                          child: Icon(
                            Icons.login_rounded,
                            size: 100,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Welcome text
                        const Text(
                          '!مرحبا',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'سجل دخولك لاستخدام حسابك',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        // Email Input
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك, ادخل اسم السمتخدم';
                            }
                            return null;
                          },
                          label: 'البريد الالكتروني',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(height: 20),
                        // Password Input
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ServiceLoginCubit.get(context).suffix,
                          isPassword: ServiceLoginCubit.get(context).isPassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'كلمة المرور الزامية';
                            }
                            return null;
                          },
                          label: 'كلمة المرور',
                          prefix: Icons.lock_outline,
                        ),
                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () async {
                              if (emailController.text.isEmpty) {
                                if (!context.mounted) return;
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'خطأ',
                                  desc: 'من فضلك, ادخل ايميلك اولا',
                                ).show();
                                return;
                              }

                              try {
                                await FirebaseAuth.instance.sendPasswordResetEmail(
                                  email: emailController.text,
                                );
                                if (!context.mounted) return;
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  title: 'تم بنجاح',
                                  desc: 'تم ارسال رابط لاعادة تعيين كلمة مرور جيدة',
                                ).show();
                              } catch (e) {
                                if (!context.mounted) return;
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.rightSlide,
                                  title: 'خطأ',
                                  desc: 'البريد الالكتروني غير صحيح',
                                ).show();
                              }
                            },
                            child: const Text('هل نسيت كلمة المرور؟',style: TextStyle(color: Colors.green),),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Login Button
                        ConditionalBuilder(
                          condition: state is! ServiceLoginLoadingState,
                          builder: (context) => ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ServiceLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors.green,
                            ),
                            child: const Text(
                              'تسجيل دخول',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Sign Up Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [                           TextButton(
                            onPressed: () {
                              navigateTo(context, const ServiceRegisterScreen());
                            },
                            child: const Text(
                              'انشاء حساب',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                            const Text(
                              "ليس لديك حساب؟",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

