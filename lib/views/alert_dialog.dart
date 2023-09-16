import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_database_todo/blocs/real_database/todo_db_bloc.dart';
import 'package:realtime_database_todo/pages/registration/sign_in_page.dart';
import 'package:realtime_database_todo/service/auth_service.dart';

/// Delete todo dialog

class DeleteAlertDialog extends StatelessWidget {
  final String todoKey;
  const DeleteAlertDialog({super.key, required this.todoKey});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        "Delete",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      content: const Text(
          "Are you sure to delete this todo?"),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.of(context).pop(),
          child: const Text(
            "No",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<TodoBloc>(context).add(
              DeleteTodoEvent(key: todoKey),
            );

            Navigator.pop(context);
          },
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}


/// Log out dialog

class LogOutAlertDialog extends StatelessWidget {
  const LogOutAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        "Log Out",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      content: const Text("Are you sure to log out?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            AuthService.signOut();
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (builder) => const SignInPage(),
              ),
            );
          },
          child: const Text(
            "Confirm",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}



