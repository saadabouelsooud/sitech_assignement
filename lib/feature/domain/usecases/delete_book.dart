
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:si_tech_assignment/core/error/failure.dart';
import 'package:si_tech_assignment/core/usecases/usecase.dart';
import 'package:si_tech_assignment/feature/domain/entities/book.dart';
import 'package:si_tech_assignment/feature/domain/repositories/book_repository.dart';
import 'package:si_tech_assignment/feature/domain/usecases/get_book_details.dart';

class DeleteBook implements UseCase<bool,Params>{
  final BookRepository repository;

  DeleteBook(this.repository);


  // callable classes
  Future<Either<Failure, bool>> call(Params params) async
  {
    return await repository.deleteBook(params.id!);
  }
}