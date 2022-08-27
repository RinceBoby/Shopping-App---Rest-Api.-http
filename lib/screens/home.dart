import 'package:flutter/material.dart';
import 'package:rest_api/screens/allCategory.dart';
import 'package:rest_api/screens/cart_screen.dart';
import 'package:rest_api/screens/product_detail.dart';
import 'package:rest_api/services/apiService.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllCategory(),
                ),
              );
            },
            icon: const Icon(Icons.grid_view_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            ),
            icon: const Icon(Icons.shopping_cart_checkout_rounded),
          ),
        ],
      ),
      body: FutureBuilder(
        future: ApiService().getAllPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(
                      snapshot.data[index]['image'],
                      height: 70,
                      width: 70,
                    ),
                    title: Text(snapshot.data[index]['title']),
                    subtitle:
                        Text("Price: \$ ${snapshot.data[index]['price']}"),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetail(id: snapshot.data[index]['id']),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
