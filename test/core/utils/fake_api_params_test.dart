import 'package:test/test.dart';
import 'package:fake_api/core/utils/fake_api_sort.dart';
import 'package:fake_api/core/utils/fake_api_params.dart';

void main() {
  group('FakeApiParams', () {
    test('toMap returns correct map when all fields are provided', () {
      final params = FakeApiParams(
        limit: 10,
        sort: FakeApiSort.asc,
        startDate: DateTime.parse('2023-01-01T00:00:00Z'),
        endDate: DateTime.parse('2023-12-31T23:59:59Z'),
      );

      expect(params.toMap(), {
        'limit': 10,
        'sort': 'asc',
        'startdate': '2023-01-01T00:00:00.000Z',
        'enddate': '2023-12-31T23:59:59.000Z',
      });
    });

    test('toMap returns correct map when some fields are null', () {
      final params = FakeApiParams(
        limit: 5,
        startDate: DateTime.parse('2023-01-01T00:00:00Z'),
      );

      expect(params.toMap(), {
        'limit': 5,
        'startdate': '2023-01-01T00:00:00.000Z',
      });
    });

    test('toMap returns empty map when all fields are null', () {
      final params = FakeApiParams();

      expect(params.toMap(), {});
    });

    test('toMap returns correct map when only sort is provided', () {
      final params = FakeApiParams(
        sort: FakeApiSort.desc,
      );

      expect(params.toMap(), {
        'sort': 'desc',
      });
    });
  });
}
