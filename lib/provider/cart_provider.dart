
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:onlinestore/model/cart_item.dart';

import '../main.dart';
import '../model/cart_item.dart';
import '../model/product.dart';

final cartProvider = StateNotifierProvider<CartProvider, List<CartItem>>((ref) => CartProvider(ref.watch(box)));

class CartProvider extends StateNotifier<List<CartItem>>{
  CartProvider(super.state);

  String add(Product product){
    if(state.isEmpty){
      final newCart = CartItem(
          id: product.id,
          title: product.title,
          price: product.price,
          description: product.description,
          category: product.category,
          image: product.image,
          rating: product.rating.rate,
          quantity: 1
      );
      final box= Hive.box<CartItem>('carts').add(newCart);
      state= [...state,newCart];
      return 'added to cart list';
    }else{
      final prev = state.firstWhere((element) => element.id == product.id,
          orElse: ()=> CartItem(id: 0, title: 'no data', price: 0.0, description: '', category: '', image: '', rating: 0.0,
              quantity: 0
          ));

      if(prev.title == 'no data'){
        final newCart = CartItem(
          id: product.id,
          title: product.title,
          price: product.price,
          description: product.description,
          category: product.category,
          image: product.image,
          rating: product.rating.rate,
          quantity: 1,

        );
        final box= Hive.box<CartItem>('carts').add(newCart);
        state = [...state, newCart];
        return 'added to cart list';
      }else{
        return 'this item is already in cart list';
      }
    }
  }

  //remove cart item
  void remove(CartItem cartItem){
    cartItem.delete();
    state.remove(cartItem);
    state = state.where((element) => element != cartItem).toList();
  }

  void singleAdd(CartItem cartItem){
    cartItem.quantity = cartItem.quantity + 1;
    cartItem.save();
    state = [
      for(final c in state) if(c == cartItem) cartItem else c
    ];
  }

  void singleRemove(CartItem cartItem){
    if(cartItem.quantity > 1){
      cartItem.quantity = cartItem.quantity - 1;
      cartItem.save();
      state = [
        for(final c in state) if(c == cartItem) cartItem else c
      ];
    }
  }


  //get total amount
  double get total {
    double total = 0;
    for(final cart in state){
      total += cart.price * cart.quantity;
    }
    return total;
  }

}