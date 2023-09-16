part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthFailure extends AuthState {
  final String errorMsg;
  const AuthFailure({required this.errorMsg});

  @override
  List<Object> get props => [];
}

class SignUpSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

class SignInSuccess extends AuthState {
  @override
  List<Object> get props => [];
}
