import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image/Provider.dart';
import 'package:image/Screen/AddData.dart';
import 'package:image/Structure_Model/addModel.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  bool isLoading = false;
  void getData() async {
    isLoading = true;

    final shareData = Provider.of<ShareProvider>(context, listen: false);
    await shareData.allPortfolio();
    isLoading = false;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final shareData = Provider.of<ShareProvider>(context, listen: true);
    double alltotalPriceofPrice = 0; // Initialize it to zero
    for (var i = 0; i < shareData.protfolioData.length; i++) {
      alltotalPriceofPrice += shareData.protfolioData[i].closingPrice! *
          shareData.protfolioData[i].quantity!;
    }

    double difference = 0;
    for (var i = 0; i < shareData.protfolioData.length; i++) {
      difference += shareData.protfolioData[i].closingPrice! *
              shareData.protfolioData[i].quantity! -
          shareData.protfolioData[i].previousClosing! *
              shareData.protfolioData[i].quantity!;
      ;
    }
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddData()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('My Portfolio'),
          centerTitle: true,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : shareData.protfolioData.isEmpty
                ? Center(child: Text('No Transactions'))
                : Column(
                    children: [
                      SizedBox(
                        height: 80,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            elevation: 11,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Total Current Share Value'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Rs.'),
                                          Text(
                                            alltotalPriceofPrice.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      Row(children: [
                                        Icon(
                                          Icons.arrow_circle_right,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Rs ${difference.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: difference >= 0
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        )
                                      ])
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: shareData.protfolioData.length,
                            itemBuilder: (context, index) {
                              AddModel addModel =
                                  shareData.protfolioData[index];
                              double Previoustotal = addModel.quantity! *
                                  addModel.previousClosing!;
                              double Totalclosingprice =
                                  addModel.quantity! * addModel.closingPrice!;
                              double totalCalcultion =
                                  Totalclosingprice - Previoustotal;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Card(
                                  elevation: 8,
                                  child: ExpansionTile(
                                    iconColor: Colors.black,
                                    collapsedIconColor: Colors.black,
                                    title: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                addModel.symbol.toString(),
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "${addModel.quantity} Shares, LTP:${addModel.closingPrice}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Rs ${Totalclosingprice.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                    color: Colors.black),
                                              ),
                                              Row(children: [
                                                Icon(
                                                  Icons.arrow_circle_right,
                                                  size: 18,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  'Rs ${totalCalcultion.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: totalCalcultion >= 0
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                )
                                              ]),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Scrip"),
                                            Text(addModel.symbol.toString())
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Current Balance"),
                                            Text(addModel.quantity.toString())
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total Purchase Price"),
                                            Text(addModel.totalAmount!
                                                .toStringAsFixed(2))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Previous Closing Price"),
                                            Text(addModel.previousClosing
                                                .toString())
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Value As Of Previous Closing Price"),
                                            Text(Previoustotal.toStringAsFixed(
                                                2))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Last Transaction Price"),
                                            Text(addModel.closingPrice
                                                .toString())
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Value As Of Last Transaction Price"),
                                            Text(Totalclosingprice
                                                .toStringAsFixed(2))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ));
  }
}
