import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController scrollController = ScrollController();

  List<Product> products = [];

  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    getProducts();
    scrollController.addListener(loadMoreData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photos"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: false,
          itemCount: products.length,
          controller: scrollController,
          itemBuilder: (context, index) {},
        ),
      ),
    );
  }

  void loadMoreData() {}

  Future<void> getProducts() async {
    try {
      final response = await dio.get(
          "https://dummyjson.com/products?limit=15&skip=${products.length}&select=title,price,thumbnail");

      final List data = response.data["products"];
      print(data);
    } catch (e) {
      print(e);
    }
  }
}
