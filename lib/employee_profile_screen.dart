import 'package:shattably/features/profile/domain/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeProfileScreen extends StatefulWidget {
  final UserProfile employee;

  const EmployeeProfileScreen({super.key, required this.employee});

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.green),
        title: const Text(
          'Employee Profile',
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 30),
            _buildProfileInfo('Name', widget.employee.name, Icons.person),
            _buildProfileInfo('Phone', widget.employee.phone, Icons.phone),
            _buildProfileInfo('Address', widget.employee.address, Icons.home),
            _buildProfileInfo('Email', widget.employee.email, Icons.mail),
            _buildProfileInfo('City', widget.employee.city, Icons.location_city),
            _buildProfileInfo('Job', widget.employee.job, Icons.work),
            _buildProfileInfo('WhatsApp', widget.employee.whatsapp, Icons.messenger_outlined),
            const SizedBox(height: 40),
            _buildCallButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 60.0,
          backgroundImage: NetworkImage(
            widget.employee.image != null && widget.employee.image != "null"
                ? widget.employee.image
                : 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
          ),
          backgroundColor: Colors.white,
        ),
        const SizedBox(height: 20),
        Text(
          widget.employee.name,
          style: const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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





  Widget _buildCallButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Call the worker',
          style: TextStyle(
            fontFamily: 'Tajawal',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        IconButton(
          onPressed: () async {
            final phone = widget.employee.phone.trim();
            var launched = false;
            try {
              if (phone.isNotEmpty) {
                launched = await launchUrl(Uri(scheme: 'tel', path: phone));
              }
            } catch (_) {
              // A device without a phone app may reject the intent.
            }
            if (!mounted || launched) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Unable to open the phone app.')),
            );
          },
          icon: const Icon(Icons.call, color: Colors.green),
        ),
      ],
    );
  }
}
