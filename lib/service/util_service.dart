import 'package:realtime_database_todo/blocs/auth/auth_bloc.dart';

sealed class Util {
  static bool validateSignUp(SignUpEvent event) {
    return event.username.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.?_]{4,}@gmail.com$").hasMatch(event.email) &&
        event.password.length >= 6 &&
        event.password == event.confirmPassword;
  }

  static bool validateSignIn(SignInEvent event) {
    return RegExp(r"^[a-zA-Z0-9.?_]{4,}@gmail.com$").hasMatch(event.email) &&
        event.password.length >= 6;
  }
}
