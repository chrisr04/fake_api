import 'package:fake_api/core/errors/failure/failure.dart';

part 'no_internet_failure.dart';
part 'fetch_data_failure.dart';
part 'invalid_response_failure.dart';

class RemoteFailure extends Failure {
  const RemoteFailure(super.message, {this.statusCode});

  final int? statusCode;

  @override
  String toString() =>
      'Remote Failure: $message\nStatus Code: ${statusCode ?? ''}';
}
