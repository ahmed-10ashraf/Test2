import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Image.asset('assets/images/hyundai_tucson_summer_ad_v2.png'),
          )
        ],
      ),
    );
  }
}
