import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_database_todo/blocs/auth/auth_bloc.dart';

class LoadingBuilder extends StatelessWidget {
  const LoadingBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return /// Loading
      BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
              ),
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      );
  }
}
