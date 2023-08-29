import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/FirebaseHelper/Firebase_share.dart';
import 'package:image/Structure_Model/addModel.dart';

class ShareProvider with ChangeNotifier {
  List<AddModel> _addprotfolio = [];
  List<AddModel> get protfolioData => _addprotfolio;

  Future<void> allPortfolio() async {
    _addprotfolio = await FirebaseHelperShare.instance.getUserPortfolio();
    notifyListeners();
  }

  Future<void> addprotfolio(
      String name,
      String symbol,
      double quantity,
      double price,
      double totalAmount,
      double previousClosing,
      String type,
      double closingPrice) async {
    AddModel share = await FirebaseHelperShare.instance.mySharePost(
        name,
        symbol,
        quantity,
        price,
        totalAmount,
        previousClosing,
        type,
        closingPrice);
    _addprotfolio.add(share);
    notifyListeners();
  }

  Future<void> DeleteShare(AddModel addModel) async {
    String data = await FirebaseHelperShare.instance.deleteItem(addModel.id!);
    if (data == 'Delete Successfully') {
      _addprotfolio.remove(addModel);
      print('delete');
    }
    notifyListeners();
    notifyListeners();
  }
}
