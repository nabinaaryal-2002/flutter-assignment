// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:onlinestore/view/cart.dart';
// import 'package:onlinestore/view/homepage.dart';
// class ScreenPage extends StatefulWidget {
//   const ScreenPage({super.key});
//
//   @override
//   State<ScreenPage> createState() => _ScreenPageState();
// }
//
// class _ScreenPageState extends State<ScreenPage> {
//   int _selectedIndex = 0;
//   static List<Widget> _widgetOptions = <Widget>[
//   HomePage(),
//   CartPage()
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//       bottomNavigationBar: NavigationBarTheme(
//         data: NavigationBarThemeData(
//             backgroundColor: Color(0xff2C2830),
//             indicatorColor: Color(0xff4A4257),
//             iconTheme: MaterialStateProperty.all(
//                 IconThemeData(color: Colors.white)
//             ),
//             labelTextStyle: MaterialStateProperty.all(
//                 TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, color: Colors.white)
//             )
//         ),
//         child: NavigationBar(
//           height: 60.h,
//           selectedIndex: _selectedIndex,
//           labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
//           onDestinationSelected: (index){
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           destinations: const [
//             NavigationDestination(
//               icon: Icon(Icons.home_outlined),
//               selectedIcon: Icon(Icons.home_filled),
//               label: 'Products',
//             ),
//             NavigationDestination(
//                 icon: Icon(Icons.shopping_cart_outlined),
//                 selectedIcon: Icon(Icons.shopping_cart),
//                 label: 'Cart')
//           ],
//         ),
//       ),
//     );
//   }
// }