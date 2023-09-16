import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realtime_database_todo/service/db_service.dart';

part 'todo_db_event.dart';

part 'todo_db_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<AddTodoEvent>(_addTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    on<UpdateTodoEvent>(_updateTodo);
  }

  void _addTodo(AddTodoEvent event, Emitter emit) {
    emit(TodoLoading());

    DbService.addTodo(event.title, event.description);

    emit(TodoAddSuccess());
  }

  void _deleteTodo(DeleteTodoEvent event, Emitter emit) {
    emit(TodoLoading());

    DbService.deleteTodo(event.key);

    emit(TodoRemoveSuccess());
  }

  void _updateTodo(UpdateTodoEvent event, Emitter emit) {
    emit(TodoLoading());

    DbService.updateTodo(event.key, event.title, event.description);

    emit(TodoUpdateSuccess());
  }
}
