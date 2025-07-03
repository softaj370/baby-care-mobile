import 'package:baby_care/features/auth/presentation/bloc/auth_events.dart';
import 'package:baby_care/features/auth/presentation/bloc/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LogoutState()) {

    on<LoginEvent>((event, emit) {
      emit(LoginState());
    });

    on<LogoutEvent>((event, emit) {
      emit(LogoutState());
    });
  }
}
