import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:si_tech_assignment/feature/data/datasources/book/book_remote_datasource.dart';
import 'package:si_tech_assignment/feature/domain/entities/book.dart';
import 'package:si_tech_assignment/feature/domain/usecases/get_books.dart';
import 'package:si_tech_assignment/feature/presentation/view/books/book_item.dart';
import 'package:si_tech_assignment/feature/presentation/view/books/book_item_details.dart';
import 'package:si_tech_assignment/feature/presentation/viewmodel/books_list_viewmodel.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class BooksList extends StatefulWidget
{
  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  final _booksProvider = bookListVieModelStateNotifierProvider;

  static const _pageSize = 10;

  final PagingController<int, Book> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await BookRemoteDataSourceImpl().getBooks(_pageSize.toString(), pageKey.toString());
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey.toInt());
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget _buildUserListContainerWidget(final BuildContext context, final List<Book> BookList) {
    return _buildBookListWidget(context, BookList);
  }

  Widget _buildBookListWidget(final BuildContext context, final List<Book> bookList) {
    if (bookList.length == 0) {
      return const Center(child: Text('No Book'));
    } else {
      return SafeArea(
          child: PagedListView<int, Book>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Book>(
              itemBuilder: (context, item, index) {
                  return BookItem(item);
                }
            ),
          )
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
          return watch(_booksProvider(PageParams(pageKey: "1",pageSize: _pageSize.toString()))).maybeWhen(
            success: (content) => _buildUserListContainerWidget(context, content),
            error: (_) => _buildErrorWidget(),
            orElse: () => Center(child: CircularProgressIndicator()),
          );
        }
    );
  }
}