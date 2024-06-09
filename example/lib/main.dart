import 'package:fake_api/fake_api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

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
