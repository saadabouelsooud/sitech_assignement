import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:si_tech_assignment/core/error/exceptions.dart';
import 'package:si_tech_assignment/core/error/failure.dart';
import 'package:si_tech_assignment/core/network/network_info.dart';
import 'package:si_tech_assignment/feature/data/datasources/book/book_local_datasource.dart';
import 'package:si_tech_assignment/feature/data/datasources/book/book_remote_datasource.dart';
import 'package:si_tech_assignment/feature/domain/entities/book.dart';
import 'package:si_tech_assignment/feature/domain/repositories/book_repository.dart';


class BookRepositoryImpl implements BookRepository
{

  final BookRemoteDataSource? remoteDataSource;
  final BookLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  BookRepositoryImpl({this.remoteDataSource,this.localDataSource,this.networkInfo});

  @override
  Future<Either<Failure, List<Book>>> getBooks(String pageSize,String pageKey) async {
    if (await networkInfo!.isConnected)
    {
      try {
        final users = await remoteDataSource!.getBooks(pageSize,pageKey);
        localDataSource!.cacheBooks(users);
        return Right(users);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    else
    {
      try{
        final users = await localDataSource!.getCacheBooks();
        return Right(users);
      } on CacheException{return Left(CacheFailure());}
    }

  }

  @override
  Future<Either<Failure, Book>> getBookDetails(String id) async {
    try {
      final bookDetails = await remoteDataSource!.getBookDetails(id);
      // await localDataSource!.getBookDetails(id);
      return Right(bookDetails);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteBook(String id) async{
    try {
      final bookDetails = await remoteDataSource!.deleteBook(id);

      return Right(bookDetails);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}