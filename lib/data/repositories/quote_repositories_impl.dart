import 'dart:io';

import 'package:belajar_bloc/common/exception.dart';
import 'package:belajar_bloc/common/failure.dart';
import 'package:belajar_bloc/data/datasources/api_consumer.dart';
import 'package:belajar_bloc/data/models/quote/quote_model.dart';
import 'package:belajar_bloc/domain/entities/quote.dart';
import 'package:belajar_bloc/domain/repositories/quote_repository.dart';
import 'package:dartz/dartz.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final ApiConsumer apiConsumer;

  QuoteRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<Failure, Quote>> getQuotes(category) async {
    try {
      final result = await apiConsumer.getQuotes(category);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
