part of 'quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

class QuoteLoading extends QuoteState {}

class QuoteInit extends QuoteState {}

class QuoteError extends QuoteState {
  final String msg;

  const QuoteError(this.msg);

  @override
  List<Object> get props => [];
}

class QuoteLoaded extends QuoteState {
  final Quote quote;

  const QuoteLoaded(this.quote);

  @override
  List<Object> get props => [quote];
}
