import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../api.dart';
import '../model/product.dart';

class ProductService {
  static Dio dio = Dio();

  static Future<Either<String, List<Product>>> getProduct() async {
    try {
      final res = await dio.get(Api.baseUrl);
      final data = (res.data as List).map((e) => Product.fromJson(e)).toList();
      // print(res.data);
      return Right(data);
    } on DioError catch (err) {
      print(err);
      return Left('${err.message}');
    }
  }
}