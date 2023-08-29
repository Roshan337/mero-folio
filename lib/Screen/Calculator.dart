import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

final List<String> items = [
  'Buy',
  'Sell',
];
String? typeShare;

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
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
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 81, 78, 78),
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
                            padding: const EdgeInsets.only(left: 14, right: 14),
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
                              thumbVisibility: MaterialStateProperty.all(true),
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
                        // controller: _quantity,
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
                        // controller: _price,
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
                ElevatedButton(onPressed: () {}, child: Text('Calculate'))
              ],
            );
          }),
    );
  }
}
