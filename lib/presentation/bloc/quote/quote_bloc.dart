import 'package:belajar_bloc/domain/entities/quote.dart';
import 'package:belajar_bloc/domain/usecases/get_quote.dart';
// import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  GetQuotes getQuotes;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  QuoteBloc(this.getQuotes) : super(QuoteInit()) {
    on<FetchQuote>(
      _handleFetchQuote,
    );
  }

  Future _handleFetchQuote(event, emit) async {
    emit(QuoteLoading());
    final result = await getQuotes.execute('');
    result.fold(
      (error) => emit(QuoteError(error.message)),
      (data) => emit(QuoteLoaded(data)),
    );
  }
}
