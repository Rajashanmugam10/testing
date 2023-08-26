import 'package:air/screens/login.dart';
import 'package:air/services/firestoreauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final User? user = Auth().currentUser;
  Future<void> signout() async {
    await Auth().signout();
 
  }

  Widget _signoutbtn() {
    return ElevatedButton(onPressed: signout, child: const Text('signout'));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('testing'),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children:  [
              Text(user?.email ?? 'user email'),
              _signoutbtn(),
             Text(user?.uid ?? 'user email'),
            ]
            ,
          ),
        ));
  }
}
