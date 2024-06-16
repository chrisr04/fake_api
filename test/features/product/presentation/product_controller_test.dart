import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fake_api/fake_api.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ProductController productController;
  late MockProductRepository mockRepository;
  late FakeApiParams fakeParams;

  setUpAll(() {
    fakeParams = FakeApiParams();
    mockRepository = MockProductRepository();
    productController = ProductController(mockRepository);
  });

  group('ProductController getProducts', () {
    test('returns a List<ProductEntity> when repository call is successful',
        () async {
      final products = <ProductEntity>[];
      when(() => mockRepository.getProducts(params: fakeParams))
          .thenAnswer((_) async => Right(products));

      final result = await productController.getProducts(params: fakeParams);

      expect(result, products);
    });

    test('throws ProductControllerException when repository call fails',
        () async {
      const failureMessage = 'Failed to get products';
      when(() => mockRepository.getProducts(params: fakeParams)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => productController.getProducts(params: fakeParams),
        throwsA(isA<ProductControllerException>()),
      );
    });
  });

  group('ProductController getProductById', () {
    const product = ProductEntity(
      id: 1,
      title: 'Sample Product',
      price: 2.0,
      description: 'This is a sample product description.',
      category: 'Sample Category',
      image: 'image',
      rating: RatingEntity(rate: 4.5, count: 20),
    );

    test('returns a ProductEntity when repository call is successful',
        () async {
      when(() => mockRepository.getProductById(product.id))
          .thenAnswer((_) async => const Right(product));

      final result = await productController.getProductById(product.id);

      expect(result, product);
    });

    test('throws ProductControllerException when repository call fails',
        () async {
      const failureMessage = 'Failed to get products';
      when(() => mockRepository.getProductById(product.id)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => productController.getProductById(product.id),
        throwsA(isA<ProductControllerException>()),
      );
    });
  });

  group('ProductController getCategories', () {
    test('returns a List<ProductEntity> when repository call is successful',
        () async {
      final categories = ['electronics'];
      when(() => mockRepository.getCategories())
          .thenAnswer((_) async => Right(categories));

      final result = await productController.getCategories();

      expect(result, categories);
    });

    test('throws ProductControllerException when repository call fails',
        () async {
      const failureMessage = 'Failed to get products';
      when(() => mockRepository.getCategories()).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => productController.getCategories(),
        throwsA(isA<ProductControllerException>()),
      );
    });
  });

  group('ProductController getProductsByCategory', () {
    const category = 'electronics';
    final products = <ProductEntity>[];

    test('returns a List<ProductEntity> when repository call is successful',
        () async {
      when(() => mockRepository.getProductsByCategory(category))
          .thenAnswer((_) async => Right(products));

      final result = await productController.getProductsByCategory(category);

      expect(result, products);
    });

    test('throws productControllerException when repository call fails',
        () async {
      const failureMessage = 'Failed to get products';
      when(() => mockRepository.getProductsByCategory(category)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => productController.getProductsByCategory(category),
        throwsA(isA<ProductControllerException>()),
      );
    });
  });
}
