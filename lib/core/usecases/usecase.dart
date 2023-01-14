import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:si_tech_assignment/core/error/failure.dart';

abstract class UseCase<Type,Params>
{
  Future<Either<Failure,Type>> call(Params params);
}

class NoParams extends Equatable
{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}