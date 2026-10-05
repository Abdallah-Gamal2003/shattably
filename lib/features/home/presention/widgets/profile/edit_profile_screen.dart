import 'package:shattably/features/profile/domain/profile_repository.dart';
import 'package:shattably/features/profile/domain/profile_use_cases.dart';
import 'package:shattably/features/profile/presentation/profile_cubits.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/components/components.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.profile});
  final UserProfile profile;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}
class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final jobController = TextEditingController();
  final cityController = TextEditingController();
  final whatsappController = TextEditingController();
  File? profileImage;
  late final EditProfileCubit _cubit;
  @override
  void initState() {
    super.initState();
    final profile = widget.profile;
    nameController.text = profile.name;
    emailController.text = profile.email;
    phoneController.text = profile.phone;
    addressController.text = profile.address;
    jobController.text = profile.job;
    cityController.text = profile.city;
    whatsappController.text = profile.whatsapp;
    final repository = context.read<ProfileRepository>();
    _cubit = EditProfileCubit(profile, UpdateProfile(repository), UpdateProfilePhoto(repository));
  }
  @override
  void dispose() {
    for (final controller in [nameController,emailController,phoneController,addressController,
      jobController,cityController,whatsappController]) { controller.dispose(); }
    _cubit.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => BlocConsumer<EditProfileCubit, LoadState<UserProfile>>(
    bloc: _cubit,
    listener: (context, state) {
      if (state.status == LoadStatus.success) {
        context.read<ProfileCubit>().load();
        Navigator.pop(context);
      } else if (state.status == LoadStatus.failure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure!.message)));
      }
    },
    builder: (context, state) {
      final userModel = state.data!;
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(color: Colors.green),
                title: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                centerTitle: true,
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (state.status == LoadStatus.loading)
                        const LinearProgressIndicator(),
                      if (state.status == LoadStatus.loading)
                        const SizedBox(
                          height: 10.0,
                        ),
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(userModel.image)
                                      : FileImage(profileImage!)
                                          as ImageProvider,
                                  backgroundColor: Colors.white,
                                ),
                                IconButton(
                                  icon: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 14.0,
                                    child: Icon(Icons.edit,
                                        size: 16.0, color: Colors.green),
                                  ),
                                  onPressed: () async {
                                    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                                    if (picked != null && mounted) setState(() => profileImage = File(picked.path));
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              userModel.name,
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Column(
                        children: [
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return ('الاسم يجب الا تكون فارغة');
                              }

                              return null;
                            },
                            label: 'الاسم',
                            prefix: Icons.person,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: emailController,
                            isClickable: false,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return ('البريد الالكتروني يجب الا تكون فارغة');
                              }
                              return null;
                            },
                            label: 'البريد الالكتروني',
                            prefix: Icons.email,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return ('رقم التليفون يجب الا تكون فارغة');
                              }
                              return null;
                            },
                            label: 'رقم التليفون',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: whatsappController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return ('رقم التليفون يجب الا تكون فارغة');
                              }
                              return null;
                            },
                            label: 'رقم التليفون',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          AppTextField(
                            textEditingController: jobController,
                            title: "ادخل وظيفتك",
                            hint: "الوظيفة",
                            isCitySelected: true,
                            dataList: [
                              SelectedListItem(name: "نجار"),
                              SelectedListItem(name: "سباك"),
                              SelectedListItem(name: "كهربائي"),
                              SelectedListItem(name: "مقاول"),
                              SelectedListItem(name: "مستخدم"),
                              SelectedListItem(name: "نقاش"),
                              SelectedListItem(name: "حداد"),
                              SelectedListItem(name: "باركية"),
                              SelectedListItem(name: "تكييف"),
                              SelectedListItem(name: "الموتال"),
                              SelectedListItem(name: "رخام"),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          AppTextField(
                            textEditingController: cityController,
                            title: "Enter your city",
                            hint: "city",
                            isCitySelected: true,
                            dataList: [
                              SelectedListItem(name: "القاهرة"),
                              SelectedListItem(name: "الجيزة"),
                              SelectedListItem(name: "الاسكندرية"),
                              SelectedListItem(name: "اسيوط"),
                              SelectedListItem(name: "دمياط"),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: addressController,
                            type: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return ('العنوان يجب الا تكون فارغ');
                              }
                              return null;
                            },
                            label: 'العنوان',
                            prefix: Icons.maps_home_work_outlined,
                          ),
                          // SizedBox(
                          //   height: 20.0,
                          // ),
                          // defaultFormField(
                          //   controller: locationlink,
                          //   type: TextInputType.text,
                          //   validate: (String? value) {
                          //     if (value!.isEmpty) {
                          //       return ('العنوان يجب الا تكون فارغ');
                          //     }
                          //     return null;
                          //   },
                          //   label: 'العنوان',
                          //   prefix: Icons.location_city_outlined,
                          //),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // if (formKey.currentState!.validate()) {
                                _cubit.save(ProfileChanges(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  address: addressController.text,
                                  job: jobController.text,
                                  city: cityController.text,
                                  whatsapp: whatsappController.text,
                                ), photoPath: profileImage?.path);
                              //}
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Update Profile',
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // defaultButton(
                          //   text: 'تعديل البيانات',
                          //
                          //   function: () {
                          //     _cubit.save(ProfileChanges(
                          //       name: nameController.text,
                          //       phone: phoneController.text,
                          //       email: emailController.text,
                          //       address: addressController.text,
                          //       job: jobController.text,
                          //       city: cityController.text,
                          //       whatsapp: whatsappController.text,
                          //       // locationlink: locationlink.text,
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
    },
  );
}
