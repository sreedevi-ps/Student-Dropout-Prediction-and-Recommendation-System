import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:retentionx/features/auth/data/repo/auth_repo.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBlocBloc() : super(LoginBlocInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginBlocLoading());

      final response = await AuthRepo.login(
          userName: event.userName, password: event.password);

      response.fold((l) => emit(LoginBlocError(message: l)),
          (r) => emit(LoginBlocSuccess()));
    });
  }
}
