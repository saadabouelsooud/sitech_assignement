import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:si_tech_assignment/feature/data/datasources/book/book_remote_datasource.dart';
import 'package:si_tech_assignment/feature/domain/entities/book.dart';
import 'package:si_tech_assignment/feature/presentation/view/books/book_item_details.dart';

class BookItem extends StatelessWidget {
  final Book bookModel;
  BookItem(this.bookModel);


  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ObjectKey(bookModel),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookDetail(bookModel.id!)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 250,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(bookModel.cover!),
                  ),
                ),
                Container(
                  // width: 100,
                  child: Column(
                    children: <Widget>[
                      Text(
                        bookModel.name!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(bookModel.author!),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      trailingActions: <SwipeAction>[
        SwipeAction(
            title: "delete",
            onTap: (CompletionHandler handler) async {
               final deleted = await BookRemoteDataSourceImpl().deleteBook(bookModel.id!);
               if (deleted)
                 {
                   await handler(true);
                 }
            },
            color: Colors.red),
      ],
    );
  }
}
