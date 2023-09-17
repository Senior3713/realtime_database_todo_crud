import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_database_todo/blocs/auth/auth_bloc.dart';
import 'package:realtime_database_todo/pages/registration/sign_in_page.dart';
import 'package:realtime_database_todo/pages/registration/sign_up_page.dart';
import 'package:realtime_database_todo/service/constants/strings.dart';

class MainSignButton extends StatelessWidget {
  final String signText;
  final TextEditingController? nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController? confirmCtrl;

  const MainSignButton({
    super.key,
    required this.signText,
    this.nameCtrl,
    required this.emailCtrl,
    required this.passwordCtrl,
    this.confirmCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () {
            if (signText == "Sign Up") {
              context.read<AuthBloc>().add(
                    SignUpEvent(
                      username: nameCtrl!.text.trim(),
                      email: emailCtrl.text.trim(),
                      password: passwordCtrl.text.trim(),
                      confirmPassword: confirmCtrl!.text.trim(),
                    ),
                  );
            } else {
              context.read<AuthBloc>().add(
                    SignInEvent(
                      email: emailCtrl.text.trim(),
                      password: passwordCtrl.text.trim(),
                    ),
                  );
            }
          },
          shape: const StadiumBorder(),
          color: Colors.blue,
          height: 55,
          minWidth: MediaQuery.sizeOf(context).width,
          child: signText == "Sign Up"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 35),
                    Text(
                      signText,
                      style: GoogleFonts.heptaSlab(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_right_alt,
                      size: 35,
                    )
                  ],
                )
              : Text(
                  signText,
                  style: GoogleFonts.heptaSlab(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              signText == "Sign Up"
                  ? Strings.alreadyHaveAccount
                  : Strings.doNotHaveAccount,
            ),
            SelectableText(
              signText == "Sign Up" ? "Sign In" : "Sign Up",
              onTap: () => signText == "Sign Up"
                  ? Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(
                        builder: (builder) => const SignInPage(),
                      ),
                    )
                  : Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(
                        builder: (builder) => const SignUpPage(),
                      ),
                    ),
              style: const TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.lightBlue,
                decorationColor: Colors.lightBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
