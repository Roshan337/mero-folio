import 'package:flutter/material.dart';

class photo extends StatefulWidget {
  const photo({super.key});

  @override
  State<photo> createState() => _photoState();
}

class _photoState extends State<photo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(249, 21, 106, 155),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Mero Folio',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const Center(
            // width: 200,
            child: Image(
          // color: const Color.fromARGB(236, 220, 13, 13),
          image: AssetImage('assets/logo.png'),
        )));
  }
}
