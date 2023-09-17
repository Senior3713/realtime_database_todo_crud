import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_database_todo/blocs/auth/auth_bloc.dart';
import 'package:realtime_database_todo/blocs/real_database/todo_db_bloc.dart';
import 'package:realtime_database_todo/pages/registration/sign_in_page.dart';
import 'package:realtime_database_todo/pages/todo/create_page.dart';
import 'package:realtime_database_todo/pages/todo/edit_page.dart';
import 'package:realtime_database_todo/service/constants/strings.dart';
import 'package:realtime_database_todo/views/alert_dialog.dart';
import 'package:realtime_database_todo/views/loading_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showWarningDialog(BuildContext ctx) {
    final controller = TextEditingController();
    showDialog(
      context: ctx,
      builder: (context) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is DeleteAccountSuccess) {
              Navigator.of(context).pop();
              if (ctx.mounted) {
                Navigator.of(ctx).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SignInPage()));
              }
            }

            if (state is AuthFailure) {
              Navigator.of(context).pop();
              Navigator.of(ctx).pop();
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                AlertDialog(
                  title: const Text("Delete Account"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state is DeleteConfirmSuccess
                            ? "Please confirm password to delete account"
                            : "Do you want to delete account?",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is DeleteConfirmSuccess)
                        TextField(
                          controller: controller,
                          decoration:
                              const InputDecoration(hintText: Strings.password),
                        ),
                    ],
                  ),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    /// #cancel
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),

                    /// #confirm #delete
                    ElevatedButton(
                      onPressed: () {
                        if (state is DeleteConfirmSuccess) {
                          context
                              .read<AuthBloc>()
                              .add(DeleteAccountEvent(controller.text.trim()));
                        } else {
                          context
                              .read<AuthBloc>()
                              .add(const DeleteConfirmEvent());
                        }
                      },
                      child: Text(
                        state is DeleteConfirmSuccess ? "Delete" : "Confirm",
                      ),
                    ),
                  ],
                ),
                if (state is AuthLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            );
          },
        );
      },
    );
  }

  late DatabaseReference dbRef;

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance.ref().child("Todos");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (value) {
        if (value) {
          context.read<AuthBloc>().add(const GetUserEvent());
        }
      },
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(const SignOutEvent());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final String name = state is GetUserSuccess
                    ? state.user.displayName!
                    : "accountName";
                final String email =
                    state is GetUserSuccess ? state.user.email! : "accountName";

                return UserAccountsDrawerHeader(
                  accountName: Text(name),
                  accountEmail: Text(email),
                );
              },
            ),
            ListTile(
              onTap: () => showWarningDialog(context),
              title: const Text("Delete Account"),
            )
          ],
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          /// AuthListener
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              /// Auth failure
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMsg)));
              }

              /// Delete Account Success
              if (state is DeleteAccountSuccess && context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }

              /// Sign Out Success
              if (state is SignOutSuccess) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SignInPage()));
              }
            },
          ),

          /// TodoListener
          BlocListener<TodoBloc, TodoState>(
            listener: (context, state) {
              /// Log out success
              if (state is SignOutSuccess) {
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (builder) => const SignInPage(),
                  ),
                );
              }

              /// Todo Delete Success
              if (state is TodoRemoveSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Todo successfully deleted."),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          )
        ],
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
