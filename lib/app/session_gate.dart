import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/presentation/load_state.dart';
import '../features/auth/domain/auth_repository.dart';
import '../features/auth/presentation/auth_cubits.dart';
import '../features/auth/presentation/login_screen.dart';
import 'home_page.dart';

/// Every authenticated root route keeps listening to the session authority.
class SessionGate extends StatelessWidget {
  const SessionGate({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<SessionCubit, LoadState<AuthUser>>(
    builder: (context, state) {
      if (state.status == LoadStatus.loading) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      return state.data?.emailVerified == true ? Home(key: ValueKey(state.data!.id)) : const ServiceLoginScreen();
    },
  );
}
