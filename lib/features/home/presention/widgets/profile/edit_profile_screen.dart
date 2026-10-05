import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/core/utils/styles.dart';
import 'package:shattably/features/home/presention/layout/cubit/cubit.dart';
import 'package:shattably/features/home/presention/layout/cubit/states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var jobController = TextEditingController();
  var cityController = TextEditingController();
  var whatsappController = TextEditingController();
  // var locationlink = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = ServiceCubit.get(context).userModel;
        var profileImage = ServiceCubit.get(context).profileImage;

        nameController.text = userModel!.name;
        phoneController.text = userModel!.phone;
        emailController.text = userModel!.email;
        addressController.text = userModel!.address;
        cityController.text = userModel!.city;
        jobController.text = userModel!.job;
        whatsappController.text = userModel!.whatsapp;
        //locationlink.text = userModel!.locationlink;

        return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var userModel = ServiceCubit.get(context).userModel;
            var profileImage = ServiceCubit.get(context).profileImage;

            nameController.text = userModel!.name;
            phoneController.text = userModel!.phone;
            emailController.text = userModel!.email;
            addressController.text = userModel!.address;
            cityController.text = userModel!.city;
            jobController.text = userModel!.job;
            whatsappController.text = userModel!.whatsapp;
            //locationlink.text = userModel!.locationlink;

            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.green),
                title: Text(
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
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (state is ServiceUserUpdateLoadingState)
                        LinearProgressIndicator(),
                      if (state is ServiceUserUpdateLoadingState)
                        SizedBox(
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
                                      ? NetworkImage('${userModel.image}')
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                  backgroundColor: Colors.white,
                                ),
                                IconButton(
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 14.0,
                                    child: Icon(Icons.edit,
                                        size: 16.0, color: Colors.green),
                                  ),
                                  onPressed: () {
                                    ServiceCubit.get(context).getProfileImage();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${userModel.name}',
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
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
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: emailController,
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
                          SizedBox(
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
                          SizedBox(
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
                          SizedBox(
                            height: 20.0,
                          ),
                          AppTextField(
                            textEditingController: jobController,
                            title: "ادخل وظيفتك",
                            hint: "الوظيفة",
                            isCitySelected: true,
                            DataList: [
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
                          SizedBox(
                            height: 20.0,
                          ),
                          AppTextField(
                            textEditingController: cityController,
                            title: "Enter your city",
                            hint: "city",
                            isCitySelected: true,
                            DataList: [
                              SelectedListItem(name: "القاهرة"),
                              SelectedListItem(name: "الجيزة"),
                              SelectedListItem(name: "الاسكندرية"),
                              SelectedListItem(name: "اسيوط"),
                              SelectedListItem(name: "دمياط"),
                            ],
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // if (formKey.currentState!.validate()) {
                                ServiceCubit.get(context).updateUser(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  address: addressController.text,
                                  job: jobController.text,
                                  city: cityController.text,
                                  whatsapp: whatsappController.text,
                                );
                              //}
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
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
                          //     ServiceCubit.get(context).updateUser(
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
        ;
      },
    );
  }
}

// class EditProfileScreen extends StatelessWidget {
//   EditProfileScreen({Key? key}) : super(key: key);
//
//   final formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final addressController = TextEditingController();
//   final jobController = TextEditingController();
//   final cityController = TextEditingController();
//   final whatsappController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ServiceCubit, ServiceLayoutStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var userModel = ServiceCubit.get(context).userModel;
//         var profileImage = ServiceCubit.get(context).profileImage;
//
//         // Pre-populating the text controllers with user data
//         nameController.text = userModel!.name;
//         phoneController.text = userModel!.phone;
//         emailController.text = userModel!.email;
//         addressController.text = userModel!.address;
//         cityController.text = userModel!.city;
//         jobController.text = userModel!.job;
//         whatsappController.text = userModel!.whatsapp;
//
//         return Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             iconTheme: IconThemeData(color: Colors.green),
//             title: Text(
//               'Edit Profile',
//               style: TextStyle(
//                 fontFamily: 'Tajawal',
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//             centerTitle: true,
//           ),
//           backgroundColor: Color(0xFFF7F7F7),
//           body: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 if (state is ServiceUserUpdateLoadingState)
//                   LinearProgressIndicator(),
//                 SizedBox(height: 20),
//                 _buildProfileHeader(userModel, profileImage, context),
//                 SizedBox(height: 30),
//                 _buildFormFields(context),
//                 SizedBox(height: 30),
//                 _buildUpdateButton(context),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildProfileHeader(userModel, profileImage, BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Stack(
//             alignment: AlignmentDirectional.bottomEnd,
//             children: [
//               CircleAvatar(
//                 radius: 60.0,
//                 backgroundImage: profileImage == null
//                     ? NetworkImage('${userModel.image}')
//                     : FileImage(profileImage) as ImageProvider,
//                 backgroundColor: Colors.white,
//               ),
//               IconButton(
//                 icon: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 14.0,
//                   child: Icon(Icons.edit, size: 16.0, color: Colors.green),
//                 ),
//                 onPressed: () {
//                   ServiceCubit.get(context).getProfileImage();
//                 },
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Text(
//             '${userModel.name}',
//             style: TextStyle(
//               fontFamily: 'Tajawal',
//               fontSize: 26,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFormFields(BuildContext context) {
//     return Column(
//       children: [
//         _buildTextField(
//           controller: nameController,
//           label: 'Name',
//           prefixIcon: Icons.person,
//           keyboardType: TextInputType.name,
//         ),
//         SizedBox(height: 20),
//         _buildTextField(
//           controller: emailController,
//           label: 'Email',
//           prefixIcon: Icons.email,
//           keyboardType: TextInputType.emailAddress,
//         ),
//         SizedBox(height: 20),
//         _buildTextField(
//           controller: phoneController,
//           label: 'Phone',
//           prefixIcon: Icons.phone,
//           keyboardType: TextInputType.phone,
//         ),
//         SizedBox(height: 20),
//         _buildTextField(
//           controller: whatsappController,
//           label: 'WhatsApp',
//           prefixIcon: Icons.messenger_outlined,
//           keyboardType: TextInputType.phone,
//         ),
//         SizedBox(height: 20),
//         _buildDropDownField(
//           controller: jobController,
//           title: "Enter Your Job",
//           hint: "Job",
//           dataList: [
//             SelectedListItem(name: "Carpenter"),
//             SelectedListItem(name: "Plumber"),
//             SelectedListItem(name: "Electrician"),
//             SelectedListItem(name: "Contractor"),
//             SelectedListItem(name: "User"),
//           ],
//         ),
//         SizedBox(height: 20),
//         _buildDropDownField(
//           controller: cityController,
//           title: "Enter Your City",
//           hint: "City",
//           dataList: [
//             SelectedListItem(name: "Cairo"),
//             SelectedListItem(name: "Giza"),
//             SelectedListItem(name: "Alexandria"),
//             SelectedListItem(name: "Assiut"),
//             SelectedListItem(name: "Damietta"),
//           ],
//         ),
//         SizedBox(height: 20),
//         _buildTextField(
//           controller: addressController,
//           label: 'Address',
//           prefixIcon: Icons.home,
//           keyboardType: TextInputType.text,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData prefixIcon,
//     required TextInputType keyboardType,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       style: TextStyle(
//         fontFamily: 'Tajawal',
//         fontSize: 18,
//         color: Colors.black87,
//       ),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(
//           fontFamily: 'Tajawal',
//           color: Colors.green,
//         ),
//         prefixIcon: Icon(prefixIcon, color: Colors.green),
//         border: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.green),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDropDownField({
//     required TextEditingController controller,
//     required String title,
//     required String hint,
//     required List<SelectedListItem> dataList,
//   }) {
//     return AppTextField(
//       textEditingController: controller,
//       title: title,
//       hint: hint,
//       isCitySelected: true,
//       DataList: dataList,
//     );
//   }
//
//   Widget _buildUpdateButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         if (formKey.currentState!.validate()) {
//           ServiceCubit.get(context).updateUser(
//             name: nameController.text,
//             phone: phoneController.text,
//             email: emailController.text,
//             address: addressController.text,
//             job: jobController.text,
//             city: cityController.text,
//             whatsapp: whatsappController.text,
//           );
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         primary: Colors.green,
//         padding: EdgeInsets.symmetric(vertical: 15),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//       ),
//       child: Text(
//         'Update Profile',
//         style: TextStyle(
//           fontFamily: 'Tajawal',
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
