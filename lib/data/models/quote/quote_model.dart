import 'package:belajar_bloc/domain/entities/quote.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

@freezed
class QuoteModel with _$QuoteModel {
  factory QuoteModel({
    required String quote,
    required String author,
    required String category,
  }) = _QuoteModel;

  factory QuoteModel.fromJson(Map<String, dynamic> json) => _$QuoteModelFromJson(json);
}

// Define extension to convert QuoteModel to an Entity
extension QuoteModelExtension on QuoteModel {
  Quote toEntity() {
    return Quote(
      quote: quote,
      author: author,
      category: category,
    );
  }
}
