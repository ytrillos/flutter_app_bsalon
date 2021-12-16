class PublicProduct {
  String id,
      brand,
      name,
      price,
      pricesign,
      currency,
      imagelink,
      productlink,
      websitelink,
      description,
      category,
      producttype;

  PublicProduct(
      {required this.id,
      required this.brand,
      required this.name,
      required this.price,
      required this.pricesign,
      required this.currency,
      required this.imagelink,
      required this.productlink,
      required this.websitelink,
      required this.description,
      required this.category,
      required this.producttype});

  //ACTIVIDAD
  //IMPLEMENTE LA CONVERSIÓN DE JSON A OBJETO
  factory PublicProduct.fromJson(Map<String, dynamic> map) {
    return PublicProduct(
        id: map['id'].toString(),
        brand: map['brand'] ?? '',
        name: map['name'] ?? '',
        price: map['price'] ?? '0.0',
        pricesign: map['price_sign'] ?? '\$',
        currency: map['currency'] ?? 'USD',
        imagelink: map['image_link'] ?? '',
        productlink: map['product_link'] ?? '',
        websitelink: map['website_link'] ?? '',
        description: map['description'] ?? '',
        category: (map['category'] ?? ''),
        producttype: map['product_type']);
  }
}
