part of 'todo_db_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;
  const AddTodoEvent({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}

class DeleteTodoEvent extends TodoEvent {
  final String key;
  const DeleteTodoEvent({required this.key});

  @override
  List<Object?> get props => [key];
}

class UpdateTodoEvent extends TodoEvent {
  final String key;
  final String title;
  final String description;
  const UpdateTodoEvent({required this.key, required this.title, required this.description});

  @override
  List<Object?> get props => [key, title, description];
}






