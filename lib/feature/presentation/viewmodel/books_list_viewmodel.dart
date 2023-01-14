

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:si_tech_assignment/core/error/exceptions.dart';
import 'package:si_tech_assignment/core/usecases/usecase.dart';
import 'package:si_tech_assignment/feature/domain/domain_module.dart';
import 'package:si_tech_assignment/feature/domain/entities/book.dart';
import 'package:si_tech_assignment/feature/domain/usecases/get_book_details.dart';
import 'package:si_tech_assignment/feature/domain/usecases/get_books.dart';
import 'package:si_tech_assignment/feature/presentation/state/state.dart';

final bookListVieModelStateNotifierProvider =
StateNotifierProvider.autoDispose.family<BooksViewModel, State<List<Book>>,PageParams>((ref,params) {
  // print(params.id);
  return BooksViewModel(ref.watch(getBooksProvider),params.pageKey!,params.pageSize!);
});

class BooksViewModel extends StateNotifier<State<List<Book>>>
{
  final GetBooks _getBooks;

  final String pageSize,pageKey;
  BooksViewModel(
      this._getBooks,
      this.pageKey,
      this.pageSize
      ) : super(const State.init()) {
    _getBookList();
  }

  _getBookList() async {
    state = const State.loading();
    final bookList = await _getBooks(PageParams(pageSize: pageSize, pageKey: pageKey));
    bookList.fold(
            (failure) => state = State.error(mapFailureToException(failure)),
            (list) => state = State.success(list)
    );
  }

  //  _delete(int bookId) async
  // {
  //   state = const State.loading();
  //   final bookList = await _getBooks(NoParams());
  //   bookList.fold(
  //           (failure) => state = State.error(mapFailureToException(failure)),
  //           (list) => state = State.success(list)
  //   );  }

}