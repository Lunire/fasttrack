import 'package:fasttrack/pages/auth/loading.dart';
import 'package:flutter/material.dart';
import 'package:fasttrack/pages/home/customer_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastTrack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CustomerHome(), // เริ่มต้นที่หน้า Loading
    );
  }
}
