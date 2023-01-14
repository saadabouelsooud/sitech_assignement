import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:si_tech_assignment/core/error/exceptions.dart';
import 'package:si_tech_assignment/core/utils/prefrences_util.dart';
import 'package:si_tech_assignment/feature/data/models/book_model.dart';

abstract class BookLocalDataSource
{
  Future<BookModel> getBookDetails(String id);
  Future<void> cacheBooks(List<BookModel> users);
  Future<List<BookModel>> getCacheBooks();
}

class BookLocalDataSourceImpl implements BookLocalDataSource
{
  final SharedPreferences? sharedPreferences;

  BookLocalDataSourceImpl({this.sharedPreferences});

  @override
  Future<void> cacheBooks(List<BookModel> books) {
    return SharedPreferenceUtils.putObjectList("books", books);
  }

  @override
  Future<BookModel> getBookDetails(String id) {
    final jsonString = sharedPreferences!.getString(id);
    if(jsonString != null)
    {
      return Future.value(BookModel.fromJsonObject(json.decode(jsonString)));
    }
    else
    {
      throw CacheException();
    }
  }

  @override
  Future<List<BookModel>> getCacheBooks() {
    var users = SharedPreferenceUtils.getObjList<BookModel>(
        "users", (v) => BookModel.fromJsonObject(v as Map<String, dynamic>));
    if(users != null)
    {
      return Future.value(BookModel.fromJsonList(users));
    }
    else
    {
      throw CacheException();
    }
  }

}