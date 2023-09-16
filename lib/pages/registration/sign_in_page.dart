import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_database_todo/blocs/auth/auth_bloc.dart';
import 'package:realtime_database_todo/pages/todo/home_page.dart';
import 'package:realtime_database_todo/service/constants/strings.dart';
import 'package:realtime_database_todo/views/custom_text_field.dart';
import 'package:realtime_database_todo/views/main_button_view.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {

          /// sign in success
          if (state is SignInSuccess) {
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (builder) => const HomePage(),
              ),
            );
          }

          /// auth failure
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.errorMsg),
              ),
            );
          }
        },
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 21),
                child: Column(
                  children: [
                    Text(
                      Strings.signIn,
                      style: GoogleFonts.freckleFace(fontSize: 40),
                    ),
                    const SizedBox(height: 30),

                    /// email
                    CustomTextField(
                      hintText: Strings.email,
                      controller: emailCtrl,
                    ),
                    const SizedBox(height: 13),

                    /// password
                    CustomTextField(
                      hintText: Strings.password,
                      controller: passwordCtrl,
                    ),
                    const SizedBox(height: 20),

                    /// Sign In Button
                    MainSignButton(
                      signText: Strings.signIn,
                      emailCtrl: emailCtrl,
                      passwordCtrl: passwordCtrl,
                    ),
                  ],
                ),
              ),
            ),

            /// Loading
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
            ),
          ],
        ),
      ),
    );
  }
}
