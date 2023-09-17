import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:realtime_database_todo/service/auth_service.dart';
import 'package:realtime_database_todo/service/util_service.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>(_signUp);
    on<SignInEvent>(_signIn);
    on<SignOutEvent>(_signOut);
    on<GetUserEvent>(_getUser);
    on<DeleteConfirmEvent>(_updateUI);
    on<DeleteAccountEvent>(_deleteAccount);
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

  void _signOut(SignOutEvent event, Emitter emit) async {
    emit(AuthLoading());

    await AuthService.signOut();

    emit(SignOutSuccess());
  }

  void _getUser(GetUserEvent event, Emitter emit) async{
    emit(GetUserSuccess(AuthService.user));
  }

  void _updateUI(DeleteConfirmEvent event, Emitter emit) {
    emit(DeleteConfirmSuccess());
  }

  void _deleteAccount(DeleteAccountEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = AuthService.user;
    final resultSignIn = await AuthService.signIn(user.email!, event.password);

    if(!resultSignIn) {
      emit(const AuthFailure(errorMsg: "Please enter valid password!"));
      return;
    }

    final result = await AuthService.deleteAccount();
    if(result) {
      emit(const DeleteAccountSuccess("Successfully deleted your account!"));
    } else {
      emit(const AuthFailure(errorMsg: "Something error, please try again later!!!"));
    }
  }

}
