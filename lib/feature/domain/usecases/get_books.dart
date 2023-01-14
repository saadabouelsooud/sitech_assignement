

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:si_tech_assignment/core/error/failure.dart';
import 'package:si_tech_assignment/core/usecases/usecase.dart';
import 'package:si_tech_assignment/feature/domain/entities/book.dart';
import 'package:si_tech_assignment/feature/domain/repositories/book_repository.dart';
import 'package:si_tech_assignment/feature/domain/usecases/get_book_details.dart';

class GetBooks implements UseCase<List<Book>,PageParams>
{
  final BookRepository repository;

  GetBooks(this.repository);

  // callable classes
  @override
  Future<Either<Failure, List<Book>>> call(PageParams params) async {
    return await repository.getBooks(params.pageSize!,params.pageKey!);
  }
}

class PageParams extends Equatable
{
  final String? pageSize;
  final String? pageKey;

  PageParams({this.pageSize,this.pageKey});

  @override
  // TODO: implement props
  List<Object?> get props => [pageKey,pageSize];
}