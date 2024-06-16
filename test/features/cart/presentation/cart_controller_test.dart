import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fake_api/fake_api.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late CartController cartController;
  late MockCartRepository mockRepository;
  late FakeApiParams fakeParams;

  setUpAll(() {
    fakeParams = FakeApiParams();
    mockRepository = MockCartRepository();
    cartController = CartController(mockRepository);
  });

  group('CartController getCarts', () {
    test('returns a List<CartEntity> when repository call is successful',
        () async {
      final carts = <CartEntity>[];
      when(() => mockRepository.getCarts(params: fakeParams))
          .thenAnswer((_) async => Right(carts));

      final result = await cartController.getCarts(params: fakeParams);

      expect(result, carts);
    });

    test('throws CartControllerException when repository call fails', () async {
      const failureMessage = 'Failed to get carts';
      when(() => mockRepository.getCarts(params: fakeParams)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => cartController.getCarts(params: fakeParams),
        throwsA(isA<CartControllerException>()),
      );
    });
  });

  group('CartController getCartById', () {
    final cart = CartEntity(
      id: 1,
      userId: 2,
      date: DateTime.now(),
      products: [],
    );

    test('returns CartEntity when repository call is successful', () async {
      when(() => mockRepository.getCartById(cart.id))
          .thenAnswer((_) async => Right(cart));

      final result = await cartController.getCartById(cart.id);

      expect(result, cart);
    });

    test('throws CartControllerException when repository call fails', () async {
      const failureMessage = 'Failed to get carts';
      when(() => mockRepository.getCartById(cart.id)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => cartController.getCartById(cart.id),
        throwsA(isA<CartControllerException>()),
      );
    });
  });

  group('CartController getCartsByUserId', () {
    const userId = 1;
    final carts = <CartEntity>[];

    test('returns a List<CartEntity> when repository call is successful',
        () async {
      when(() => mockRepository.getCartsByUserId(userId))
          .thenAnswer((_) async => Right(carts));

      final result = await cartController.getCartsByUserId(userId);

      expect(result, carts);
    });

    test('throws CartControllerException when repository call fails', () async {
      const failureMessage = 'Failed to get carts';
      when(() => mockRepository.getCartsByUserId(userId)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => cartController.getCartsByUserId(userId),
        throwsA(isA<CartControllerException>()),
      );
    });
  });

  group('CartController createCart', () {
    final cart = CartEntity(
      id: 1,
      userId: 2,
      date: DateTime.now(),
      products: [],
    );

    test('returns a CartEntity when repository call is successful', () async {
      when(() => mockRepository.createCart(cart))
          .thenAnswer((_) async => Right(cart));

      final result = await cartController.createCart(cart);

      expect(result, cart);
    });

    test('throws CartControllerException when repository call fails', () async {
      const failureMessage = 'Failed to get carts';
      when(() => mockRepository.createCart(cart)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => cartController.createCart(cart),
        throwsA(isA<CartControllerException>()),
      );
    });
  });

  group('CartController updateCart', () {
    final cart = CartEntity(
      id: 1,
      userId: 2,
      date: DateTime.now(),
      products: [],
    );

    test('returns a CartEntity when repository call is successful', () async {
      when(() => mockRepository.updateCart(cart))
          .thenAnswer((_) async => Right(cart));

      final result = await cartController.updateCart(cart);

      expect(result, cart);
    });

    test('throws CartControllerException when repository call fails', () async {
      const failureMessage = 'Failed to get carts';
      when(() => mockRepository.updateCart(cart)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => cartController.updateCart(cart),
        throwsA(isA<CartControllerException>()),
      );
    });
  });

  group('CartController deleteCart', () {
    final cart = CartEntity(
      id: 1,
      userId: 2,
      date: DateTime.now(),
      products: [],
    );

    test('returns a CartEntity when repository call is successful', () async {
      when(() => mockRepository.deleteCart(cart.id))
          .thenAnswer((_) async => Right(cart));

      final result = await cartController.deleteCart(cart.id);

      expect(result, cart);
    });

    test('throws CartControllerException when repository call fails', () async {
      const failureMessage = 'Failed to get carts';
      when(() => mockRepository.deleteCart(cart.id)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => cartController.deleteCart(cart.id),
        throwsA(isA<CartControllerException>()),
      );
    });
  });
}
