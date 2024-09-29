import 'package:flutter/material.dart';
import 'package:getdummy_product_by_http/api_service/service.dart';
import 'package:getdummy_product_by_http/utility/Product.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ProductService().getproduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          }

          final productList = snapshot.data!;
          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final product = productList[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text('${product.price} USD'),
                leading: Image.network(product.thumbnail, width: 50, height: 50),
              );
            },
          );
        },
      ),
    );
  }
}
