import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_database_todo/blocs/real_database/todo_db_bloc.dart';

class CreateTodoPage extends StatelessWidget {
  final DatabaseReference dbRef;

  CreateTodoPage({super.key, required this.dbRef});

  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Todo",
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
                  "Title",
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
                  hintText: "Title",
                  contentPadding: const EdgeInsets.all(15),
                  hintStyle: GoogleFonts.aleo(color: Colors.white60),
                  filled: true,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  fillColor: Colors.brown,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
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
                  hintText: "Description",
                  contentPadding: const EdgeInsets.all(15),
                  hintStyle: GoogleFonts.aleo(color: Colors.white60),
                  filled: true,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
            final title = titleCtrl.text;
            final desc = descCtrl.text;
            if (title.isEmpty || desc.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Something error, Please try again!!!"),
                ),
              );
              return;
            }

            BlocProvider.of<TodoBloc>(context).add(
              AddTodoEvent(
                title: title,
                description: desc,
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
