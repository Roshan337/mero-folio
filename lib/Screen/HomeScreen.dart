import 'package:flutter/material.dart';
import 'package:image/Screen/Calculator.dart';
import 'package:image/Screen/Protfolio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mero Folio'),
        backgroundColor: Color.fromARGB(255, 3, 131, 205),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //container home page
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 5, right: 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Portfolio()));
                    },
                    child: Container(
                      width: 185,
                      height: 200,
                      child: Column(
                        children: [
                          SizedBox(height: 23),
                          Image.asset('assets/logo.png'),
                          SizedBox(height: 13),
                          Text(
                            'Portfolio',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 9, 81, 175), // Start color
                            Color(0xFF80d0c7), // End color
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 2, right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Calculator()));
                    },
                    child: Container(
                      width: 185,
                      height: 200,
                      child: Column(
                        children: [
                          SizedBox(height: 37),
                          Image.asset(
                            'assets/cal.png',
                            width: 120,
                          ),
                          // SizedBox(height: 10),
                          Text(
                            'Calculator',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 9, 81, 175), // Start color
                            Color(0xFF80d0c7), // End color
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
