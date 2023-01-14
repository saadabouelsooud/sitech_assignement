
import 'package:equatable/equatable.dart';
class Book extends Equatable
{
  final String? id;
  final String? description;
  final String? name;
  final String? createdAt;
  final String? cover;
  final String? author;


  const Book({this.id,this.description,this.name,this.createdAt,this.cover,this.author});

  @override
  // TODO: implement props
  List<Object?> get props => [id,description,name,createdAt,cover,author];

}