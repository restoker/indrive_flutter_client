import 'package:flutter/material.dart';

class ClientMapseekerPage extends StatelessWidget {
  const ClientMapseekerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Hola Desde Client Mapseeker Page',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
