import 'package:belajar_bloc/data/datasources/api_consumer.dart';
import 'package:belajar_bloc/domain/repositories/quote_repository.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  QuoteRepository,
  ApiConsumer,
  Dio,
])
void main() {}
