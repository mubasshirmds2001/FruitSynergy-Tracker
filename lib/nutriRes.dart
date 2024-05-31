import 'package:flutter/material.dart';
import 'package:fruitsynergy_tracker/home.dart';

class NutriResPage extends StatelessWidget{
  final NutritionInfo nutritionInfo;

  const NutriResPage({super.key, required this.nutritionInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Nutrition Information',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Nutrition Facts',
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Table(
                border: TableBorder.all(color: Colors.white),
                children: [
                  _buildTableRow('Energy (kcal/kJ)', nutritionInfo.energy),
                  _buildTableRow('Water (g)', nutritionInfo.water),
                  _buildTableRow('Protein (g)', nutritionInfo.protein),
                  _buildTableRow('Total fat (g)', nutritionInfo.total_fat),
                  _buildTableRow('Carbohydrates (g)', nutritionInfo.carbohydrates),
                  _buildTableRow('Fiber (g)', nutritionInfo.fiber),
                  // Add more rows as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}