import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_app/models/transaction/transaction_model.dart';

class ScreenAnalytics extends StatelessWidget {
 const ScreenAnalytics({
    Key? key,
    required this.incomeTransactions,
    required this.expenseTransactions,
 }) : super(key: key);

 final List<TransactionModel> incomeTransactions;
 final List<TransactionModel> expenseTransactions;

Widget _buildTotalIncome(BuildContext context, double totalIncome) {
 return Expanded(
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(
            Icons.arrow_circle_up,
            color: Colors.green, // Set the color to green
          ),
          const SizedBox(width: 8), // Adjust spacing as needed
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Income',
                style: TextStyle(
                 fontWeight: FontWeight.bold,
                 color: Colors.green, // Set the color to green
                ),
              ),
              const SizedBox(height: 1), // Adjust spacing as needed
              Text('\₹ $totalIncome'),
            ],
          ),
        ],
      ),
    ),
 );
}

Widget _buildTotalExpense(BuildContext context, double totalExpense) {
 return Expanded(
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(
            Icons.arrow_circle_down,
            color: Colors.red, // Set the color to red
          ),
          const SizedBox(width: 8), // Adjust spacing as needed
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Expense',
                style: TextStyle(
                 fontWeight: FontWeight.bold,
                 color: Colors.red, // Set the color to red
                ),
              ),
              const SizedBox(height: 1), // Adjust spacing as needed
              Text('\₹ $totalExpense'),
            ],
          ),
        ],
      ),
    ),
 );
}

 @override
 Widget build(BuildContext context) {
    double totalIncome =
        incomeTransactions.fold(0, (acc, transaction) => acc + transaction.amount);
    double totalExpense =
        expenseTransactions.fold(0, (acc, transaction) => acc + transaction.amount);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display total income and expense
            Row(
              children: [
                // Display total income
                _buildTotalIncome(context, totalIncome),

                // Display total expense
                _buildTotalExpense(context, totalExpense),
              ],
            ),

            // Display tabs with Pie Chart and Line Chart
            Expanded(
              child: TabBarView(
                children: [
                 _PieChartTab(
                    incomeTransactions: incomeTransactions,
                    expenseTransactions: expenseTransactions,
                 ),
                 _LineChartTab(
                    incomeTransactions: incomeTransactions,
                    expenseTransactions: expenseTransactions,
                 ),
                ],
              ),
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text('Dashboard'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pie Chart'),
              Tab(text: 'Line Chart'),
            ],
          ),
        ),
      ),
    );
 }
}

class _PieChartTab extends StatelessWidget {
 const _PieChartTab({
    Key? key,
    required this.incomeTransactions,
    required this.expenseTransactions,
 }) : super(key: key);

 final List<TransactionModel> incomeTransactions;
 final List<TransactionModel> expenseTransactions;

 @override
 Widget build(BuildContext context) {
    double totalIncome =
        incomeTransactions.fold(0, (acc, transaction) => acc + transaction.amount);
    double totalExpense =
        expenseTransactions.fold(0, (acc, transaction) => acc + transaction.amount);

    List<PieChartSectionData> pieChartSections = [
      PieChartSectionData(
        color: Colors.green,
        value: totalIncome,
        title: 'Income',
        radius: 120, // Adjust the radius to make it smaller
      ),
      PieChartSectionData(
        color: Colors.red,
        value: totalExpense,
        title: 'Expense',
        radius: 120, // Adjust the radius to make it smaller
      ),
    ];

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 200, // Adjust the height to make it smaller
      child: PieChart(
        PieChartData(
          sections: pieChartSections,
          centerSpaceRadius: 25, // Adjust the centerSpaceRadius to make it smaller
          sectionsSpace: 5,
        ),
      ),
    );
 }
}

class _LineChartTab extends StatelessWidget {
 final List<TransactionModel> incomeTransactions;
 final List<TransactionModel> expenseTransactions;

 const _LineChartTab({
    Key? key,
    required this.incomeTransactions,
    required this.expenseTransactions,
 }) : super(key: key);

 @override
 Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 100, // Adjust the height to make it smaller
      child: AspectRatio(
        aspectRatio: 1.5, // Adjust this value to control the aspect ratio
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: const Color(0xff37434d),
                width: 1,
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: _generateSpots(incomeTransactions),
                isCurved: true,
                colors: [Colors.green],
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: _generateSpots(expenseTransactions),
                isCurved: true,
                colors: [Colors.red],
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
            titlesData: FlTitlesData(
              leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (context, value) => const TextStyle(
                 color: Color(0xff7589a2),
                 fontWeight: FontWeight.bold,
                 fontSize: 12,
                ),
              ),
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (context, value) => const TextStyle(
                 color: Color(0xff7589a2),
                 fontWeight: FontWeight.bold,
                 fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
 }

 List<FlSpot> _generateSpots(List<TransactionModel> transactions) {
    transactions.sort((a, b) => a.date.compareTo(b.date));
    return transactions
        .asMap()
        .entries
        .map((entry) =>
            FlSpot(entry.key.toDouble(), entry.value.amount.toDouble()))
        .toList();
 }
}