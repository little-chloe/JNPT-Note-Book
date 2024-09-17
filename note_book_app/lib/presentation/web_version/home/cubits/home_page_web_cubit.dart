import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_book_app/core/services/get_it_service.dart';
import 'package:note_book_app/domain/usecases/get_all_levels_usecase.dart';
import 'package:note_book_app/presentation/web_version/home/cubits/home_page_web_state.dart';

class HomePageWebCubit extends Cubit<HomePageWebState> {
  final GetAllLevelsUsecase _getAllLevelsUsecase = getIt<GetAllLevelsUsecase>();

  HomePageWebCubit() : super(HomePageWebInitial());

  void getAllLevels() async {
    emit(const HomePageWebLoadingState(levels: []));
    final result = await _getAllLevelsUsecase.call();
    result.fold((failure) {
      emit(HomePageWebFailureState(
        failureMessage: failure.message,
        levels: state.levels,
      ));
    }, (levels) {
      emit(state.copyWith(levels: levels));
    });
  }
}
