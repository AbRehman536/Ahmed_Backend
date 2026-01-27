import 'package:ahmed_backend/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  String userCollection = "UserCollection";
  ///create User
  Future createUser(UserModel model)
  async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }
  ///update User
  Future updateUser(UserModel model)
  async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .update({"name": model.name, "phone": model.phone, "address": model.address});
    
  }
  ///delete USer
  Future deleteUser(String userID)
  async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .delete();
  }
  
  ///get user by ID
  Stream<UserModel> getUserByID(String userID){
    return FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .snapshots()
        .map((user)=> UserModel.fromJson(user.data()!));
  }
}