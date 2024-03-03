import 'dart:convert';

import 'package:belajar_bloc/common/exception.dart';
import 'package:belajar_bloc/data/models/quote/quote_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late MockApiConsumer mockApiConsumer;

  setUp(() {
    mockApiConsumer = MockApiConsumer();
  });

  group('Get quote', () {
    final dummy = readJson('dummy_data/quote.json');
    final tQuote = QuoteModel.fromJson(jsonDecode(dummy));

    test('should perform a GET request', () async {
      // arrange
      when(mockApiConsumer.getQuotes('')).thenAnswer((_) async => tQuote);
      // act
      mockApiConsumer.getQuotes('');
      mockApiConsumer.getQuotes('');
      mockApiConsumer.getQuotes('');
      //assert
      verify(mockApiConsumer.getQuotes(''));
    });

    test('Should return a quote when the response code is 200', () async {
      // arrange
      when(mockApiConsumer.getQuotes('')).thenAnswer((_) async => tQuote);
      // act
      final result = await mockApiConsumer.getQuotes('');
      //assert
      expect(result, equals(tQuote));
    });

    test('Should return a ServerException when the response code is not 200', () async {
      // arrange
      when(mockApiConsumer.getQuotes('')).thenThrow(ServerException());
      // act
      final call = mockApiConsumer.getQuotes;
      //assert
      expect(() => call(''), throwsA(isA<ServerException>()));
    });
  });
}
