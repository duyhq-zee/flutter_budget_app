// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quản lý chi tiêu'),
        ),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Card(
              //   child: Padding(
              //     padding: const EdgeInsets.all(16),
              //     child: Text('Ăn sáng 20k'),
              //   ),
              // ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListTile(
                    leading: Text(
                      '50k',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        'Mẹ cho',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    subtitle: Text('03/03/2023'),
                  ),
                ),
              ),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListTile(
                    leading: Text(
                      '-20k',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        'Ăn sáng',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    subtitle: Text('04/03/2023'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
