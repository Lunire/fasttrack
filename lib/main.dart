import 'package:fasttrack/pages/auth/loading.dart';
import 'package:fasttrack/pages/job/job_page.dart';
import 'package:flutter/material.dart';

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
      home: const JobPage(), // เริ่มต้นที่หน้า Loading
    );
  }
}
