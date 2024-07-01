import 'dart:async';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitsynergy_tracker/result.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'dart:io';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  var v = "";

  @override
  void initState() {
    super.initState();
    print("Initializing HomePage");
    loadmodel().then((value) {
      setState(() {});
    });
  }

  loadmodel() async {
    print("Loading TFLite model");
    await Tflite.loadModel(
      model: "assets/fruit_recognition_model.tflite",
      labels: "assets/fruit_classes.txt",
    );
    print("Model loaded");
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        file = File(image!.path);
      });
      detectimage(file!);
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _clickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = pickedFile;
        file = File(pickedFile!.path);
      });
      detectimage(file!);
    } catch (e) {
      print('Error clicking image: $e');
    }
  }

  Future detectimage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    var highConfidenceRecognitions =
    output?.where((res) => res['confidence'] > 0.5).toList();
    print(highConfidenceRecognitions);
    setState(() {
      if (highConfidenceRecognitions == null || highConfidenceRecognitions.isEmpty) {
        v = "Ambiguity in Image";
      } else {
        v = highConfidenceRecognitions.map((res) => res['label']).join(', ');
      }
    });
    print("Recognized image : $v");

    // Clear the image and result in the home page
    setState(() {
      _image = null;
    });

    NutritionInfo nutritionInfo = await _getNutritionInfo(v);
    BenefitsInfo benefitsInfo = await _getBenefitsInfo(v);

    // Navigate to the ResultPage

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(image: image, result: v,nutritionInfo: nutritionInfo,benefitsInfo: benefitsInfo),
        ));
  }

  Future<NutritionInfo> _getNutritionInfo(String fruitName) async {
    final rawData = await rootBundle.loadString('assets/Fruits_Nutrition_Dataset.csv');
    List<List<dynamic>> rows = const CsvToListConverter().convert(rawData);

    for (var row in rows) {
      if (row[0].toString().toLowerCase() == fruitName.toLowerCase()) {
        return NutritionInfo(
            row[0], // Fruit name
            row[1].toString(), // Energy (kcal/kJ)
            row[2].toString(), // Water (g)
            row[3].toString(), // Protein (g)
            row[4].toString(), // Total fat (g)
            row[5].toString(), // Carbohydrates (g)
            row[6].toString() // Fiber (g)
        );
      }
    }
    return NutritionInfo(fruitName, 'N/A', 'N/A', 'N/A', 'N/A','N/A', 'N/A'); // Default value if not found
  }

  Future<BenefitsInfo> _getBenefitsInfo(String fruitName) async {
    final rawData = await rootBundle.loadString('assets/Fruits_Nutrition_Dataset.csv');
    List<List<dynamic>> rows = const CsvToListConverter().convert(rawData);

    // Iterate through each row to find the fruit name
    for (var row in rows) {
      if (row[0].toString().toLowerCase() == fruitName.toLowerCase()) {
        if (row.length > 22) {
          final benefits = row[22].toString();
          return BenefitsInfo(benefits); // Extract the 23rd column (index 22)
        }
      }
    }

    return BenefitsInfo('N/A'); // Default value if not found
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 0, bottom: 0),
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image.asset("assets/icon/Icon_app.jpeg"),
              ),
            ),
            _image == null
                ? const Text(style: TextStyle(color:Colors.white, fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                'No image selected.')
                : Image.file(File(_image!.path)),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              height: 45,
              child: ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color(0xFFC0E5C8),
                  foregroundColor: Colors.black,
                  elevation: 5,
                ),
                child: const Text('Pick Image from Gallery',style: TextStyle(fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              height: 45,
              child: ElevatedButton(
                onPressed: _clickImage,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color(0xFFC0E5C8),
                  foregroundColor: Colors.black,
                  elevation: 5,
                ),
                child: const Text('Open Camera',style: TextStyle(fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BenefitsInfo {
  final String benefits;

  BenefitsInfo(this.benefits);
}


class NutritionInfo {
  final String fruitName;
  final String energy;
  final String water;
  final String protein;
  final String total_fat;
  final String carbohydrates;
  final String fiber;
  // Add other fields as needed

  NutritionInfo(this.fruitName, this.energy, this.water, this.protein, this.total_fat, this.carbohydrates, this.fiber);
}