import 'package:belajar_bloc/presentation/bloc/quote/quote_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

// Quote
class FakeQuoteBloc extends MockBloc<QuoteEvent, QuoteState> implements QuoteBloc {}

class FakeQuoteEvent extends Fake implements QuoteEvent {}

class FakeQuoteState extends Fake implements QuoteState {}
