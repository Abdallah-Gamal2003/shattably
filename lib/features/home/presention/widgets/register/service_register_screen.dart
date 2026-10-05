// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:drop_down_list/model/selected_list_item.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shattably/components/custom_button_auth.dart';
// import 'package:shattably/components/custom_logo_auth.dart';
// import 'package:shattably/components/custom_text_form.dart';
// import 'package:shattably/components/components.dart';
// import 'package:shattably/features/home/presention/layout/service_layout_screen.dart';
// import 'package:shattably/features/home/presention/widgets/login/service_login_screen.dart';
// import 'package:shattably/features/home/presention/widgets/register/cubit/cubit.dart';
// import 'package:shattably/features/home/presention/widgets/register/cubit/states.dart';
// import 'package:shattably/home.dart';
//
// class ServiceRegisterScreen extends StatefulWidget {
//   const ServiceRegisterScreen({super.key});
//
//   State<ServiceRegisterScreen> createState() => _ServiceRegisterScreenState();
// }
//
// class _ServiceRegisterScreenState extends State<ServiceRegisterScreen> {
//   final formKey = GlobalKey<FormState>();
//   final jobController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final whatsappController = TextEditingController();
//   final addressController = TextEditingController();
//   final cityController = TextEditingController();
//    //var locationlink = TextEditingController();
//   File? file;
//   String? url;
//
//   getImage() async {
//
//     final ImagePicker picker = ImagePicker();
//     //final XFile? image=await picker.pickImage(source: ImageSource.gallery);
//     final XFile? photo = await picker.pickImage(source: ImageSource.camera);
//     if (photo != null) {
//       var storage = FirebaseStorage.instance;
//       var storageRef = storage.ref();
//       var imagesRef = storageRef.child('${basename(photo!.path)}');
//       var selectedImage = File(photo.path);
//       var uploadTask = imagesRef.putFile(selectedImage);
//       await (await uploadTask).ref.getDownloadURL().then((value) {
//         setState(() {
//           url = value;
//         });
//       });
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ServiceRegisterCubit(),
//       child: BlocConsumer<ServiceRegisterCubit, ServiceRegisterStates>(
//         listener: (context, state) async {
//           if (state is ServiceRegisterErrorState) {
//             AwesomeDialog(
//               context: context,
//               dialogType: DialogType.error,
//               animType: AnimType.rightSlide,
//               title: 'حدث خطأ',
//               desc: 'الايميل مستخدم بالفعل او كلمة المرور ضعيفة',
//             )..show();
//             return;
//             // late String e;
//             // e= ServiceCreateUserErrorState(e.code).error;
//             //   try {
//             //     // final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//             //     //   email: emailController.text,
//             //     //   password: passwordController.text,
//             //     // );
//             //
//             //   } on FirebaseAuthException catch (e) {
//             //     if (e.code == 'weak-password') {
//             //       AwesomeDialog(
//             //         context: context,
//             //         dialogType: DialogType.error,
//             //         animType: AnimType.rightSlide,
//             //         title: 'Error',
//             //         desc: 'weak password',
//             //       )..show();
//             //     } else if (e.code == 'email-already-in-use') {
//             //       AwesomeDialog(
//             //         context: context,
//             //         dialogType: DialogType.error,
//             //         animType: AnimType.rightSlide,
//             //         title: 'Error',
//             //         desc: 'this email is already in use',
//             //       )..show();
//             //     }
//             //   } catch (e) {
//             //     debugPrint(e);
//             //   }
//           }
//
//           if (state is ServiceRegisterCreateUserSuccessState) {
//             navigateTo(
//               context,
//               ServiceLoginScreen(),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: Colors.white, // Setting background color to grey
//
//             appBar: AppBar(
//               bottomOpacity: 0,
//               elevation: 0,
//               backgroundColor: Colors.transparent, // Setting background color to grey
//
//
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'REGISTER',
//                           style:
//                               Theme.of(context).textTheme.headline4?.copyWith(
//                                     fontFamily: 'Tajawal',
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//
//                                   ),
//                         ),
//                         Text(
//                           'Register now to start the services',
//                           style:
//                               Theme.of(context).textTheme.bodyText1?.copyWith(
//                                     color: Colors.black,
//                                 fontFamily: 'Tajawal',
//
//                                   ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         defaultFormField(
//                           controller: nameController,
//                           type: TextInputType.name,
//                           validate: (value) {
//                             if (value!.isEmpty)
//                               return ('please enter your name');
//                             return null;
//                           },
//                           label: 'User Name',
//                           prefix: Icons.person,
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text('ادخل مدينتك ',
//                           style: TextStyle(
//                             fontFamily: 'Tajawal',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//
//                           ),
//
//                         ),
//                         AppTextField(
//                           textEditingController: cityController,
//                           title: "",
//
//                           hint: "المدينه",
//                           isCitySelected: true,
//                           titleTextStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                             color: Colors.white,
//                           ),
//                           hintTextStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Tajawal',
//                             color: Colors.white,
//                           ),
//                           dataList: [
//                             SelectedListItem(name: "القاهرة"),
//                             SelectedListItem(name: "الجيزة"),
//                             SelectedListItem(name: "الاسكندرية"),
//                             SelectedListItem(name: "اسيوط"),
//                             SelectedListItem(name: "دمياط"),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultFormField(
//                           controller: addressController,
//                           type: TextInputType.streetAddress,
//                           validate: (value) {
//                             if (value!.isEmpty)
//                               return ('الرجاء ادخال العنوان');
//                             return null;
//                           },
//                           label: 'Address',
//                           prefix: Icons.maps_home_work_outlined,
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultFormField(
//                           controller: emailController,
//                           type: TextInputType.emailAddress,
//                           validate: (value) {
//                             if (value!.isEmpty)
//                               return ('الرجاء ادخال البريد الالكتروني');
//                             return null;
//                           },
//                           label: 'Email Address',
//                           prefix: Icons.email_outlined,
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultFormField(
//                           suffixPressed: () {
//                             ServiceRegisterCubit.get(context)
//                                 .changePasswordVisibility();
//                           },
//                           controller: passwordController,
//                           type: TextInputType.visiblePassword,
//                           suffix: ServiceRegisterCubit.get(context).suffix,
//                           validate: (value) {
//                             if (value!.isEmpty)
//                               return ('password is too short.');
//
//
//                             if (value.length < 8 && !RegExp(r'[0-9]').hasMatch(value) && !RegExp(r'[a-z]').hasMatch(value)) {
//                               return 'Password must be at least 8 characters long and include at least one letter and one digit';
//                             }
//                             return null;
//                           },
//                           isPassword:
//                               ServiceRegisterCubit.get(context).isPassword,
//                           label: 'Password',
//                           prefix: Icons.lock_outline,
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultFormField(
//                           controller: phoneController,
//                           type: TextInputType.phone,
//                           validate: (value) {
//                             if (value!.isEmpty) {
//                               return ('الرجاء ادخال رقم التليفون');
//                             }
//                             return null;
//                           },
//                           label: 'رقم التليفون',
//                           prefix: Icons.phone,
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultFormField(
//                           controller: whatsappController,
//                           type: TextInputType.phone,
//                           validate: (value) {
//                             if (value!.isEmpty) {
//                               return ('الرجاء ادخال رقم الواتس اب');
//                             }
//                             return null;
//                           },
//                           label: 'رقم الواتس اب',
//                           prefix: Icons.phone,
//                         ),
//                         SizedBox(
//                           height: 20.0,
//                         ),
//
//                         Text('ادخل وظيفتك ',
//                           style: TextStyle(
//                             fontFamily: 'Tajawal',
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//
//                           ),
//
//                         ),
//                         AppTextField(
//                           textEditingController: jobController,
//                           title: "",
//                           hint: "الوظيفة",
//                           isCitySelected: true,
//                           dataList: [
//                             SelectedListItem(name: "مستخدم عادي"),
//                             SelectedListItem(name: "مقاول"),
//                             SelectedListItem(name: "كهربائي"),
//                             SelectedListItem(name: "سباك"),
//                             SelectedListItem(name: "نجار"),
//                             SelectedListItem(name: "نقاش"),
//                             SelectedListItem(name: "حداد"),
//                             SelectedListItem(name: "باركية"),
//                             SelectedListItem(name: "تكييف"),
//                             SelectedListItem(name: "الموتال"),
//                             SelectedListItem(name: "رخام"),
//                           ],
//                         ),
//                         // SizedBox(
//                         //   height: 30,
//                         // ),
//                         // defaultFormField(
//                         //   controller: locationlink,
//                         //   type: TextInputType.url,
//                         //   validate: (value) {
//                         //     if (value!.isEmpty) {
//                         //       return ('please enter your location link');
//                         //     }
//                         //     return null;
//                         //   },
//                         //   label: 'location',
//                         //   prefix: Icons.location_city_outlined,
//                         // ),
//
//                         SizedBox(
//                           height: 25.0,
//                         ),
//
//                         Center(
//                           child: defaultButton(
//                               function: () async {
//                                 await getImage();
//                               },
//                               text: 'التقاط صورة'),
//                         ),
//                         if (url != null)
//                           Center(
//                             child: Image.network(
//
//                               url!,
//                               width: 200,
//                               height: 200,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//
//                         SizedBox(
//                           height: 25.0,
//                         ),
//
//                         Center(
//                           child: defaultButton(
//                               function: () {
//
//                                 if (formKey.currentState!.validate()) {
//                                   ServiceRegisterCubit.get(context).userRegister(
//                                       name: nameController.text,
//                                       email: emailController.text,
//                                       password: passwordController.text,
//                                       phone: phoneController.text,
//                                       whatsapp: whatsappController.text,
//                                       address: addressController.text,
//                                       job: jobController.text,
//                                       city: cityController.text,
//                                     //  locationlink: locationlink.toString(),
//                                       image: url.toString());
//                                 }
//
//                               },
//                               text: 'REGISTER'),
//                         ),
//                         if (file != null)
//                           Image.file(
//                             file!,
//                             width: 200,
//                             height: 200,
//                             fit: BoxFit.fill,
//                           ),
//                         SizedBox(height: 100,),
//
//                         // ElevatedButton(
//                         //   onPressed: () {
//                         //     addUser();
//                         //     navigateTo(context, ServiceLayout());
//                         //   },
//                         //   child: Text("REGISTER"),
//                         // ),
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

import 'dart:io';
import 'package:path/path.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/widgets/login/service_login_screen.dart';
import 'package:shattably/features/home/presention/widgets/register/cubit/cubit.dart';
import 'package:shattably/features/home/presention/widgets/register/cubit/states.dart';

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
  String? url;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      var storage = FirebaseStorage.instance;
      var storageRef = storage.ref();
      var imagesRef = storageRef.child(basename(photo.path));
      var selectedImage = File(photo.path);
      var uploadTask = imagesRef.putFile(selectedImage);
      await (await uploadTask).ref.getDownloadURL().then((value) {
        setState(() {
          url = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceRegisterCubit(),
      child: BlocConsumer<ServiceRegisterCubit, ServiceRegisterStates>(
        listener: (context, state) async {
          if (state is ServiceRegisterErrorState) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'خطأ',
              desc: 'هذا الحساب مستخدم من قبل او كلمة المرور ضعيفة',
            ).show();
            return;
          }

          if (state is ServiceRegisterCreateUserSuccessState) {
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
                          isPassword: ServiceRegisterCubit.get(context).isPassword,
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
                        if (url != null)
                          Center(
                            child: Image.network(
                              url!,
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
                              if (formKey.currentState!.validate()) {
                                ServiceRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  whatsapp: whatsappController.text,
                                  address: addressController.text,
                                  job: jobController.text,
                                  city: cityController.text,
                                  image: url.toString(),
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
