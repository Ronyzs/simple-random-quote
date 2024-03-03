import 'dart:io';

import 'package:belajar_bloc/common/exception.dart';
import 'package:belajar_bloc/common/failure.dart';
import 'package:belajar_bloc/data/models/quote/quote_model.dart';
import 'package:belajar_bloc/data/repositories/quote_repositories_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late QuoteRepositoryImpl quoteRepositoryImpl;
  late MockApiConsumer mockApiConsumer;

  setUp(() {
    mockApiConsumer = MockApiConsumer();
    quoteRepositoryImpl = QuoteRepositoryImpl(apiConsumer: mockApiConsumer);
  });

  final tQuoteModel = QuoteModel(quote: "quote", author: "author", category: "category");

  group('Quote', () {
    test('Should return ApiConsumer when the call to ApiConsumer is successful', () async {
      // arrange
      when(mockApiConsumer.getQuotes('')).thenAnswer((_) async => tQuoteModel);
      // act
      final result = await quoteRepositoryImpl.getQuotes('');
      // assert
      verify(mockApiConsumer.getQuotes(''));
      expect(result, equals(Right(tQuoteModel.toEntity())));
    });

    test('Should return server failure ApiConsumer when the call to ApiConsumer is unsuccessful', () async {
      // arrange
      when(mockApiConsumer.getQuotes('')).thenThrow(ServerException());
      // act
      final result = await quoteRepositoryImpl.getQuotes('');
      // assert
      verify(mockApiConsumer.getQuotes(''));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test('Should return connection failure ApiConsumer when the device is not connected to internet', () async {
      // arrange
      when(mockApiConsumer.getQuotes('')).thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await quoteRepositoryImpl.getQuotes('');
      // assert
      verify(mockApiConsumer.getQuotes(''));
      expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
