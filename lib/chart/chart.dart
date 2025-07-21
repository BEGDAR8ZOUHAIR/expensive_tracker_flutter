import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/expense.dart';

class CategoryBarChart extends StatelessWidget {
  final List<Expense> expenses;

  const CategoryBarChart({super.key, required this.expenses});

  double _getCategoryTotal(Category category) {
    return expenses
        .where((e) => e.category == category)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  @override
  Widget build(BuildContext context) {
    final categories = Category.values;
    final colors = {
      Category.food: Colors.redAccent,
      Category.leisure: Colors.purpleAccent,
      Category.work: Colors.blueAccent,
      Category.travel: Colors.greenAccent,
    };

    // get all category totals
    final categoryTotals = {for (var c in categories) c: _getCategoryTotal(c)};

    final maxTotal = categoryTotals.values.fold<double>(
      0.0,
      (max, value) => value > max ? value : max,
    );

    final barGroups = <BarChartGroupData>[];

    for (int i = 0; i < categories.length; i++) {
      final category = categories[i];
      final total = categoryTotals[category]!;

      // Normalize bar height
      final percentage = maxTotal == 0 ? 0.0 : total / maxTotal;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: percentage * 10, // Normalize to 0-10 range
              color: colors[category],
              width: 20,
              borderRadius: BorderRadius.circular(6),
              rodStackItems: [],
              // Optional: Add text labels above bars
              fromY: 0,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expenses by Category',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: 1.4,
            child: BarChart(
              BarChartData(
                maxY: 15, // Fixed max height
                barGroups: barGroups,
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final category = categories[group.x.toInt()];
                      final total = categoryTotals[category]!;
                      return BarTooltipItem(
                        '${category.name.toUpperCase()}\n\$${total.toStringAsFixed(2)}',
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final category = categories[value.toInt()];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(
                            categoryIcons[category],
                            size: 20,
                            color: Colors.grey[700],
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false), // Remove Y axis
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
