import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_database_todo/blocs/auth/auth_bloc.dart';
import 'package:realtime_database_todo/blocs/real_database/todo_db_bloc.dart';
import 'package:realtime_database_todo/pages/registration/sign_up_page.dart';
import 'package:realtime_database_todo/service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const RealTimeDatabaseTodo());
}

class RealTimeDatabaseTodo extends StatelessWidget {
  const RealTimeDatabaseTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<TodoBloc>(create: (context) => TodoBloc()),
      ],
      child: MaterialApp(
        home: const SignUpPage(),
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.dark,
        theme: ThemeData.dark(useMaterial3: true),
      ),
    );
  }
}
