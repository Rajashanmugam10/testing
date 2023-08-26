import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage=FirebaseStorage.instance;
class Storage{
Future<String> uploadprofileimage(String childname,Uint8List file)async{
Reference ref =_storage.ref().child(childname);
UploadTask uploadTask=ref.putData(file);
TaskSnapshot snapshot=await uploadTask;
String downloadUrl=await snapshot.ref.getDownloadURL();
return downloadUrl; 
}
}