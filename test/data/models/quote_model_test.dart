import 'package:belajar_bloc/data/models/quote/quote_model.dart';
import 'package:belajar_bloc/domain/entities/quote.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tQuoteModel = QuoteModel(
    quote: 'Ini Quote',
    author: 'Ini Author',
    category: 'Ini Kategory',
  );

  const tQuote = Quote(
    author: 'Ini Author',
    quote: 'Ini Quote',
    category: 'Ini Kategory',
  );

  test('Should be subclass of Quote entity', () async {
    final result = tQuoteModel.toEntity();
    expect(result, tQuote);
  });
}
