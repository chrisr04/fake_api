import 'package:fake_api/core/utils/fake_api_sort.dart';

/// Allow configure common request params availables in the Fake API.
///
/// [limit] It allows configure a specific number of elements in the response.
///
/// [sort] It allows configure the ascending or descending order of response elements.
///
/// [startDate] It allows configure a start date for filter the elements.
///
/// [endDate] It allows configure a end date for filter the elements.
class FakeApiParams {
  FakeApiParams({
    this.limit,
    this.sort,
    this.startDate,
    this.endDate,
  });

  int? limit;
  FakeApiSort? sort;
  DateTime? startDate;
  DateTime? endDate;

  Map<String, dynamic> toMap() => {
        if (limit != null) 'limit': limit,
        if (sort != null) 'sort': sort!.value,
        if (startDate != null) 'startdate': startDate!.toIso8601String(),
        if (endDate != null) 'enddate': endDate!.toIso8601String(),
      };
}
