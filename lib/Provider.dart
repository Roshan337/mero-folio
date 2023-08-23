import 'package:flutter/material.dart';
import 'package:image/Structure_Model/addModel.dart';

class ShareProvider with ChangeNotifier {
  List<AddModel> _addprotfolio = [];
  List<AddModel> get protfolioData => _addprotfolio;
  void addprotfolio(AddModel data) {
    _addprotfolio.add(data);
    notifyListeners();
  }
}
