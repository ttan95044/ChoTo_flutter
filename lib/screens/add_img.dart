import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/screens/navbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class addImg extends StatefulWidget {
  const addImg({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
    );
  }

  static const String id = 'addimg';

  @override
  State<addImg> createState() => _addImgState();
}

class _addImgState extends State<addImg> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  String? imageUrl;
  String? messageText;
  String? nameSP,name,phone,money,diachi;

  final _formKey = GlobalKey<FormState>();
  final nameSpEditingController = new TextEditingController();
  final moneyEditingController = new TextEditingController();
  final nameEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final diachiEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print('User: $user');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {


    final nameSPbt = TextFormField(
        controller: nameSpEditingController,
        validator: (value) => ((value?.length ?? 0) < 5
            ? 'At least 5 characters.'
            : null),
        keyboardType: TextInputType.text,
        onChanged: (value) {
          nameSP = value.toString();
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.shopping_cart_rounded),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Tên sản phẩm",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ));


    final moneybt = TextFormField(
        controller: moneyEditingController,
        validator: (value) => ((value?.length ?? 0) < 5
            ? 'At least 5 characters.'
            : null),
        keyboardType: TextInputType.text,
        onChanged: (value) {
          money = value.toString();
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.monetization_on_sharp),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Giá Bán",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ));

    final namebt = TextFormField(
        controller: nameEditingController,
        validator: (value) => ((value?.length ?? 0) < 5
            ? 'At least 5 characters.'
            : null),
        keyboardType: TextInputType.text,
        onChanged: (value) {
          name = value.toString();
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Tên",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ));

    final phonebt = TextFormField(
        controller: phoneEditingController,
        validator: (value) => ((value?.length ?? 0) < 5
            ? 'At least 5 characters.'
            : null),
        keyboardType: TextInputType.text,
        onChanged: (value) {
          phone = value.toString();
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ));

    final diachibt = TextFormField(
        controller: diachiEditingController,
        validator: (value) => ((value?.length ?? 0) < 5
            ? 'At least 5 characters.'
            : null),
        keyboardType: TextInputType.text,
        onChanged: (value) {
          diachi = value.toString();
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_on),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Địa Chỉ",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ));

    //add button
    final addButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Addimg();
          },
          child: const Text(
            "Đăng",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    (imageUrl != null)
                        ? Image.network(imageUrl!)
                        : const Placeholder(
                            fallbackHeight: 200,
                            fallbackWidth: 150,
                          ),
                    SizedBox(
                      width: 75,
                      child: Row(
                        children: <Widget>[
                          MaterialButton(
                              minWidth: 10,
                              onPressed: uploadImage,
                              child: const Icon(
                                Icons.add,
                                size: 40,
                                // style: kSendButtonTextStyle,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    nameSPbt,
                    const SizedBox(height: 15),
                    moneybt,
                    const SizedBox(height: 15),
                    namebt,
                    const SizedBox(height: 15),
                    phonebt,
                    const SizedBox(height: 15),
                    diachibt,
                    const SizedBox(height: 15),
                    addButton,
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void Addimg() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      _firestore.collection('addimg').add({
        'image': imageUrl,
        'nameSP': nameSP,
        'name': name,
        'timestamp': DateTime.now(),
        'email': loggedInUser.email,
        'phone': phone,
        'money': money,
        'diachi': diachi,
      });
      EasyLoading.showSuccess('Add Successful!');
      Navigator.pushNamed(context, navBar.id);
    } else {
      EasyLoading.showError('Can\'t Add Product!');
    }
  }
  uploadImage() async {
    final imagePicker = ImagePicker();
    PickedFile? image;
    UploadTask uploadTask;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      image = await imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);
      if (image != null) {
        var snapshot = await FirebaseStorage.instance
            .ref()
            .child('img/${image.path.split('/').last}')
            .putFile(file)
            .whenComplete(() => print('success'));
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No image path received');
      }
    } else {
      print('Permission not granted. Try again with permission access');
    }
  }
}

