import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:si_tech_assignment/core/error/failure.dart';
import 'package:si_tech_assignment/feature/domain/entities/book.dart';

abstract class BookRepository
{
  Future<Either<Failure,List<Book>>> getBooks(String pageSize,String pageKey);
  Future<Either<Failure,Book>> getBookDetails(String id);
  Future<Either<Failure,bool>> deleteBook(String id);
}