import 'package:fake_api/features/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import '../mocks/controller_mocks.dart';

void main() {
  late final AuthController mockAuth;
  late final ProductController mockProducts;
  late final UserController mockUsers;
  late final CartController mockCarts;
  late final FakeApiClient fakeApiClient;

  setUpAll(() {
    mockAuth = MockAuthController();
    mockProducts = MockProductController();
    mockUsers = MockUserController();
    mockCarts = MockCartController();
    fakeApiClient = FakeApiClient();
    fakeApiClient.initMocks(mockAuth, mockProducts, mockUsers, mockCarts);
  });

  group('ProductFeatures:', () {
    test(
      'when getProducts() is called then returns a ProductEntity list',
      () async {
        when(() => mockProducts.getProducts()).thenAnswer((_) async => []);

        final products = await fakeApiClient.products.getProducts();

        expect(products, isA<List<ProductEntity>>());
      },
    );

    test(
      'when getProducts() is called then returns a ProductControllerException error',
      () async {
        when(() => mockProducts.getProducts()).thenThrow(
          ProductControllerException('Something was wrong'),
        );

        expect(
          () => fakeApiClient.products.getProducts(),
          throwsA(isA<ProductControllerException>()),
        );
      },
    );
  });
}
