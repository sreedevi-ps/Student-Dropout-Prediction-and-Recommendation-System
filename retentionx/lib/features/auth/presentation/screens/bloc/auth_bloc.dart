import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retentionx/features/auth/data/repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(AuthLoading());
      final res = await AuthRepo.login(
        userName: event.userName,
        password: event.password,
      );

      res.fold((l) {
        emit(AuthError(l));
      }, (r) {
        
        emit(AuthSuccess(r.isAdmin,r.id));
      });
    });
  }
}
