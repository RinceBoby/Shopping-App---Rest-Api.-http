import 'package:flutter/material.dart';
import 'package:rest_api/screens/product_detail.dart';
import 'package:rest_api/services/apiService.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({required this.categoryName, Key? key})
      : super(key: key);
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(categoryName.toUpperCase()),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiService().getProductByCategory(categoryName),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      snapshot.data[index]['image'],
                      width: 100,
                      height: 100,
                    ),
                    title: Text(snapshot.data[index]['title']),
                    subtitle: Text(
                      "Price: \$ ${snapshot.data[index]['price']}",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetail(id: snapshot.data[index]['id']),
                      ),
                    ),
                  ),
                );
              },
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
