import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectionWidget extends StatelessWidget {
  final Widget widget;

  ConnectionWidget({required this.widget});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder:
          (BuildContext context, ConnectivityResult connection, Widget child) {
        final bool connected = connection != ConnectivityResult.none;
        // print(connected);
        return connected ? widget : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/image/wifi.png', height: 100.h, color: Color(0xff2C2830),),
            Text('No Internet Connection', textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp),)
          ],
        );
      },
      child: Container(),
    );
  }
}
