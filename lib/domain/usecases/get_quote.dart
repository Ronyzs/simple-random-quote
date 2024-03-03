import 'package:belajar_bloc/common/failure.dart';
import 'package:belajar_bloc/domain/entities/quote.dart';
import 'package:belajar_bloc/domain/repositories/quote_repository.dart';
import 'package:dartz/dartz.dart';

class GetQuotes {
  final QuoteRepository repository;

  GetQuotes(this.repository);

  Future<Either<Failure, Quote>> execute(String category) {
    return repository.getQuotes(category);
  }
}
