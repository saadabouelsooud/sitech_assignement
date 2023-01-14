

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:si_tech_assignment/feature/data/data_module.dart';
import 'package:si_tech_assignment/feature/domain/usecases/get_book_details.dart';
import 'package:si_tech_assignment/feature/domain/usecases/get_books.dart';

import 'usecases/delete_book.dart';

final getBooksProvider =
Provider<GetBooks>((ref) => GetBooks(ref.watch(bookRepositoryProvider)));

final getBookDetailsProvider =
Provider<GetBookDetails>((ref) => GetBookDetails(ref.watch(bookRepositoryProvider)));

final deleteBookProvider =
Provider<DeleteBook>((ref) => DeleteBook(ref.watch(bookRepositoryProvider)));