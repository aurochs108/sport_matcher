import 'package:http/http.dart' as http;

class HttpClientProvider {
  HttpClientProvider._();

  static final http.Client instance = http.Client();
}
