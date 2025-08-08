import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = recentTransactions.fold(0.0, (sum, transaction) {
        return sum + transaction.value;
      });

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    }).reversed.toList();
  }

  double _weekPercentageValue(double transactionValue) {
    double total = groupedTransactions.fold(0.0, (sum, transaction) {
      return sum + (transaction['value'] as double);
    });

    if (total > 0) {
      return transactionValue / total;
    }

    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((transaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: transaction['day'].toString(),
                value: (transaction['value'] as double),
                percentage: _weekPercentageValue(
                  transaction['value'] as double,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
