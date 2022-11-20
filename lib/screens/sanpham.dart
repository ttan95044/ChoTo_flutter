
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


late User loggedInUser;

class sanPham extends StatefulWidget{
  const sanPham({Key? key}) :super (key: key);
  static const String id = 'sanpham';
  @override
  State<sanPham> createState() => _sanPhamState();

}
class _sanPhamState extends State<sanPham> {
  final _auth = FirebaseAuth.instance;
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),

        backgroundColor: Colors.blueAccent,
        title: const Text('Chợ Fake'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          ],
        ),
      ),
    );
  }
}

