import 'package:dartz/dartz.dart';
import 'package:vt_live_map/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
