import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/screens/add_img.dart';
import 'package:flutter_database/screens/canhan.dart';
import 'package:flutter_database/screens/index.dart';
import 'package:flutter_database/screens/navbar.dart';
import 'package:flutter_database/screens/sanpham.dart';
import 'package:flutter_database/screens/update.dart';
import 'package:flutter_database/welcom.dart';
import 'package:flutter_database/login.dart';
import 'package:flutter_database/screens/register.dart';
import 'package:flutter_database/screens/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChatFirebase());
}
class ChatFirebase extends StatelessWidget{
  const ChatFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Welcome.id,
      routes: {
        Welcome.id: (context) => const Welcome(),
        Login.id: (context) => const Login(),
        Register.id: (context) => const Register(),
        Chat.id: (context) => const Chat(),
        caNhan.id: (context) => const caNhan(),
        trangChu.id: (context) => const trangChu(),
        sanPham.id: (context) => const sanPham(),
        navBar.id: (context) => const navBar(),
        addImg.id: (context) => const addImg(),
        update.id: (context) => const update()
      },
    );
  }
}

