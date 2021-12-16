import 'package:flutter/material.dart';
import 'package:flutter_app_bsalon/domain/controller/connectivity.dart';
import 'package:flutter_app_bsalon/domain/models/public_product.dart';
import 'package:flutter_app_bsalon/ui/widgets/productos/product_card.dart';
import 'package:get/get.dart';
import 'package:flutter_app_bsalon/data/services/product_pool.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ProductPage> {
  late ProductPoolService service;
  late Future<List<PublicProduct>> futureProducts;
  late ConnectivityController connectivityController;

  @override
  void initState() {
    super.initState();
    service = ProductPoolService();
    futureProducts = service.fecthData();
    connectivityController = Get.find<ConnectivityController>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PublicProduct>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              PublicProduct product = items[index];
              return ProductCard(
                id: product.id,
                brand: product.brand,
                name: product.name,
                price: product.price,
                pricesign: product.pricesign,
                currency: product.currency,
                imagelink: product.imagelink,
                productlink: product.productlink,
                websitelink: product.websitelink,
                description: product.description,
                category: product.category,
                producttype: product.producttype,
                onApply: () => {
                  Get.snackbar('Has aplicado', 'Successfully created',
                      snackPosition: SnackPosition.BOTTOM),
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
