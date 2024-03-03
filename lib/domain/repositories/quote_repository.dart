import 'package:belajar_bloc/common/failure.dart';
import 'package:belajar_bloc/domain/entities/quote.dart';
import 'package:dartz/dartz.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getQuotes(String category);
}
