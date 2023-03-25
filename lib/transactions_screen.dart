// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_budget_app/transaction_creating_screen.dart';
import 'package:flutter_budget_app/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  var list = [];

  void fetchData() {
    var url = Uri.parse(
        'https://budget-app-3c16f-default-rtdb.asia-southeast1.firebasedatabase.app/transactions.json');

    list = [];

    http.get(url).then((response) {
      var data = jsonDecode(response.body) as Map<String, dynamic>;

      data.forEach((key, value) {
        var newTransaction = Transaction(
          key,
          value['amount'],
          value['title'],
          value['date'],
        );

        list.add(newTransaction);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý chi tiêu'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => TransactionCreatingScreen(null),
              ))
                  .then((value) {
                var url = Uri.parse(
                    'https://budget-app-3c16f-default-rtdb.asia-southeast1.firebasedatabase.app/transactions.json');

                http
                    .post(
                  url,
                  body: jsonEncode(
                    {
                      'amount': value['amount'],
                      'title': value['title'],
                      'date': value['date'],
                    },
                  ),
                )
                    .then((response) {
                  var data = jsonDecode(response.body) as Map<String, dynamic>;

                  String id = data['name'];

                  var newTransaction = Transaction(
                    id,
                    value['amount'],
                    value['title'],
                    value['date'],
                  );

                  setState(() {
                    list.add(newTransaction);
                  });
                });
              });
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Container(
          margin: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: list
                  .map(
                    (item) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ListTile(
                          leading: Text(
                            '${item.amount}k',
                            style: TextStyle(
                              color:
                                  item.amount > 0 ? Colors.green : Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          subtitle: Text(item.date),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TransactionCreatingScreen(item),
                                    ),
                                  ).then((value) {
                                    var url = Uri.parse(
                                        'https://budget-app-3c16f-default-rtdb.asia-southeast1.firebasedatabase.app/transactions/${item.id}.json');

                                    http
                                        .put(
                                      url,
                                      body: jsonEncode(
                                        {
                                          'amount': value['amount'],
                                          'title': value['title'],
                                          'date': value['date'],
                                        },
                                      ),
                                    )
                                        .then((response) {
                                      setState(() {
                                        // Update data
                                        item.amount = value['amount'];
                                        item.title = value['title'];
                                        item.date = value['date'];
                                      });
                                    });
                                  });
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    var url = Uri.parse(
                                        'https://budget-app-3c16f-default-rtdb.asia-southeast1.firebasedatabase.app/transactions/${item.id}.json');
                                    http.delete(url);

                                    list.removeWhere((i) => i.id == item.id);
                                  });
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )),
    );
  }
}
