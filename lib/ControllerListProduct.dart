import 'package:get/get.dart';
import 'package:latihan_api_flutter/ProductResponseModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ControllerListProduct extends GetxController {
  RxList<ProductResponseModel> productResponseModelCtr =
      <ProductResponseModel>[].obs;
  RxBool isLoading = true.obs;

  SharedPreferences? prefs;

  RxString sessionUsername = "".obs;
  void loadSession() async {
    prefs = await SharedPreferences.getInstance();
    sessionUsername.value = prefs!.getString("username") ?? "no data";
    print(sessionUsername.value.toString());
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
    loadSession();
  }

  loadData() async {
    try {
      final response = await http.get(Uri.parse(
          "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline"));

      if (response.statusCode == 200) {
        //OK
        //mengisi data productResponseModelCtr dengan hasil json dari model
        productResponseModelCtr.value =
            productResponseModelFromJson(response.body);
      } else {
        print("status code : ${response.statusCode}");
      }
      isLoading.value = false;
    } catch (e) {
      print("error : $e");
    }
  }
}
