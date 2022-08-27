// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  //
  Future getAllPosts() async {
    final allProductsUrl = Uri.parse("https://fakestoreapi.com/products");
    final response = await http.get(allProductsUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getSingleProduct(int id) async {
    final singleProductUrl = Uri.parse("https://fakestoreapi.com/products/$id");
    final response = await http.get(singleProductUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getAllCategories() async {
    final allCategories =
        Uri.parse("https://fakestoreapi.com/products/categories");
    final response = await http.get(allCategories);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getProductByCategory(String catName) async {
    final productsByCategory =
        Uri.parse("https://fakestoreapi.com/products/category/$catName");
    final response = await http.get(productsByCategory);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getCart(String userId) async {
    final getCartProducts = Uri.parse("https://fakestoreapi.com/carts/$userId");
    final response = await http.get(getCartProducts);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  //<<<<<POST_Request>>>>>//
  Future userLogin(String username, String password) async {
    final logiUrl = Uri.parse("https://fakestoreapi.com/auth/login");
    final response = await http.post(
      logiUrl,
      body: {
        "username": username,
        "password": password,
      },
    );
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  //<<<<<PUT_Request>>>>>//
  Future updateCart(String userId, String productId) async {
    final updateCartUrl = Uri.parse("http://fakestoreapi.com/carts/$userId");
    final response = await http.put(
      updateCartUrl,
      body: {
        "userId": userId,
        "date": DateTime.now().toString(),
        "products": [
          {
            "productId": productId,
            "quantity": "1",
          }
        ]
      },
    );
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  //<<<<<DELETE_Request>>>>>//
  Future removeFromCart(String userId) async {
    final removeCartUrl = Uri.parse("http://fakestoreapi.com/carts/$userId");
    final response = await http.delete(removeCartUrl);

    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  //<<<<<User_Authendication>>>>>//
  Future userAuthendication(String username, String password) async {
    final userAuthUrl = Uri.parse("http://api.somewhere.io");
    final response = await http.post(
      userAuthUrl,
      body: {
        "username": username,
        "password": password,
      },
    );
    print(response.statusCode);
    print(response.body);
    return json.encode(response.body);
  }

  //
  //OR//
  //
  //<<<<<User_Authendication>>>>>//
  Future userAutherization(String username, String password) async {
    final userAuthzUrl = Uri.parse("http://api.somewhere.io");
    String basicAuth =
        "Basic ${base64Encode(utf8.encode("$username:$password"))}";
    final response = await http.get(
      userAuthzUrl,
      headers: {
        "Content-Type": "application/json",
        "authorization": basicAuth,
      },
    );
    print(response.statusCode);
    print(response.body);
  }

  //<<<<<Bearer_Authendication>>>>>//
  Future bearerAuthendication() async {
    final authUrl = Uri.parse("http://somewhere.io");

    const accessToken = "Some access token";
    final response = await http.get(
      authUrl,
      headers: {
        "Content-Type": "application/json",
        "authorization": "Bearer $accessToken"
      },
    );
    print(response.statusCode);
    print(response.body);
  }
}
