import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:onlinestore/provider/cart_provider.dart';
class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final cartData = ref.watch(cartProvider);
    final cartTotal = ref.read(cartProvider.notifier).total;
    return Scaffold(
      backgroundColor: const Color(0xffefefef),
      appBar: AppBar(
        title: Text('Cart List'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: cartData.isEmpty ? Center(child: Text('No Product in the Cart List', style: TextStyle(fontSize: 16.sp),),) :  Column(
        children: [
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: cartData.length,
                itemBuilder: (context , index){
                  final cartItem = cartData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context){
                              ref.read(cartProvider.notifier).remove(cartItem);
                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            borderRadius: BorderRadius.circular(10.0),
                          )
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(cartItem.image, height: 90.h, width: 60.w,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cartItem.title, maxLines: 2, style: TextStyle(overflow: TextOverflow.ellipsis),),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Rs ${cartItem.price.toString()}'),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(4.0)
                                          ),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                  onTap:(){
                                                    ref.read(cartProvider.notifier).singleRemove(cartItem);
                                                  } ,
                                                  child: Icon(Icons.minimize)),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                                child: Text(cartItem.quantity.toString(), style: TextStyle(fontSize: 16.sp),),
                                              ),
                                              GestureDetector(
                                                  onTap: (){
                                                    ref.read(cartProvider.notifier).singleAdd(cartItem);
                                                  },
                                                  child: Icon(Icons.add))
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          cartData.isEmpty ? Container() :  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14.sp),),
                Text('Rs $cartTotal', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14.sp),),
              ],
            ),
          )
        ],
      ),
    );
  }
}