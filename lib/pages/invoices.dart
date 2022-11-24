import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makepdfs/models/invoice.dart';
import 'package:makepdfs/pages/detail.dart';

class InvoicePage extends StatelessWidget {
  InvoicePage({Key? key}) : super(key: key);

  final invoices = <Invoice>[
    Invoice(
        customer: 'דעיבס חליל ',
        address: 'נחף אלעין 0',
        items: [
          LineItem(
            'בנייה.שפוץ',
            120000,
          ),
          LineItem('בניית גדר ברוחב של 50 * 50  ', 200),
          LineItem('צעד2', 3020.45),
          LineItem('צעד3', 840.50),
        ],
        name: 'הצעת מחיר דוגמה', phone: '0509977084'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices'),
      ),
      body: ListView(
        children: [
          ...invoices.map(
            (e) => ListTile(
              title: Text(e.name),
              subtitle: Text(e.customer),
              trailing: Text('\$${e.totalCost().toStringAsFixed(2)}'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) =>  DetailPage(invoice: e),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
