
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/screens/add_img.dart';
import 'package:flutter_database/screens/update.dart';


final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class trangChu extends StatefulWidget {
  const trangChu({Key? key}) : super(key: key);
  static const String id = 'trangchu';

  @override
  State<trangChu> createState() => _trangChuState();
}

class _trangChuState extends State<trangChu> {
  final messsageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? messageText;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print('Imformation of user: $user');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, addImg.id);
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations
                  .of(context)
                  .openAppDrawerTooltip,
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
          children: const [
            IndexStream(),
          ],
        ),
      ),
    );
  }
}

class IndexStream extends StatelessWidget {
  const IndexStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
        _firestore.collection('addimg').orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          final indexs = snapshot.data!.docs.reversed;
          List<IndexBubble> messageBubbles = [];
          for (var index in indexs) {
            final indexDiachi = index.get('diachi');
            final indexImg = index.get('image');
            final indexMoney = index.get('money');
            final indexName = index.get('name');
            final indexNameSP = index.get('nameSP');
            final indexPhone = index.get('phone');
            final currentUser = loggedInUser.email!;
            final indexEmail = index.get('email');

            final messageBubble = IndexBubble(
              email: indexEmail,
              diachi: indexDiachi,
              name: indexName,
              nameSP: indexNameSP,
              phone: indexPhone,
              money: indexMoney,
              isMe: currentUser == indexEmail,
              image: indexImg,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        });
  }
}

class IndexBubble extends StatelessWidget {
  IndexBubble({this.name,
    this.phone,
    this.diachi,
    this.money,
    this.nameSP,
    this.email,
    this.image,
    this.isMe});

  final String? diachi;
  final String? email;
  final String? image;
  final String? money;
  final String? name;
  final String? nameSP;
  final String? phone;
  final bool? isMe;



  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                height: 400,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Material(
                      color: Colors.blue,
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, update.id);
                          },
                          child: const Icon(
                            Icons.build
                          )),
                    ),
                    SizedBox(height: 5,),
                    Expanded(
                      child: Image.network(image!),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              nameSP!,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text('Người đăng: '+name!,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.yellow
                                ),),
                            Text('Phone: '+phone!),
                            Text(money!+'đ'),
                            Text('Địa chỉ: '+diachi!),
                            const SizedBox(height: 10,),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.cyan,
                              child: MaterialButton(
                                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                minWidth: 40,
                                onPressed: () {

                                },
                                child: const Text(
                                  "Mua",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
