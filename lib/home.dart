import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/profile/domain/profile_repository.dart';
import 'features/profile/presentation/profile_cubits.dart';
import 'core/presentation/load_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shattably/features/home/presention/layout/service_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:shattably/orderlist.dart';

import 'components/components.dart';
import 'getorder.dart';
import 'navigationservice.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String jobTitle;
  late String city;
  @override
  void initState() {
    // TODO: implement initState
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        FirebaseFirestore.instance
            .collection('orders')
            .doc(value.data['id'])
            .get()
            .then((value) {
          navigateTo(NavigationService.context, Response(getorder: value.data()));
        });


      }
    });
    super.initState();
    context.read<ProfileCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, LoadState<UserProfile>>(builder: (context, state) {
      final profile = state.data;
      if (profile != null) {
        return profile.isCustomer ? const ServiceLayout() : OrdersList(workerCity: profile.city, workerJobType: profile.job);
      }
      return Scaffold(body: Center(child: state.failure != null
        ? Column(mainAxisSize: MainAxisSize.min, children: [Text(state.failure!.message),
            TextButton(onPressed: () => context.read<ProfileCubit>().load(), child: const Text('Retry'))])
        : const CircularProgressIndicator()));
    });
  }
}
