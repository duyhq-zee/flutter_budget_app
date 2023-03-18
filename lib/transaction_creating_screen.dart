// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_budget_app/transaction_model.dart';

class TransactionCreatingScreen extends StatelessWidget {
  Transaction? transaction;

  TransactionCreatingScreen(this.transaction);

  @override
  Widget build(BuildContext context) {
    var amountController = TextEditingController();
    var titleController = TextEditingController();
    var dateController = TextEditingController();

    if (transaction != null) {
      amountController.text = transaction!.amount.toString();
      titleController.text = transaction!.title;
      dateController.text = transaction!.date;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm thu chi mới'),
        actions: [
          IconButton(
            onPressed: () {
              var amountText = amountController.text;
              var titleText = titleController.text;
              var dateText = dateController.text;

              // Map/object
              // {
              //    key1: value1;
              //    key2: value2
              // }

              Navigator.of(context).pop({
                'amount': int.parse(amountText),
                'title': titleText,
                'date': dateText,
              });
            },
            icon: Icon(
              Icons.check,
            ),
          )
        ],
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text('Số tiền'),
          TextField(
            controller: amountController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Text('Ghi chú'),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Text('Ngày'),
          TextField(
            controller: dateController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
