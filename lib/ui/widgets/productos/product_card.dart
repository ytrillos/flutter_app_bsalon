import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String id,
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

  final VoidCallback onApply;

  // OfferCard constructor
  const ProductCard(
      {Key? key,
      required this.id,
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
      required this.producttype,
      required this.onApply})
      : super(key: key);

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters
  @override
  Widget build(BuildContext context) {
    var heading = '$currency $pricesign $price';
    var subheading = id + ' ' + name;
    var cardImage = NetworkImage(imagelink);
    var supportingText = description;

    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(heading),
              subtitle: Text(subheading),
              trailing: const Icon(Icons.favorite_outline),
            ),
            SizedBox(
              height: 200.0,
              child: Ink.image(
                image: cardImage,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                supportingText,
                //overflow: TextOverflow.ellipsis
              ),
            ),
            ButtonBar(
              children: [
                TextButton(
                  child: const Text('CONTACT'),
                  onPressed: () {/* ... */},
                ),
                TextButton(
                  child: const Text('LEARN MORE'),
                  onPressed: () {/* ... */},
                )
              ],
            )
          ],
        ));
  }
}
