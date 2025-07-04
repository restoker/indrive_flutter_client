import 'package:flutter/material.dart';
import 'package:indrive_flutter_client/src/presentation/pages/auth/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
