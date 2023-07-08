import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:onlinestore/view/homepage.dart';
import 'package:onlinestore/view/screen.dart';
import 'model/cart_item.dart';


final box = Provider<List<CartItem>>((ref) => []);


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //lock orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xff2C2830),
  ));

  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  final cartBox =await Hive.openBox<CartItem>('carts');

  runApp(ProviderScope(
      overrides: [
        box.overrideWithValue(cartBox.values.toList())
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
    );
  }
}