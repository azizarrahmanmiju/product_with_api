


import 'package:flutter/material.dart';
import 'package:getdummy_product_by_http/Screen/Homescreen.dart';

void main(){
  runApp(const Myapp());
}


class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListPage(),
    );
  }
}
