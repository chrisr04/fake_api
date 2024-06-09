# Fake Api

Fake Api es un paquete para Flutter que sirve para consumir los servicios de la [Fake Api Store](https://fakestoreapi.com/) de una forma sencilla y cómoda. Esto nos permite ahorra tiempo en la implementación de servicios y paquetes para realizar peticiones HTTP en nuestras aplicaciones hechas en Flutter.

## Comencemos

Antes de empezar a consumir la información de Fake Api Store es necesario crear nuestro cliente que nos permitira acceder a los datos. Para esto debemos crear una instancia de la clase **FakeApiClient** e inicializarla posteriormente llamando al método init() como se muestra a continuación:

```dart
final fakeApiClient = FakeApiClient();
fakeApiClient.init();
```

Cuando ya no necesites utilizar Fake Api en tu aplicación puedes liberar los recursos asociados al cliente http con el metodo close() como se muestra a continuación:

```dart
fakeApiClient.close()
```

**Nota:** No olvide llamar al método init(), de lo contrario al intentar acceder a los controladores recibirá un error del tipo **LateInitializationError**. Solo es necesaria una llamada y recomendamos hacerla justo despues de crear la instancia.

## Funcionalidades
Fake Api proporciona una manera bastante sencilla de obtener información del servicio, esto se logra accediendo a los controladores (auth, products, carts, users) proporcionados por la clase FakeApiClient para cada uno de los modelos de datos que nos brinda la Api.

Algunos de los metodos reciben parametros comunes que sirven para ordernar o filtrar los datos. Para facilitar su uso Fake Api proporciona la clase FakeApiParams que nos ayuda agrupando dichos parametros para configurar las llamadas.

### Parametros disponibles

- **[limit]** Indica qué queremos que nos retorne un numero especifico de items.
- **[sort]** Indica cómo queremos que ordenados nuestros items. Por defecto Fake Api Store retorna los items en orden ascendente.
- **[startDate]** Indica cuál será la fecha de creación mínima que deben tener los datos.
- **[endDate]** Indica cuál será la fecha de creación máxima que deben tener los datos.

**Nota:** En caso de que ocurra algun problema al obtener los datos se lanzará una excepción del tipo **FakeApiControllerException**.


### Autenticación
A continuación tienes un listado de los métodos disponibles en el controlador de autenticación:

#### logIn(String username, String password)
Nos permite iniciar sesion en la Fake Api Store y nos devuelve un token de acceso.

```dart
fakeApiClient.auth.logIn('admin', '123');
```

#### Modelo

```dart
class TokenEntity {
  const TokenEntity({required this.token});

  final String token;
}
```

### Productos
A continuación tienes un listado de los métodos disponibles en el controlador de productos:

#### getProducts(FakeApiParams params)
Nos devuelve una lista de productos. Si no se le configura el parametro limit retornará todos los productos disponibles

```dart
fakeApiClient.products.getProducts(
  params: FakeApiParms(
    limit: 5,
    sort: FakeApiSort.asc
  )
);
```
**Nota:** Solo admite los parametros limit y sort. Los demas no tendran ningun efecto en la consulta.

#### getProductById(int id)
Nos devuelve un unico producto que coincida con el id proporcionado.

```dart
fakeApiClient.products.getProductById(1);
```

#### getProductsByCategory(String category)
Nos devuelve un listado de productos pertenecientes a la categoria proporcionada.

```dart
fakeApiClient.products.getProductsByCategory('jewelery');
```

#### getCategories()
Nos devuelve un listado de strings con los nombres de las categorias disponibles.

```dart
fakeApiClient.products.getCategories();
```

#### Modelo

```dart
class ProductEntity {
  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingEntity rating;
}
```

### Usuarios
A continuación tienes un listado de los métodos disponibles en el controlador de usuarios:

#### getUsers(FakeApiParams params)
Nos devuelve una lista de usuarios. Si no se le configura el parametro limit retornará todos los usuarios disponibles

```dart
fakeApiClient.users.getUsers(
  params: FakeApiParms(
    limit: 5,
    sort: FakeApiSort.asc
  )
);
```
**Nota:** Solo admite los parametros limit y sort. Los demas no tendran ningun efecto en la consulta.

#### getUserById(int id)
Nos devuelve un unico usuario que coincida con el id proporcionado.

```dart
fakeApiClient.users.getUserById(1);
```

#### createUser(UserEntity user)
Crea un nuevo usuario y lo retorna

```dart
fakeApiClient.users.createUser(user);
```

#### Modelo

```dart
class UserEntity {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  final int id;
  final UserNameEntity name;
  final String email;
  final String phone;
  final AddressEntity address;
}
```

### Carritos de compra
A continuación tienes un listado de los métodos disponibles en el controlador de carritos:

#### getCarts(FakeApiParams params)
Nos devuelve una lista de carritos. Si no se le configura el parametro limit retornará todos los carritos disponibles

```dart
fakeApiClient.carts.getCarts(
  params: FakeApiParms(
    limit: 5,
    sort: FakeApiSort.asc
  )
);
```
**Nota:** Solo admite los parametros limit y sort. Los demas no tendran ningun efecto en la consulta.

#### getCartById(int id)
Nos devuelve un unico carrito que coincida con el id proporcionado.

```dart
fakeApiClient.carts.getCartById(1);
```

#### getCartsByUserId(int userId, FakeApiParams params)
Nos devuelve un listado de carritos que coincida con el userId proporcionado.

```dart
fakeApiClient.carts.getCartsByUserId(
  1,
  params: FakeApiParms(
    limit: 5,
    sort: FakeApiSort.asc
    startDate: DateTime.now(),
    endDate: DateTime.now()
  )
);
```

#### createCart(CartEntity cart)
Crea un nuevo carrito y lo retorna.

```dart
fakeApiClient.carts.createCart(cart);
```

#### updateCart(CartEntity cart)
Actualiza los datos de un carrito existente que coincida con el id carrito pasado por parametro y lo retorna.

```dart
fakeApiClient.carts.updateCart(cart);
```

#### deleteCart(int id)
Elimina un carrito existente que concida con el id proporcionado y lo retorna.

```dart
fakeApiClient.carts.deleteCart(1);
```

#### Modelo

```dart
class CartEntity {
  const CartEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  final int id;
  final int userId;
  final DateTime date;
  final List<CartProductEntity> products;
}
```

## Como Usar

```dart
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final FakeApiClient fakeApiClient;

  @override
  void initState() {
    fakeApiClient = FakeApiClient();
    fakeApiClient.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Fake Api Products',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: FutureBuilder(
          future: fakeApiClient.products.getProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final products = snapshot.data!;

            return ListView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Image(
                          image: NetworkImage(product.image),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.title,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    fakeApiClient.close();
    super.dispose();
  }
}

```

### Pasos para ejecutar el ejemplo:

**Paso 1:**

Descarga o clona este repositorio con el siguiente link:

```
https://github.com/chrisr04/fake_api.git
```

**Paso 2:**

Navega hacia la carpeta example que se encuentra dentro del proyecto

```
cd ./example
```

**Paso 3:**

Ejecuta el siguiente comando para descargar las dependencias necesarias

```
flutter pub get 
```

**Paso 4:**

Luego ejecuta el siguiente comando para levantar la aplicación, recuerda tener un emulador disponible en tu ordenador o en su defecto un dispositivo físico conectado

```
flutter run
```

## Como probar

Para realizar test utilizando Fake Api proporcionamos el método initMocks(). Este nos permite pasarle los mocks necesarios para simular las peticiones de todos los controladores, aquí tienes un ejemplo utilizando mocktail:

```dart
class MockProductController extends Mock implements ProductController {}

class MockUserController extends Mock implements UserController {}

class MockCartController extends Mock implements CartController {}

class MockAuthController extends Mock implements AuthController {}

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
```
**Nota:** El método initMocks() solo debe usarse dentro de los test. Usarlo fuera de este contexto provocará un mensaje de advertencia por parte del analyzer.