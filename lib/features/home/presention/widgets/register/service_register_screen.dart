import 'package:shattably/features/auth/domain/auth_repository.dart';
import 'package:shattably/features/auth/domain/auth_use_cases.dart';
import 'package:shattably/features/auth/presentation/auth_cubits.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/widgets/login/service_login_screen.dart';

class ServiceRegisterScreen extends StatefulWidget {
  const ServiceRegisterScreen({super.key});

  @override
  State<ServiceRegisterScreen> createState() => _ServiceRegisterScreenState();
}

class _ServiceRegisterScreenState extends State<ServiceRegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final jobController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  File? file;


  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null && mounted) setState(() => file = File(photo.path));
  }

  @override
  void dispose() {
    for (final controller in [jobController,emailController,passwordController,nameController,
      phoneController,whatsappController,addressController,cityController]) { controller.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(RegisterAccount(context.read<AuthRepository>())),
      child: BlocConsumer<RegisterCubit, LoadState<void>>(
        listener: (context, state) async {
          if (state.status == LoadStatus.failure) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'خطأ',
              desc: state.failure!.message,
            ).show();
            return;
          }

          if (state.status == LoadStatus.success) {
            navigateTo(
              context,
              ServiceLoginScreen(),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7F7F7),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Page Icon or Logo
                        const Center(
                          child: Icon(
                            Icons.app_registration_rounded,
                            size: 100,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Header Text
                        const Text(
                          'انشاء حساب جديد',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'انشئ حسابك للاستمتاع بخدماتنا',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        // Name Field
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) return 'من فضلك, ادخل اسمك';
                            return null;
                          },
                          label: 'الاسم',
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 20),
                        // City Field
                        const Text(
                          'من فضلك, اختر محافظتك',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        AppTextField(
                          textEditingController: cityController,
                          title: "",

                          hint: "المحافظة",
                          isCitySelected: true,
                          titleTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                            color: Colors.white,
                          ),
                          hintTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal',
                            color: Colors.white,
                          ),
                          dataList: [
                            SelectedListItem(name: "القاهرة"),
                            SelectedListItem(name: "الجيزة"),
                            SelectedListItem(name: "الاسكندرية"),
                            SelectedListItem(name: "اسيوط"),
                            SelectedListItem(name: "دمياط"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Address Field
                        defaultFormField(
                          controller: addressController,
                          type: TextInputType.streetAddress,
                          validate: (value) {
                            if (value!.isEmpty) return 'من فضلك, ادخل عنوانك';
                            return null;
                          },
                          label: 'العنوان',
                          prefix: Icons.home_outlined,
                        ),
                        const SizedBox(height: 20),
                        // Email Field
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) return 'من فضلك, ادخل بريدك الالكتروني';
                            return null;
                          },
                          label: 'البريد الالكتروني',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(height: 20),
                        // Password Field
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) return 'كلمة المرور قصيرة جدا';
                            if (value.length < 8) {
                              return 'كلمة المرور يجب الا تقل عن 8 حروف';
                            }
                            return null;
                          },
                          isPassword: true,
                          label: 'كلمة المرور',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(height: 20),
                        // Phone Number Field
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) return 'من فضلك, ادخل رقم هاتفك';
                            return null;
                          },
                          label: 'رقم الهاتف',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 20),
                        // WhatsApp Field
                        defaultFormField(
                          controller: whatsappController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) return 'من ففضلك, ادخل رقم الواتساب الخاص بك';
                            return null;
                          },
                          label: 'الواتساب',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 20),
                        // Job Selection Field
                        const Text(
                          'من فضلك, اختر وظيفتك',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        AppTextField(
                          textEditingController: jobController,
                          title: "",
                          hint: "الوظيفة",
                          isCitySelected: true,
                          dataList: [
                            SelectedListItem(name: "مستخدم"),
                            SelectedListItem(name: "سيراميك"),
                            SelectedListItem(name: "كهربائي"),
                            SelectedListItem(name: "سباك"),
                            SelectedListItem(name: "نجار"),
                            SelectedListItem(name: "نقاش"),
                            SelectedListItem(name: "حداد"),
                            SelectedListItem(name: "باركية"),
                            SelectedListItem(name: "تكييف"),
                            SelectedListItem(name: "الموتال"),
                            SelectedListItem(name: "رخام"),
                          ],
                        ),
                        const SizedBox(height: 25),
                        // Image Upload Button
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await getImage();
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                            label: const Text('ارفع صورة شخصيك لك'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        if (file != null)
                          Center(
                            child: Image.file(
                              file!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(height: 30),
                        // Register Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (state.status != LoadStatus.loading && formKey.currentState!.validate()) {
                                context.read<RegisterCubit>().submit(Registration(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  whatsapp: whatsappController.text,
                                  address: addressController.text,
                                  job: jobController.text,
                                  city: cityController.text,
                                  photoPath: file?.path,
                                ));
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
                              'انشاء حساب',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Navigate to Login
                        Center(
                          child: TextButton(
                            onPressed: () {
                              navigateTo(context, ServiceLoginScreen());
                            },
                            child: const Text(
                              'هل لديك حساب بالفعل؟ سجل دخول من هنا',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
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
