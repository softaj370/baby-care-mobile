import 'package:flutter/material.dart';

class ShopHomePage extends StatefulWidget {
  const ShopHomePage({super.key});

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Shopping Mall"),backgroundColor: Colors.white,),
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(child: Column(children: [Text("Shop")])),
        ),
      ),
    );
  }
}
