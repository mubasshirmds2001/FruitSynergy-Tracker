import 'package:flutter/material.dart';
import 'package:fruitsynergy_tracker/home.dart';

class NutriResPage extends StatelessWidget{
  final NutritionInfo nutritionInfo;
  final String result;

  const NutriResPage({super.key, required this.nutritionInfo, required this.result});

  @override
  Widget build(BuildContext context) {

    const Map<String, String> fruitImages = {
      'Apple': 'assets/ClassImages/Apple.jpeg',
      'Banana': 'assets/ClassImages/Banana.jpeg',
      'Cherry': 'assets/ClassImages/Cherry.jpeg',
      'Chikku': 'assets/ClassImages/Chikku.jpg',
      'Grapes': 'assets/ClassImages/Grapes.jpeg',
      'Guava': 'assets/ClassImages/Guava.jpeg',
      'Jackfruit': 'assets/ClassImages/Jackfruit.jpeg',
      'Java Apple': 'assets/ClassImages/Java Apple.jpg',
      'Kiwi': 'assets/ClassImages/Kiwi.jpeg',
      'Mango': 'assets/ClassImages/Mango.jpeg',
      'Mosambi': 'assets/ClassImages/Mosambi.jpg',
      'Orange': 'assets/ClassImages/Orange.jpeg',
      'Pear': 'assets/ClassImages/Pear.jpeg',
      'Pineapple': 'assets/ClassImages/Pineapple.jpeg',
      'Pomegranate': 'assets/ClassImages/Pomegranate.jpeg',
      'Strawberry': 'assets/ClassImages/Strawberry.jpeg',
      'Watermelon': 'assets/ClassImages/Watermelon.jpeg'
    };

    final String? imagePath = fruitImages[result];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:  const Text(
          'Nutrition Facts',
          style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$result Fruit',
              style: TextStyle(fontSize: 28, color: Colors.white, fontFamily: 'Poppins'),
            ),
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