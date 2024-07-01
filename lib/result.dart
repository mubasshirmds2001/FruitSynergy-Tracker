import 'package:flutter/material.dart';
import 'package:fruitsynergy_tracker/home.dart';
import 'dart:io';

import 'package:fruitsynergy_tracker/nutriRes.dart';

class ResultPage extends StatelessWidget {
  final File image;
  final String result;
  final NutritionInfo nutritionInfo;
  final BenefitsInfo benefitsInfo;

  const ResultPage({super.key, required this.image, required this.result, required this.nutritionInfo, required this.benefitsInfo});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 250,
                height: 250,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                    ),
                    child: ClipRect(
                      child: Image.file(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              '$result',
              style: const TextStyle(fontSize: 22, color:Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            Text('Benefits of $result:', style: const TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'Poppins'),),
            Text(
              benefitsInfo.benefits,
              style: const TextStyle(fontSize: 16, color:Colors.white, fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xFFC0E5C8),
                foregroundColor: Colors.black,
                elevation: 5,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NutriResPage(nutritionInfo: nutritionInfo, result:result),
                  ),
                );
              },
              child: const Text('View Nutritional Facts', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),),
            ),
          ],
        ),
      ),
    );
  }
}


