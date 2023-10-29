import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_api_flutter/ControllerListProduct.dart';
import 'package:latihan_api_flutter/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductListPage extends StatelessWidget {
  final productController = Get.put(ControllerListProduct());
  ProductListPage({Key? key}) : super(key: key);

  SharedPreferences? prefs;

  void intialObject() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    intialObject();
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                await prefs!.setString('username', "");
                await prefs!.setString('password', "");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Center(
        child: Obx(
          () => productController.isLoading.value
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Text(productController.sessionUsername.value.toString()),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            productController.productResponseModelCtr.length,
                        itemBuilder: (BuildContext context, int index) {
                          final product =
                              productController.productResponseModelCtr[index];
                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: Card(
                              child: Text(product.name),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
