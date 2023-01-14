
import 'package:si_tech_assignment/feature/domain/entities/book.dart';

class BookModel extends Book
{
  BookModel({String? id,String? description,String? name,String? createdAt, String? cover,String? author}) : super(id: id,description: description,name: name,createdAt: createdAt, cover: cover,author: author);

  factory BookModel.fromJsonObject(Map<String,dynamic> json)
  {
    return BookModel(id: json['id'], description: json['description'],name: json['name'],createdAt: json['createdAt'],cover: json['cover'],author:json['author']);
  }

  static List<BookModel> fromJsonList(List<dynamic> jsonList)
  {
    List<BookModel> list = [];
    for (var element in jsonList) {
      list.add(BookModel.fromJsonObject(element));
    }
    return list;
  }


  Map<String,dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "name": name,
      "createdAt": createdAt,
      "cover": cover,
      "author": author
    };
  }
}