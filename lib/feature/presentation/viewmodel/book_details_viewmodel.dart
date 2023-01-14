

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:si_tech_assignment/core/error/exceptions.dart';
import 'package:si_tech_assignment/feature/domain/domain_module.dart';
import 'package:si_tech_assignment/feature/domain/entities/book.dart';
import 'package:si_tech_assignment/feature/domain/usecases/get_book_details.dart';
import 'package:si_tech_assignment/feature/presentation/state/state.dart';

final itemDetailsVieModelStateNotifierProvider =
StateNotifierProvider.autoDispose.family<BookDetailsViewModel,State<Book>, Params>((ref, params) {
  print(params.id);
  return BookDetailsViewModel(ref.watch(getBookDetailsProvider),params.id!);
});


class BookDetailsViewModel extends StateNotifier<State<Book>>
{
  final GetBookDetails _getBookDetails;
  final String id;
  BookDetailsViewModel(
      this._getBookDetails, this.id,
      ) : super(const State.init()) {
    _getBookDetail();
  }

  _getBookDetail() async {
    state = const State.loading();
    final bookDetails = await _getBookDetails(Params(id: id));
    bookDetails.fold(
            (failure) => state = State.error(mapFailureToException(failure)),
            (list) => state = State.success(list)
    );
  }

}
