import 'package:belajar_bloc/data/models/quote/quote_model.dart';
import 'package:belajar_bloc/domain/usecases/get_quote.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late GetQuotes usecase;
  late MockQuoteRepository mockQuoteRepository;

  setUp(() {
    mockQuoteRepository = MockQuoteRepository();
    usecase = GetQuotes(mockQuoteRepository);
  });

  final tQuoteModel = QuoteModel(quote: "quote", author: "author", category: "category");

  test('Shoul get quote from the repository', () async {
    // arrange
    when(mockQuoteRepository.getQuotes('')).thenAnswer((_) async => Right(tQuoteModel.toEntity()));
    //act
    final result = await usecase.execute('');
    // assert
    expect(result, Right(tQuoteModel.toEntity()));
  });
}
