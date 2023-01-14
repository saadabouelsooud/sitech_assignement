
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:si_tech_assignment/feature/domain/entities/book.dart';
import 'package:si_tech_assignment/feature/domain/usecases/get_book_details.dart';
import 'package:si_tech_assignment/feature/presentation/viewmodel/book_details_viewmodel.dart';
import 'package:si_tech_assignment/feature/presentation/viewmodel/books_list_viewmodel.dart';


class BookDetail extends StatelessWidget
{

  final String id;
  BookDetail(this.id);

  final _itemDetailsProvider = itemDetailsVieModelStateNotifierProvider;

  Widget _buildItemDetailsContainerWidget(final BuildContext context, final Book bookDetails) {
    return _buildItemDetailsWidget(context, bookDetails);
  }

  Widget _buildItemDetailsWidget(final BuildContext context, final Book bookDetails) {
      if(bookDetails== null)
        {
          return const Center(child: Text('No data found'));
        }else
          {
            return Scaffold(
              body: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(bookDetails.cover!),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(bookDetails.name!, style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        Text(bookDetails.description!, style: TextStyle(fontSize: 16),),
                        SizedBox(height: 20,),
                        Text(bookDetails.createdAt!, style: TextStyle(fontSize: 14),),
                        SizedBox(height: 20,),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(25))
                            ),
                            child: Text("Go Back"),
                          ),
                          onTap: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  )
                ],),
            );
          }
  }
  Widget _buildErrorWidget() {
    return const Center(child: Text('An error has occurred!'));
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, watch, _) {
          return watch(_itemDetailsProvider(Params(id: id))).maybeWhen(
            success: (content) => _buildItemDetailsContainerWidget(context, content),
            error: (_) => _buildErrorWidget(),
            orElse: () => Center(child: CircularProgressIndicator()),
          );
        }
    );
  }

}