import 'package:flutter/material.dart';
import 'package:fruitsynergy_tracker/home.dart';

class NutriResPage extends StatelessWidget{
  final NutritionInfo nutritionInfo;
  final String result;

  const NutriResPage({super.key, required this.nutritionInfo, required this.result});

  @override
  Widget build(BuildContext context) {

    const Map<String, String> fruitImages = {
      'apple': 'assets/ClassImages/apple.jpeg',
      'banana': 'assets/ClassImages/banana.jpeg',
      'cherry': 'assets/ClassImages/cherry.jpeg',
      'chikku': 'assets/ClassImages/chikku.jpg',
      'grapes': 'assets/ClassImages/grapes.jpeg',
      'guava': 'assets/ClassImages/guava.jpeg',
      'jackfruit': 'assets/ClassImages/jackfruit.jpeg',
      'java apple': 'assets/ClassImages/java apple.jpg',
      'kiwi': 'assets/ClassImages/kiwi.jpeg',
      'mango': 'assets/ClassImages/mango.jpeg',
      'mousambi': 'assets/ClassImages/mousambi.jpg',
      'orange': 'assets/ClassImages/orange.jpeg',
      'pear': 'assets/ClassImages/pear.jpeg',
      'pineapple': 'assets/ClassImages/pineapple.jpeg',
      'pomegranate': 'assets/ClassImages/pomegranate.jpeg',
      'strawberry': 'assets/ClassImages/strawberry.jpeg',
      'watermelon': 'assets/ClassImages/watermelon.jpeg'
    };

    final String? imagePath = fruitImages[result];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:  Text(
          'Nutrition Facts of $result',
          style: const TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (imagePath != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  imagePath,
                  width: 150, // Adjust as needed
                  height: 150, // Adjust as needed
                  fit: BoxFit.contain,
                ),
              ),
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
            style: const TextStyle(fontSize: 16, color: Colors.white,fontFamily: 'Poppins'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.white,fontFamily: 'Poppins'),
          ),
        ),
      ],
    );
  }
}