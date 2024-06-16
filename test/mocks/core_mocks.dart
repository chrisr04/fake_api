import 'package:fake_api/core/core.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockResponse extends Mock implements Response {}
