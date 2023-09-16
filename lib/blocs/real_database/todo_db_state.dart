part of 'todo_db_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoFailure extends TodoState {
  final String errorMsg;
  const TodoFailure({required this.errorMsg});

  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoAddSuccess extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoRemoveSuccess extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoUpdateSuccess extends TodoState {
  @override
  List<Object> get props => [];
}
