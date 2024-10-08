import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/user/is_user_logged_in_usecase.dart';
import 'package:note_book_app/domain/usecases/user/logout_usecase.dart';
import 'package:note_book_app/presentation/web_version/admin/cubits/admin_page_web/admin_page_web_state.dart';

class AdminPageWebCubit extends Cubit<AdminPageWebState> {
  final IsUserLoggedInUsecase _isUserLoggedInUsecase =
      getIt<IsUserLoggedInUsecase>();
  final LogoutUsecase _logoutUsecase = getIt<LogoutUsecase>();

  AdminPageWebCubit() : super(AdminPageWebLoading());

  void checkIfUserIsLoggedIn() async {
    final result = await _isUserLoggedInUsecase.call();
    result.fold(
      (failure) => emit(AdminPageWebUserNotLoggedIn()),
      (user) {
        if (user.role == 'admin') {
          emit(AdminPageWebInitial());
        } else {
          emit(AdminPageWebUserNotLoggedIn());
        }
      },
    );
  }

  void logout() async {
    final result = await _logoutUsecase();
    result.fold(
      (failure) => emit(AdminPageWebFailure(message: failure.message)),
      (success) => emit(AdminPageWebUserNotLoggedIn()),
    );
  }
}
