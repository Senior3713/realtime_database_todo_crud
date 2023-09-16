import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:realtime_database_todo/blocs/real_database/todo_db_bloc.dart';
import 'package:realtime_database_todo/pages/todo/create_page.dart';
import 'package:realtime_database_todo/pages/todo/edit_page.dart';
import 'package:realtime_database_todo/views/alert_dialog.dart';
import 'package:realtime_database_todo/views/loading_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("Todos");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: Text(
          'All Todos',
          style: GoogleFonts.hennyPenny(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return const LogOutAlertDialog();
                },
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {

          /// Delete Success
          if (state is TodoRemoveSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Todo successfully deleted."),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: Stack(
          children: [
            Center(
              child: FirebaseAnimatedList(
                query: dbRef,
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, snapshot, animation, index) {
                  Map todos = snapshot.value as Map;
                  final key = snapshot.key;

                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
                      onLongPress: () => Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (builder) => EditTodoPage(
                            todoKey: key!,
                            todo: todos,
                          ),
                        ),
                      ),
                      leading: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${index + 1}",
                          style: GoogleFonts.shadowsIntoLightTwo(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      title: Text(
                        todos["title"],
                        maxLines: 1,
                        style: GoogleFonts.shareTechMono(
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        todos["description"],
                        maxLines: 2,
                        style: GoogleFonts.zenKakuGothicAntique(
                          color: Colors.white70,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return DeleteAlertDialog(todoKey: key!);
                            },
                          );
                        },
                        icon: const Icon(
                          CupertinoIcons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Loading
            const LoadingBuilder(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (builder) => CreateTodoPage(dbRef: dbRef),
            ),
          ),
          backgroundColor: Colors.brown,
          child: const Icon(CupertinoIcons.add),
        ),
      ),
    );
  }
}
