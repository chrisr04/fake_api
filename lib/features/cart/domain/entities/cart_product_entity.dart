class CartProductEntity {
  const CartProductEntity({
    required this.productId,
    required this.quantity,
    required this.title,
    required this.price,
    required this.image,
  });

  final int productId;
  final int quantity;
  final String title;
  final double price;
  final String image;
}
