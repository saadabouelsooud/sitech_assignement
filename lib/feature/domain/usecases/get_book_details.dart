
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:si_tech_assignment/core/error/failure.dart';
import 'package:si_tech_assignment/core/usecases/usecase.dart';
import 'package:si_tech_assignment/feature/domain/entities/book.dart';
import 'package:si_tech_assignment/feature/domain/repositories/book_repository.dart';

class GetBookDetails implements UseCase<Book,Params>{
  final BookRepository repository;

  GetBookDetails(this.repository);


  // callable classes
  Future<Either<Failure, Book>> call(Params params) async
  {
    return await repository.getBookDetails(params.id!);
  }
}

class Params extends Equatable
{
  final String? id;

  Params({this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}