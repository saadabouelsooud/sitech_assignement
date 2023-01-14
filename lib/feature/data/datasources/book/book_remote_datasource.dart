import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:si_tech_assignment/core/error/exceptions.dart';
import 'package:si_tech_assignment/core/network/api/api.dart';
import 'package:si_tech_assignment/core/network/api/http_api.dart';
import 'package:si_tech_assignment/feature/data/models/book_model.dart';


abstract class BooksApi{
  Future<Response?> callAPI(String pageSize,String pageKey);
}

abstract class BookRemoteDataSource
{
  Future<List<BookModel>> getBooks(String pageSize,String pageKey);
  Future<BookModel> getBookDetails(String id);
  Future<bool> deleteBook(String id);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource, BooksApi
{

  @override
  Future<List<BookModel>> getBooks(String pageSize,String pageKey) async {
    try {
      var response = await callAPI(pageSize,pageKey);
      var data = response!.data;
      return BookModel.fromJsonList(data);
    } on IOException
        {
      throw ServerException();
    }
  }

  @override
  Future<Response?> callAPI(String pageSize,String pageKey) {
    final url = "${EndPoint.books}?page=$pageKey&limit=$pageSize";
    return HttpApi.request(url,
        type: RequestType.Get, onSendProgress: (int count, int total) {  }, queryParameters: {}, headers: {});
  }

  @override
  Future<BookModel> getBookDetails(String id) async{
    try {
      var response = await callBookDetailsAPI(id);
      var data = response!.data;
      return BookModel.fromJsonObject(data);
    } on IOException
    {
      throw ServerException();
    }
  }

  Future<Response?> callBookDetailsAPI(String id) {
    String url = EndPoint.book_detail+id;
    return HttpApi.request(url,
        type: RequestType.Get, onSendProgress: (int count, int total) {  }, queryParameters: {}, headers: {});
  }

  @override
  Future<bool> deleteBook(String id) async{
    String url = EndPoint.book_detail+id;
    final response = await HttpApi.request(url,
        type: RequestType.Delete, onSendProgress: (int count, int total) {  }, queryParameters: {}, headers: {});
    if(response != null)
      {
        return Future.value(true);
      }
    else
      {
        return Future.value(false);
      }
  }

}