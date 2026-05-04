import 'package:flutter/material.dart';

class NewCarsScreen extends StatelessWidget {
  const NewCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Cars'),
      ),
      body: const Center(
        child: Text('New Cars Screen Content'),
      ),
    );
  }
}
