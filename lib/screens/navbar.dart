
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/screens/canhan.dart';
import 'package:flutter_database/screens/chat.dart';
import 'package:flutter_database/screens/index.dart';
import 'package:flutter_database/screens/sanpham.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';

late User loggedInUser;

class navBar extends StatefulWidget{
  const navBar({Key? key}) :super (key: key);
  static const String id = 'navbar';
  @override
  State<navBar> createState() => _navBarState();

}
class _navBarState extends State<navBar> {
  final navbar = [
    const trangChu(),
    const Chat(),
    const sanPham(),
    const caNhan(),
  ];
  int _selectedIndex = 0;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navbar[
        _selectedIndex
      ],
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: Colors.black,
        unSelectedColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        unselectedIconSize: 15,
        selectedIconSize: 20,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.Top,
        gradient: const LinearGradient(
          colors: [Colors.white, Colors.grey],
        ),
        customBottomBarItems: [
          CustomBottomBarItems(
            label: 'Trang Chủ',
            icon: Icons.home,
          ),
          CustomBottomBarItems(
            label: 'Chat',
            icon: Icons.chat,
          ),
          CustomBottomBarItems(
            label: 'Sản Phẩm',
            icon: Icons.add_shopping_cart_outlined,
          ),

          CustomBottomBarItems(
            label: 'Cá Nhân',
            icon: Icons.account_box_outlined,
          ),
        ],
      ),
    );
  }
}



