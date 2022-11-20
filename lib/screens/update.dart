
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class update extends StatefulWidget {
  const update({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
    );
  }
  static const String id = 'update';
  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nameSPController = TextEditingController();
  final TextEditingController _diachiController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();



  final CollectionReference _addimg =
  FirebaseFirestore.instance.collection('addimg');

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {

      _nameController.text = documentSnapshot['name'];
      _nameSPController.text = documentSnapshot['nameSP'];
      _diachiController.text = documentSnapshot['diachi'];
      _emailController.text = documentSnapshot['email'];
      _moneyController.text = documentSnapshot['money'];
      _phoneController.text = documentSnapshot['phone'];

    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextField(
                  controller: _nameSPController,
                  decoration: const InputDecoration(labelText: 'nameSP'),
                ),
                TextField(
                  controller: _diachiController,
                  decoration: const InputDecoration(labelText: 'diachi'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'email'),
                ),
                TextField(
                  controller: _moneyController,
                  decoration: const InputDecoration(labelText: 'money'),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'phone'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text( 'Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String nameSP = _nameSPController.text;
                    final String diachi = _diachiController.text;
                    final String email = _emailController.text;
                    final String money = _moneyController.text;
                    final String phone = _phoneController.text;
                    await _addimg.doc(documentSnapshot!.id).update({"name": name,"namSP": nameSP,"diachi": diachi,
                    "email": email,"money": money,"phone": phone});
                      _nameController.text = '';
                      _nameSPController.text='';
                      _diachiController.text='';
                      _emailController.text='';
                      _moneyController.text='';
                      _phoneController.text='';
                      Navigator.of(context).pop();
                    }
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _addimg.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Bạn đã thành công')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Chợ Fake'),
        ),
        body: StreamBuilder(
          stream: _addimg.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['nameSP']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _delete(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  );

                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}

