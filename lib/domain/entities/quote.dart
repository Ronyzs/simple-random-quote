import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  const Quote({
    required this.author,
    required this.quote,
    required this.category,
  });

  final String quote;
  final String author;
  final String category;

  @override
  List<Object> get props => [author, quote, category];
}
