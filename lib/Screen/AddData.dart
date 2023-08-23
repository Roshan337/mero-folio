import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/Provider.dart';
import 'package:image/Screen/Protfolio.dart';
import 'package:image/Structure_Model/addModel.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});
  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  List<dynamic> apiData = [];
  bool loading = false;
  Future<void> getApiData() async {
    setState(() {
      loading = true;
    });
    final response = await http
        .get(Uri.parse("https://www.nepalipaisa.com/api/GetStockLive"));
    if (response.statusCode == 200) {
      setState(() {
        apiData = jsonDecode(response.body.toString())['result']['stocks'];
      });
      setState(() {
        loading = false;
      });
    } else {
      throw Exception("No data");
    }
  }

  final List<String> items = [
    'IPO',
    'FPO',
    'Secondary',
  ];
  String? typeShare;
  String? selectedValue;

  int dp = 25;
  double sebon = 0.00015;
  double cgt = 0.075;
  double oneyearcgt = 0.05;
  double? total;
  String? stocksymbol;
  double? previousclosing;
  double? closingprice;

  @override
  void initState() {
    getApiData();
    super.initState();
  }

  TextEditingController _quantity = TextEditingController();
  TextEditingController _price = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final shareData = Provider.of<ShareProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('My Portfolio'),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 60,
                          child: Card(
                            elevation: 8,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Select Name',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: apiData
                                    .map<DropdownMenuItem<String>>((stock) {
                                  return DropdownMenuItem<String>(
                                    value: stock['companyName'],
                                    child: Text(
                                      stock['companyName'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 111, 107, 107),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  debugPrint(value);
                                  setState(() {
                                    selectedValue = value;
                                    stocksymbol = apiData.firstWhere((stock) =>
                                        stock['companyName'] ==
                                        value)['stockSymbol'];
                                    previousclosing = apiData.firstWhere(
                                        (stock) =>
                                            stock['companyName'] ==
                                            value)['previousClosing'];
                                    closingprice = apiData.firstWhere((stock) =>
                                        stock['companyName'] ==
                                        value)['closingPrice'];
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  elevation: 1,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.yellow,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  offset: const Offset(-20, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: MaterialStateProperty.all(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Card(
                            elevation: 7,
                            child: TextField(
                              controller: _quantity,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  hintText: 'Quantity',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    width: 0,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Card(
                            elevation: 7,
                            child: TextField(
                              controller: _price,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  hintText: 'Price',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0))),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 67,
                          child: Card(
                            elevation: 8,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Type',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: items
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 81, 78, 78),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: typeShare,
                                onChanged: (value) {
                                  setState(() {
                                    typeShare = value;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  elevation: 1,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.yellow,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  offset: const Offset(-20, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness: MaterialStateProperty.all(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                            height: 50,
                            width: 390,
                            child: ElevatedButton(
                                onPressed: () {
                                  double amountandquantity =
                                      double.parse(_price.text) *
                                          double.parse(_quantity.text);
                                  double seboncharge =
                                      amountandquantity * sebon;
                                  if (typeShare == null ||
                                      selectedValue == null ||
                                      _price.text.isEmpty ||
                                      _quantity.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                      content: Text(
                                        'All Field is Required!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ));
                                  } else if (typeShare == 'IPO' ||
                                      typeShare == 'FPO') {
                                    total = amountandquantity;
                                    AddModel data = AddModel(
                                        name: selectedValue,
                                        quantity: double.parse(_quantity.text),
                                        price: double.parse(_price.text),
                                        totalAmount: total,
                                        symbol: stocksymbol,
                                        previousClosing: previousclosing,
                                        type: typeShare,
                                        closingPrice: closingprice);
                                    shareData.addprotfolio(data);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                      content: Text(
                                        'Add ${typeShare}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ));
                                  } else if (typeShare == 'Secondary') {
                                    if (amountandquantity <= 50000) {
                                      double brokercommission =
                                          amountandquantity * 0.004;
                                      total = amountandquantity +
                                          seboncharge +
                                          dp +
                                          brokercommission;
                                    } else if (amountandquantity > 50000 &&
                                        amountandquantity <= 500000) {
                                      double brokercommission =
                                          amountandquantity * 0.0037;
                                      total = amountandquantity +
                                          seboncharge +
                                          dp +
                                          brokercommission;
                                    } else if (amountandquantity > 500000 &&
                                        amountandquantity <= 2000000) {
                                      double brokercommission =
                                          amountandquantity * 0.0034;
                                      total = amountandquantity +
                                          seboncharge +
                                          dp +
                                          brokercommission;
                                    } else if (amountandquantity > 2000000 &&
                                        amountandquantity < 10000000) {
                                      double brokercommission =
                                          amountandquantity * 0.003;
                                      total = amountandquantity +
                                          seboncharge +
                                          dp +
                                          brokercommission;
                                    } else {
                                      double brokercommission =
                                          amountandquantity * 0.0027;
                                      total = amountandquantity +
                                          seboncharge +
                                          dp +
                                          brokercommission;
                                    }
                                    AddModel data = AddModel(
                                        name: selectedValue,
                                        quantity: double.parse(_quantity.text),
                                        price: double.parse(_price.text),
                                        totalAmount: total,
                                        symbol: stocksymbol,
                                        previousClosing: previousclosing,
                                        type: typeShare,
                                        closingPrice: closingprice);
                                    shareData.addprotfolio(data);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                      content: Text(
                                        'Add ${typeShare}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ));
                                  }
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Portfolio();
                                  }), (route) => false);
                                },
                                child: Text('Add'))),
                      )
                    ],
                  );
                }));
  }
}
