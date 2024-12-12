
// ignore_for_file: use_key_in_widget_constructors

import 'dart:ui' as ui; // potentially useful in loading images into memory and custom drawing eg for focus box
import 'package:flutter/material.dart'; // basic
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'; // For text recognition, without other aspects of ml_kit


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageDisplayScreen(),
    );
  }
}


// Stateful as widget is dynamic (when it was a still image, it was Stateless)
class ImageDisplayScreen extends StatefulWidget {
  @override
  ImageDisplayScreenState createState() => ImageDisplayScreenState(); // Creates an instance of the _ImageDisplayScreenState class, which contains the mutable state for the ImageDisplayScreen widget
}

class ImageDisplayScreenState extends State<ImageDisplayScreen> {
  // In _performOCR class for encapsulation, keeping all functionality (image display, bounding box, OCR results) together
  // It is a StatefulWidget so can manage dynamic aspects such as displaying the bounding boxes or updating the OCR results

  final String imagePath = 'assets/sample_image.jpg'; // Path to static saved image for reading
  List<TextElement> detectedWords = []; // declare and initialise the list of objects of type TextElement

  //  Overrides initState so that _processImageForOCR() will start processing the image as soon as the widget is created
  @override
  void initState() {
    super.initState();
    _processImageForOCR();
  }

  Future<void> _processImageForOCR() async {

    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin); // Recogniser to focus on latin-based scripts
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    // Process words
    List<TextElement> words = [];
    for (var block in recognizedText.blocks) {
      for (var line in block.lines) {
        for (var element in line.elements) {
          words.add(element);
        }
      }
    }

    // This code updates the detectedWords list with new words and 
    // calls setState to rebuild the UI with the updated data to ensure any changes to detectedWords are reflected on the screen.
    setState(() {
      detectedWords = words;
    });

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Image Example'),
      ),
      body: Center(
        child: Stack(
          children: [
            // Display the image
            Image.asset('assets/sample_image.jpg', fit: BoxFit.contain), // Path to your image file in assets
            ...detectedWords.map((word) {
              final rect = word.boundingBox;
              // Add the focus box
              return Positioned(
                left: rect.left,
                top: rect.top,
                width: rect.width,
                height: rect.height,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.amber.shade600, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }), // originally had .toList() but apparently unnecessary with the ... spread operator, which words direcly with Iterable
          ],
        ),
      ),
    );
  }
  
}
