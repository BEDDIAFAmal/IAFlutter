import 'dart:convert';

import 'package:flutter/material.dart';

class AddActivityScreen extends StatefulWidget {
  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  late TextEditingController _imageBase64Controller;

  @override
  void initState() {
    super.initState();
    _imageBase64Controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Your other form fields go here

            // Text field for base64 representation of the image
            TextField(
              controller: _imageBase64Controller,
              decoration: InputDecoration(labelText: 'Image Base64'),
            ),

            // Your other form fields go here

            ElevatedButton(
              onPressed: () {
                // Access the base64 representation from the controller
                String imageBase64 = _imageBase64Controller.text;

                // Decode the base64 string to bytes
                List<int> imageBytes = base64.decode(imageBase64);

                // Now you can use imageBytes as needed
                // For example, you might want to display it using Image.memory
                // Image.memory(Uint8List.fromList(imageBytes))

                // Perform your logic with imageBytes
              },
              child: Text('Add Activity'),
            ),
          ],
        ),
      ),
    );
  }
}
