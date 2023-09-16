import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_database_todo/blocs/real_database/todo_db_bloc.dart';
import 'package:realtime_database_todo/service/constants/strings.dart';

class EditTodoPage extends StatefulWidget {
  final String todoKey;
  final Map todo;

  const EditTodoPage({super.key, required this.todo, required this.todoKey});

  @override
  State<EditTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<EditTodoPage> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void initState() {
    titleCtrl.text = widget.todo["title"]!;
    descCtrl.text = widget.todo["description"]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Todo",
          style: GoogleFonts.hennyPenny(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.title,
                  style: GoogleFonts.underdog(
                    color: Colors.white54,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: titleCtrl,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                decoration: InputDecoration(
                  hintText: Strings.title,
                  contentPadding: const EdgeInsets.all(15),
                  hintStyle: GoogleFonts.aleo(color: Colors.white60),
                  filled: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  fillColor: Colors.brown,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.description,
                  style: GoogleFonts.underdog(
                    color: Colors.white54,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
                controller: descCtrl,
                decoration: InputDecoration(
                  hintText: Strings.description,
                  contentPadding: const EdgeInsets.all(15),
                  hintStyle: GoogleFonts.aleo(color: Colors.white60),
                  filled: true,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  fillColor: Colors.brown,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(25),
        child: FloatingActionButton(
          backgroundColor: Colors.brown,
          onPressed: () {
            if (titleCtrl.text.isEmpty || descCtrl.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Something error, Please try again!!!"),
                ),
              );
              return;
            }

            BlocProvider.of<TodoBloc>(context).add(
              UpdateTodoEvent(
                key: widget.todoKey,
                title: titleCtrl.text,
                description: descCtrl.text,
              ),
            );

            Navigator.of(context).pop();
          },
          child: const Icon(
            CupertinoIcons.checkmark_alt,
            size: 30,
          ),
        ),
      ),
    );
  }
}
