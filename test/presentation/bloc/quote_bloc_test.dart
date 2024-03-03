import 'package:belajar_bloc/common/failure.dart';
import 'package:belajar_bloc/data/models/quote/quote_model.dart';
import 'package:belajar_bloc/domain/usecases/get_quote.dart';
import 'package:belajar_bloc/presentation/bloc/quote/quote_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'quote_bloc_test.mocks.dart';

@GenerateMocks([GetQuotes])
void main() {
  late QuoteBloc quoteBloc;
  late MockGetQuotes mockGetQuotes;

  setUp(() {
    mockGetQuotes = MockGetQuotes();
    quoteBloc = QuoteBloc(mockGetQuotes);
  });

  test('Initial state should be init state', () {
    expect(quoteBloc.state, QuoteInit());
  });

  final tQuoteModel = QuoteModel(quote: "quote", author: "author", category: "category");
  group('Quote BLoC test', () {
    blocTest<QuoteBloc, QuoteState>(
      'Should emit [Loading, Loaded] when fetching data is susscessful',
      build: () {
        when(mockGetQuotes.execute('')).thenAnswer((_) async => Right(tQuoteModel.toEntity()));
        return quoteBloc;
      },
      act: (bloc) => bloc.add(FetchQuote()),
      // add wait to match debounce time on actual BLoC
      // wait: const Duration(microseconds: 1000),
      expect: () => [QuoteLoading(), QuoteLoaded(tQuoteModel.toEntity())],
      verify: (bloc) => verify(mockGetQuotes.execute('')),
    );

    blocTest<QuoteBloc, QuoteState>(
      'Should emit [Loading, Error] when fetching data is unsusscessful',
      build: () {
        when(mockGetQuotes.execute('')).thenAnswer((_) async => const Left(ServerFailure('')));
        return quoteBloc;
      },
      act: (bloc) => bloc.add(FetchQuote()),
      // add wait to match debounce time on actual BLoC
      // wait: const Duration(microseconds: 1000),
      expect: () => [QuoteLoading(), const QuoteError('')],
      verify: (bloc) => verify(mockGetQuotes.execute('')),
    );
  });
}
