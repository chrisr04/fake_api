import 'package:mocktail/mocktail.dart';
import 'package:fake_api/features/user/user.dart';
import 'package:fake_api/features/product/product.dart';
import 'package:fake_api/features/cart/cart.dart';
import 'package:fake_api/features/auth/auth.dart';

class MockProductController extends Mock implements ProductController {}

class MockUserController extends Mock implements UserController {}

class MockCartController extends Mock implements CartController {}

class MockAuthController extends Mock implements AuthController {}
