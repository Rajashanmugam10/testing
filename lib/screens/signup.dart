import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firestoreauth.dart';
import '../services/imagepicker.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController useremail = TextEditingController();
  TextEditingController userpassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController bio = TextEditingController();
  String? errormessage = '';
  final formkey = GlobalKey<FormState>();
  Uint8List? _image;
  void SelectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<void> createuserwithemailandpassword() async {
    try {
      Auth().createuserwithemailandpassword(
        file: _image!,
          name: name.text,
          username: username.text,
          bio: bio.text,
          email: useremail.text,
          password: userpassword.text);
      print(useremail.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errormessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('signup'),
        ),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    _image != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 75,
                              backgroundImage: MemoryImage(_image!),
                            ),
                          )
                        : const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://imgs.search.brave.com/imScpY3vpY0ZRM71xtMtFLJF-CM3IdqA2nYhxKESE2M/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudGhlbm91bnBy/b2plY3QuY29tL3Bu/Zy8xOTk1MTQwLTIw/MC5wbmc"),
                            radius: 45,
                            backgroundColor: Colors.white,
                          ),
                    Positioned(
                      child: GestureDetector(
                          onTap: SelectImage,
                          child: const Icon(Icons.add_a_photo_rounded)),
                      bottom: 10,
                      right: 10,
                    )
                  ],
                ),
              ),
              CupertinoFormSection.insetGrouped(
                  footer: const Divider(
                    color: Colors.grey,
                  ),
                  header: const Text('account'),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    CupertinoTextFormFieldRow(
                      placeholder: 'name',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      prefix: const Text('name'),
                      controller: name,
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return 'name is empty';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
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
                    )
                  ]),
              CupertinoFormSection.insetGrouped(
                  footer: const Divider(),
                  header: const Text('details'),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    CupertinoFormRow(
                      helper: const Text(
                        "username cann't be change",
                        style: TextStyle(color: Colors.grey),
                      ),
                      child: CupertinoTextFormFieldRow(
                          placeholder: 'username',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          controller: username,
                          validator: (username) {
                            if (username == null || username.isEmpty) {
                              return 'username is empty';
                            }
                            return null;
                          }),
                    ),
                    CupertinoTextFormFieldRow(
                      placeholder: 'password',
                      controller: userpassword,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'password empty';
                        } else if (password.length <= 6) {
                          return 'password length must be greater than 6';
                        } else {
                          return null;
                        }
                      },
                    ),
                    CupertinoTextFormFieldRow(
                      placeholder: 'bio',
                      controller: bio,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (bio) {
                        if (bio == null || bio.isEmpty) {
                          return 'password empty';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CupertinoButton.filled(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    child: const Text('create account'),
                    onPressed: () async {
                      final form = formkey.currentState;
                      if (form!.validate()) {
                        createuserwithemailandpassword();
                        Fluttertoast.showToast(
                            msg: "account created",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: CupertinoColors.systemBlue,
                            textColor: CupertinoColors.systemGreen,
                            fontSize: 16.0);
                      }
                    }),
              )
            ],
          ),
        ));
  }
}
