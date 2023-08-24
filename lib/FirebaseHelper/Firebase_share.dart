import 'package:firebase_auth/firebase_auth.dart';
import 'package:image/Structure_Model/addModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelperShare {
  static FirebaseHelperShare instance = FirebaseHelperShare();
  Future<AddModel> mySharePost(
      String name,
      String symbol,
      double quantity,
      double price,
      double totalAmount,
      double previousClosing,
      String type,
      double closingPrice) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection("allshare")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('myshare')
        .doc();

    AddModel addModel = AddModel(
        id: reference.id,
        name: name,
        symbol: symbol,
        quantity: quantity,
        price: price,
        totalAmount: totalAmount,
        previousClosing: previousClosing,
        type: type,
        closingPrice: closingPrice);
    await reference.set(addModel.toMap());

    return addModel;
  }

  Future<List<AddModel>> getUserPortfolio() async {
    try {
      final reference = await FirebaseFirestore.instance
          .collection('allshare')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('myshare')
          .get();
      final data =
          reference.docs.map((e) => AddModel.fromMap(e.data())).toList();
      return data;
    } catch (e) {
      throw Exception('Error In Order Fetch');
    }
  }
}
