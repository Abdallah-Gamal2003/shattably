import 'package:shattably/features/profile/domain/profile_repository.dart';
import 'package:shattably/features/profile/domain/profile_use_cases.dart';
import 'package:shattably/features/profile/presentation/profile_cubits.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/components/components.dart';
import 'package:shattably/features/home/presention/widgets/profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final jobController = TextEditingController();
  final whatsappController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, LoadState<UserProfile>>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == LoadStatus.failure) {
          return Scaffold(
            backgroundColor: Colors.deepOrange,
            body: Center(
              child: Text('Error: ${state.failure!.message}'),
            ),
          );
        }
        if (state.data == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        var userModel = state.data;
        var profileImage = null;

        nameController.text = userModel!.name;
        phoneController.text = userModel.phone;
        emailController.text = userModel.email;
        addressController.text = userModel.address;
        cityController.text = userModel.city;
        jobController.text = userModel.job;
        whatsappController.text = userModel.whatsapp;

        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildProfileHeader(context, userModel, profileImage),
                  const SizedBox(height: 40),
                  _buildProfileInfo('الاسم', nameController.text, Icons.person),
                  _buildProfileInfo('رقم الهاتف', phoneController.text, Icons.phone),
                  _buildProfileInfo('العنوان', addressController.text, Icons.home),
                  _buildProfileInfo('المحافظة', cityController.text, Icons.location_city),
                  _buildProfileInfo('الوظيفة', jobController.text, Icons.work),
                  _buildProfileInfo('الواتساب', whatsappController.text, Icons.messenger_outlined),
                  const SizedBox(height: 40),
                  _buildEditButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(BuildContext context, var userModel, var profileImage) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 60.0,
              backgroundImage: profileImage == null
                  ? NetworkImage(userModel.image)
                  : FileImage(profileImage) as ImageProvider,
              backgroundColor: Colors.white,
            ),
            IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.green,
                radius: 18.0,
                child: Icon(
                  Icons.camera_alt,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                // Navigate to Edit Profile for image change
                navigateTo(context, EditProfileScreen(profile: context.read<ProfileCubit>().state.data!));
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          nameController.text,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(String title, String subtitle, IconData iconData) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(iconData, size: 30, color: Colors.green),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontFamily: 'Tajawal',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        navigateTo(context, EditProfileScreen(profile: context.read<ProfileCubit>().state.data!));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        "تعديل البيانات",
        style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}