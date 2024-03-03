import 'package:belajar_bloc/data/datasources/api_consumer.dart';
import 'package:belajar_bloc/data/repositories/quote_repositories_impl.dart';
import 'package:belajar_bloc/domain/repositories/quote_repository.dart';
import 'package:belajar_bloc/domain/usecases/get_quote.dart';
import 'package:belajar_bloc/presentation/bloc/quote/quote_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // Bloc
  locator.registerFactory(() => QuoteBloc(locator()));

  // use cases
  locator.registerLazySingleton(() => GetQuotes(locator()));

  // respository
  locator.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(
      apiConsumer: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<ApiConsumer>(() => ApiConsumerImpl(dio: locator()));

  // Dio
  locator.registerFactory<Dio>(() => Dio());
}
