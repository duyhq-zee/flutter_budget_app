// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_budget_app/transaction_creating_screen.dart';
import 'package:flutter_budget_app/transaction_model.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  var list = [
    Transaction(1, 50, 'Mẹ cho', '10/03/2023'),
    Transaction(2, -20, 'Ăn sáng', '11/03/2023'),
    Transaction(4, -30, 'Ăn trưa', '11/03/2023'),
    Transaction(6, -30, 'Ăn trưa', '11/03/2023'),
  ];

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
                // map['key']
                var id = list[list.length - 1].id + 1;
                var newTransaction = Transaction(
                    id, value['amount'], value['title'], value['date']);

                setState(() {
                  list.add(newTransaction);
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
                                    setState(() {
                                      // Update data
                                      item.amount = value['amount'];
                                      item.title = value['title'];
                                      item.date = value['date'];
                                    });
                                  });
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
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
