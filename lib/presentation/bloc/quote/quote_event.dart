part of 'quote_bloc.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object> get props => [];
}

class FetchQuote extends QuoteEvent {}

class FetchMantap extends QuoteEvent {}

class FetchKelas extends QuoteEvent {}
