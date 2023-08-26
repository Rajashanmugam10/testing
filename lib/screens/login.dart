
import 'package:air/screens/homepage.dart';
import 'package:air/screens/signup.dart';
import 'package:air/services/firestoreauth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  TextEditingController useremail = TextEditingController();
  TextEditingController userpassword = TextEditingController();
  String? errormessage = '';
  bool isLogin = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signwitheemailandpassword() async {
    try {
      Auth().signinwithemailandpassword(
          email: useremail.text, password: userpassword.text);
        Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return const Homepage();
                      }));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errormessage = e.message;
      });
    }
  }

 



  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Form(
        key: formkey,
        child: ListView(
          children: [
            const SizedBox(
              height:60,
            ),
            Card(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return const Signup();
                      }));
                    },
                    child: Lottie.asset(
                      'assets/connect.json',
                      height: MediaQuery.of(context).size.height/3.8,
                      frameRate: FrameRate.max,
                    ))),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CupertinoFormSection.insetGrouped(
                  footer: const Divider(color: Colors.white),
                  header: const Text('connect with your circle'),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    CupertinoTextFormFieldRow(
                      placeholder: 'email',
                      controller: useremail,
                      prefix: const Text('email'),
                      textInputAction: TextInputAction.next,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'enter valid email'
                              : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    CupertinoTextFormFieldRow(
                      placeholder: 'password',
                      controller: userpassword,
                      prefix: const Text('password'),
                      textInputAction: TextInputAction.next,
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CupertinoButton(
                  color: Colors.red,
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  child: const Text('login'),
                  onPressed: () async {
                    final form = formkey.currentState;
                    if (form!.validate()) {
                      signwitheemailandpassword();
                      Fluttertoast.showToast(
                          msg: "This is Center Short Toast",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: CupertinoColors.systemBlue,
                          textColor: CupertinoColors.systemGreen,
                          fontSize: 16.0);
                    }
                  }),
            ),
            const Center(child: Text("tap the icon to create an account")),
          ],
        ),
      ),
    );
  }
}
