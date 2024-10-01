import 'dart:convert';

import 'package:getdummy_product_by_http/utility/Product.dart';
import 'package:getdummy_product_by_http/utility/single%20productdetails.dart';
import 'package:http/http.dart' as http;


class ProductService {
  

 static Future <List<Product>> getproduct() async {
    final  url = Uri.parse('https://dummyjson.com/products');
    final response = await http.get(url);
     
          if (response.statusCode == 200) {
             final data = jsonDecode(response.body)['products'] as List;
              return data.map((product) => Product.fromJson(product)).toList();
          } else {
              throw Exception('Failed to load products');
           }

    
  }

 static Future <singleProductdetails?> getsingleproduct (String id) async{
final  url = Uri.parse('https://dummyjson.com/products/'+id);

     final response = await http.get(url);
     final decoded = json.decode(response.body);
     
     if(response.statusCode == 200){
      return singleProductdetails.fromJson(decoded);
     }
    
  }
 
}
