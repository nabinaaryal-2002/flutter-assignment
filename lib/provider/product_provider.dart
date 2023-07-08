import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onlinestore/api.dart';
import 'package:onlinestore/model/product.dart';
import 'package:onlinestore/model/product_state.dart';
import 'package:onlinestore/services/product_services.dart';

// final productDataProvider = FutureProvider((ref) => ProductProvider.getProducts());
//
//
// class ProductProvider {
//   static Dio dio = Dio();
//
//   //get all products
//   static Future<List<Product>> getProducts() async {
//     try {
//       final res = await dio.get(Api.baseUrl);
//       final data = (res.data as List).map((e) => Product.fromJson(e)).toList();
//       // print(res.data);
//       return data;
//     } on DioError catch (err) {
//       print(err);
//       throw {err.message};
//     }
//   }
// }

final productDataProvider  =  StateNotifierProvider<ProductProvider, ProductState>((ref) => ProductProvider(
    ProductState(isLoad: false, isError: false, errorMessage: '', productList: [])
));

class ProductProvider extends StateNotifier<ProductState>{
  static Dio dio = Dio();

  //get all products
  static Future<List<Product>> Productp() async {
    try {
      final res = await dio.get(Api.baseUrl);
      final data = (res.data as List).map((e) => Product.fromJson(e)).toList();
      // print(res.data);
      return data;
    } on DioError catch (err) {
      print(err);
      throw {err.message};
    }
  }
  ProductProvider(super.state){
    getProducts();
  }

  Future<void> getProducts()async{
    state = state.copyWith(isLoad: true, isError: false, errorMessage: '');
    final res = await ProductService.getProduct();
    res.fold(
            (l) => state = state.copyWith(isLoad: false, isError: true, errorMessage: l),
            (r) => state = state.copyWith(isLoad: false, isError: false, productList: r));
  }

  void getData(String text) {
    if (text.isNotEmpty) {
      final data = state.productList.where((element) => element.title.toLowerCase().contains(text.toLowerCase())).toList();
      if (data.isNotEmpty) {
        state = state.copyWith(productList: data);
      } else {
        state = state.copyWith(productList: []);
      }
    } else {
      getProducts();
      if (state.productList == []) {
        getProducts();
      }
    }
  }




}





