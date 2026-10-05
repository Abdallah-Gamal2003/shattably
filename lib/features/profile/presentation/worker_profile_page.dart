import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'package:shattably/features/profile/presentation/worker_profile_screen.dart';
import 'package:shattably/features/profile/domain/profile_repository.dart';
import 'package:shattably/features/profile/domain/profile_use_cases.dart';
import 'package:shattably/features/profile/presentation/profile_cubits.dart';

void openProfile(BuildContext context, String id) {
  Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
            create: (_) => WorkerProfileCubit(
                GetProfile(context.read<ProfileRepository>()))
              ..load(id),
            child: BlocBuilder<WorkerProfileCubit, LoadState<UserProfile>>(
                builder: (context, state) {
              if (state.data != null)
                return EmployeeProfileScreen(employee: state.data!);
              return Scaffold(
                  appBar: AppBar(),
                  body: Center(
                      child: state.failure != null
                          ? Text(state.failure!.message)
                          : const CircularProgressIndicator()));
            }),
          )));
}
