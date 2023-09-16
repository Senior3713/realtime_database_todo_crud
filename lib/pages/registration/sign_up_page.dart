import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_database_todo/blocs/auth/auth_bloc.dart';
import 'package:realtime_database_todo/pages/registration/sign_in_page.dart';
import 'package:realtime_database_todo/service/constants/strings.dart';
import 'package:realtime_database_todo/views/custom_text_field.dart';
import 'package:realtime_database_todo/views/main_button_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          /// Sign Up Success
          if (state is SignUpSuccess) {
            Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (builder) => const SignInPage(),
            ));
          }

          /// Auth Failure
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
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 45, horizontal: 21),
                  child: Column(
                    children: [
                      /// main text
                      Text(
                        Strings.signUp,
                        style: GoogleFonts.freckleFace(fontSize: 40),
                      ),
                      const SizedBox(height: 30),

                      /// username
                      CustomTextField(
                        hintText: Strings.username,
                        controller: nameCtrl,
                      ),
                      const SizedBox(height: 13),

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
                      const SizedBox(height: 13),

                      /// confirm password
                      CustomTextField(
                        hintText: Strings.confirmPassword,
                        controller: confirmCtrl,
                      ),
                      const SizedBox(height: 45),

                      /// sign up button
                      MainSignButton(
                        signText: Strings.signUp,
                        nameCtrl: nameCtrl,
                        emailCtrl: emailCtrl,
                        passwordCtrl: passwordCtrl,
                        confirmCtrl: confirmCtrl,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// loading
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
