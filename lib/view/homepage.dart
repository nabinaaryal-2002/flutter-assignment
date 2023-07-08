import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:onlinestore/connection.dart';
import 'package:onlinestore/provider/product_provider.dart';
import 'package:onlinestore/view/detail_page.dart';

import 'cart.dart';
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {
    final productData = ref.watch(productDataProvider);

    return Scaffold(
      backgroundColor: Color(0xffefefef),
      appBar: AppBar(
        title: Text('Online Store', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Get.to(() => CartPage(), transition: Transition.leftToRight);
          }, icon: Icon(Icons.shopping_bag,color: Colors.black))
        ],

      ),
      body: ConnectionWidget(
        widget: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 2.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 2.0),
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Color(0xff2C2830),
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Color(0xff2C2830))),
                ),
                onChanged: (val){
                  ref.read(productDataProvider.notifier).getData(val);
                },

              ),
            ),
            productData.isLoad ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Transform.scale(scale: 0.8, child: CircularProgressIndicator(color: Color(0xff2C2830),)),
            ) :  Expanded(
                child: RefreshIndicator(
                  onRefresh: () async{
                    ref.invalidate(productDataProvider);
                  },
                  child: MasonryGridView.builder(
                    physics: const BouncingScrollPhysics(),
                    key: const PageStorageKey<String>('page'),
                    padding: EdgeInsets.all(4.0),
                    gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: productData.productList.length,
                    itemBuilder: (context, index) {
                      final products = productData.productList[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=> DetailPage(product: products), transition: Transition.leftToRightWithFade);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Hero(
                                      tag: 'image-${products.id}',
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CachedNetworkImage(
                                          errorWidget: (context, url, error) => const Center(child: Text('no image')),
                                          imageUrl: products.image,
                                          placeholder: (context,url)=> SizedBox(
                                            height: 100.h,
                                            child: const Center(child:
                                            SpinKitThreeInOut(
                                              size: 15.0,
                                              color: Color(0xff2C2830),
                                            )),
                                          ),
                                        ),
                                      ),
                                    )
                                ),
                                Container(
                                  padding: EdgeInsets.all(6.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(products.title, maxLines: 2, style: TextStyle(overflow: TextOverflow.ellipsis),),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.star, color: Color(0xffFFC501),size: 18,),
                                            Text('${products.rating.rate.toString()}/5', style: TextStyle(fontSize: 11.sp),),
                                          ],
                                        ),
                                      ),
                                      Text('Rs. ${products.price.toString()}', style: TextStyle(fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
            )

          ],
        ),
      ),
    );
  }
}