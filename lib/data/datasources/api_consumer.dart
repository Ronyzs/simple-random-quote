import 'package:belajar_bloc/common/exception.dart';
import 'package:belajar_bloc/data/models/quote/quote_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class ApiConsumer {
  Future<QuoteModel> getQuotes(String category);
}

class ApiConsumerImpl implements ApiConsumer {
  final Dio dio;

  ApiConsumerImpl({required this.dio}) {
    dio
      ..options.baseUrl = 'https://api.api-ninjas.com/v1'
      ..options.headers['X-Api-Key'] = 'Q4GYGC11wOrz6D7ZRR57sFWRIQ9Fff0Uk2DBKg1W'
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
  }

  @override
  Future<QuoteModel> getQuotes(category) async {
    Response response = await dio.get('/quotes', queryParameters: {'category': category});

    if (response.statusCode == 200) {
      return QuoteModel.fromJson(response.data[0]);
    } else {
      throw ServerException();
    }
  }
}
