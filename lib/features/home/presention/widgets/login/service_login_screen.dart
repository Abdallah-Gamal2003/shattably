import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shattably/features/auth/domain/auth_repository.dart';
import 'package:shattably/features/auth/domain/auth_use_cases.dart';
import 'package:shattably/features/auth/presentation/auth_cubits.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/widgets/register/service_register_screen.dart';
import 'package:shattably/home.dart';

class ServiceLoginScreen extends StatefulWidget {
  const ServiceLoginScreen({super.key});
  @override
  State<ServiceLoginScreen> createState() => _ServiceLoginScreenState();
}
class _ServiceLoginScreenState extends State<ServiceLoginScreen> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() { emailController.dispose(); passwordController.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(SignIn(context.read<AuthRepository>()), SendPasswordReset(context.read<AuthRepository>()), SendVerificationEmail(context.read<AuthRepository>())),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.signedIn && state.user!.emailVerified) {
            navigateAndFinish(context, const Home());
          } else if (state.status == LoginStatus.signedIn) {
            AwesomeDialog(context: context, dialogType: DialogType.warning,
              title: 'التوثيق الزامي', desc: 'من فضلك, يرجى توثيق الايميل الخاص بك',
              btnOkText: 'Resend verification',
              btnOkOnPress: () => context.read<LoginCubit>().sendVerification()).show();
          } else if (state.status == LoginStatus.failure) {
            AwesomeDialog(context: context, dialogType: DialogType.error,
              title: 'خطأ', desc: state.failure!.message).show();
          } else if (state.status == LoginStatus.resetSent || state.status == LoginStatus.verificationSent) {
            AwesomeDialog(context: context, dialogType: DialogType.success,
              title: 'تم بنجاح', desc: 'Please check your email.').show();
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
                          suffix: state.obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          suffixPressed: context.read<LoginCubit>().changePasswordVisibility,
                          isPassword: context.read<LoginCubit>().isPassword,
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
                            onPressed: () => context.read<LoginCubit>().resetPassword(emailController.text),
                            child: const Text('هل نسيت كلمة المرور؟',style: TextStyle(color: Colors.green),),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Login Button
                        ConditionalBuilder(
                          condition: state.status != LoginStatus.loading,
                          builder: (context) => ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginCubit>().userLogin(
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
