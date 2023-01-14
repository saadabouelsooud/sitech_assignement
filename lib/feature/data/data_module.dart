


import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:si_tech_assignment/core/network/network_info.dart';
import 'package:si_tech_assignment/feature/data/datasources/book/book_local_datasource.dart';
import 'package:si_tech_assignment/feature/data/datasources/book/book_remote_datasource.dart';
import 'package:si_tech_assignment/feature/domain/repositories/book_repository.dart';
import 'package:si_tech_assignment/feature/domain/usecases/get_book_details.dart';

import 'repositories/book_repository_impl.dart';

final networkInfoProvider = Provider<NetworkInfo>((_) => NetworkInfoImpl(DataConnectionChecker()));


final Provider<BookLocalDataSource> bookLocalDataSourceProvider = Provider<BookLocalDataSource>((_) => BookLocalDataSourceImpl());
final Provider<BookRemoteDataSource> bookRemoteDataSourceProvider = Provider<BookRemoteDataSource>((_) => BookRemoteDataSourceImpl());

final Provider<BookRepository> bookRepositoryProvider =
Provider<BookRepository>((ref) => BookRepositoryImpl(remoteDataSource: ref.watch(bookRemoteDataSourceProvider),localDataSource: ref.watch(bookLocalDataSourceProvider),networkInfo: ref.watch(networkInfoProvider)));


final Provider<Params> paramsProvider = Provider<Params>((_) => Params());