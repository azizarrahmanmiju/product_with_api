import 'package:flutter/material.dart';
import 'package:getdummy_product_by_http/api_service/service.dart';
import 'package:getdummy_product_by_http/utility/single%20productdetails.dart';
import 'package:intl/intl.dart';


class ProductDetailsScreen extends StatefulWidget {
  final String id;

  ProductDetailsScreen({required this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetailsScreen> {

  String formatDate(String dateString) {
   
    DateTime dateTime = DateTime.parse(dateString);

     return DateFormat('dd MMM, yyyy - HH:mm').format(dateTime);
   // return Dateformate('MMM dd, yyyy - HH:mm').format(parsedDate);
  }

  @override
  void initState() {
    super.initState();
    ProductService.getsingleproduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product id ${widget.id}"),
      ),
      body: FutureBuilder(
        future: ProductService.getsingleproduct(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child:  Text('No product data available'),
            );
          }

          final product = snapshot.data as singleProductdetails;

          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Thumbnail image
                      Image.network(
                        product.thumbnail,
                        fit: BoxFit.fitWidth,
                      ),
                      
                      // Product details container
                    
                        
                           Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                               child: Column(
                                  children: [
                                    // Title and Price
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            product.title,
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.onBackground,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                        Text('\$${product.price.toStringAsFixed(2)}'),
                                      ],
                                    ),
                                    // Category and Description
                                    Text(product.category, textAlign: TextAlign.left),
                                    Text(product.description),
                                    // Reviews Section
                                    SizedBox(height: 10),
                                    const Text(
                                      'Reviews:',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    SizedBox(height: 10),
                                    for (final reviews in product.review as List)
                                    
                                     // Loop over reviews
                                     Row(
                                      children: [
                                        Text(reviews.comment),
                                      ],
                                     )
                                      
                                      //   ListTile(
                                      //     title: Text(reviews.comment),
                                      //     subtitle: Text('Rating: ${reviews.rating} - By ${reviews.reviewerName}'),
                                      //     trailing: Text(formatDate(reviews.date)),
                                        
                                      // ),
                                  ],
                                ),
                              ),
                            ),
                         
                    
                     
                    ],
                  ),
                ),
              ),
           
          );
        },
      ),
    );
  }
}
