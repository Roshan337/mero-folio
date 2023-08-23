import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image/Screen/Calculator.dart';
import 'package:image/Screen/LoginScreen.dart';
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
      drawer: Drawer(
        width: 280,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
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
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Center(
                        child: Icon(Icons.person_add_alt_sharp, size: 30))),
                accountName: Text(
                  'Roshan Shrestha',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                accountEmail: Text(
                  'roshan@gmail.com',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1),
            ),
            ListTile(
              leading: Icon(Icons.key),
              title: Text('Change Password'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1),
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
            SizedBox(height: 20),
            Center(child: Text('Version 1.0'))
          ],
        ),
      ),
    );
  }
}
