import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Ad'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Add Ad Screen Content'),
      ),
    );
  }
}
