import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realtime_database_todo/service/auth_service.dart';
import 'package:realtime_database_todo/service/util_service.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>(_signUp);
    on<SignInEvent>(_signIn);
  }

  void _signUp(SignUpEvent event, Emitter emit) async {
    if (!Util.validateSignUp(event)) {
      emit(const AuthFailure(errorMsg: 'Please check your data!'));
      return;
    }

    emit(AuthLoading());

    final success =
        await AuthService.signUp(event.username, event.email, event.password, event.confirmPassword);
    if (success) {
      emit(SignUpSuccess());
    } else {
      emit(const AuthFailure(
          errorMsg: "Something error, please try again later!!!"));
    }
  }

  void _signIn(SignInEvent event, Emitter emit) async {
    if (!Util.validateSignIn(event)) {
      emit(const AuthFailure(errorMsg: 'Please check your data!'));
      return;
    }

    emit(AuthLoading());

    final success =
        await AuthService.signIn(event.email, event.password);
    if (success) {
      emit(SignInSuccess());
    } else {
      emit(const AuthFailure(
          errorMsg: "Something error, please try again later!!!"));
    }
  }
}
