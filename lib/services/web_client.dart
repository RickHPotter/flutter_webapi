import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import '../env.dart';
import 'http_interceptors.dart';

class WebService {
  static String url = Env.url;

  static http.Client start({int timeOut = 4}) {
    return InterceptedClient.build(
        interceptors: [LoggingInterceptor()],
        requestTimeout: Duration(seconds: timeOut)
    );
  }

}