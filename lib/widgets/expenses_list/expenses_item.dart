import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/expense.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE2FDE2),
        borderRadius: BorderRadius.circular(40),
      ),
      child: SizedBox(
        height: 80,
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                categoryIcons[expense.category],
                color: Colors.black,
                size: 40,
              ),
            ),
            title: Text(
              expense.title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
            subtitle: Text(
              '\$ ${expense.amount.toStringAsFixed(2)}', //expense.amount.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600]!,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
            trailing: Text(
              formatter.format(expense.date),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
