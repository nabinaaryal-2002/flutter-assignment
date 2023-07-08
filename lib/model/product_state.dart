import 'package:onlinestore/model/product.dart';

class ProductState{
  final bool isLoad;
  final bool isError;
  final String errorMessage;
  final List<Product> productList;

  ProductState({
    required this.isLoad,
    required this.isError,
    required this.errorMessage,
    required this.productList,
  });

  ProductState copyWith(
      {bool? isLoad,
        bool? isError,
        String? errorMessage,
        List<Product>? productList,
      }) {
    return ProductState(
      isLoad: isLoad ?? this.isLoad,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      productList: productList ?? this.productList,
    );
  }

}