import 'package:dartz/dartz.dart';
import 'package:note_book_app/core/failures/failure.dart';
import 'package:note_book_app/domain/entities/user_entity.dart';
import 'package:note_book_app/domain/repositories/user_repository.dart';

class IsUserLoggedInUsecase {
  final UserRepository userRepository;

  const IsUserLoggedInUsecase({required this.userRepository});

  Future<Either<Failure, UserEntity>> call() async {
    return await userRepository.isLoggedIn();
  }
}
