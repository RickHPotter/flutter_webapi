import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    String log =
        'Request for ${data.baseUrl},\n'
        'Headers: ${data.headers},\n'
        'Body: ${data.body}';
    logger.wtf(log);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    String log =
        'Response from ${data.url},\n'
        'StatusCode: ${data.statusCode},\n'
        'Headers: ${data.headers},\n'
        'Body: ${data.body}';

    if (data.statusCode ~/ 100 == 2) {
      logger.i(log);
    } else {
      logger.e(log);
    }

    return data;
  }

}