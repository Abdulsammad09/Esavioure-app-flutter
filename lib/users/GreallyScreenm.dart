import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key});

  final List<String> imageAssets = [
    'assets/images/g1.jpg',
    'assets/images/g2.jpeg',
    'assets/images/g3.jpg',
    // Add more asset paths as needed
  ];

  final List<String> sliderImages = [
    'assets/images/g4.jpg',
    'assets/images/g5.jpg',
    'assets/images/g6.png',
    // Add more asset paths for the slider
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding for all sides
        child: Column(
          children: [
            // Top Slider
            Container(
              height: 200, // Adjust height as needed
              child: PageView.builder(
                itemCount: sliderImages.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      sliderImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            // Add space between the slider and the text
            SizedBox(height: 20.0),
            Text(
              "Our Gallery",
              style: TextStyle(
                fontSize: 32, // Large text size
                fontWeight: FontWeight.bold, // Bold text
                fontFamily: 'Roboto', // Choose a custom font if available
                color: Colors.black87, // Text color
                letterSpacing: 2.0, // Space between letters
              ),
            ),
            // Add space between the text and the grid
            SizedBox(height: 20.0),
            // Combined GridView for Slider and Gallery
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0), // Padding inside the grid
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns set to 2
                  crossAxisSpacing: 8.0, // Space between columns
                  mainAxisSpacing: 8.0, // Space between rows
                ),
                itemCount: imageAssets.length + sliderImages.length, // Total count
                itemBuilder: (context, index) {
                  // Determine which list to use based on the index
                  String imagePath;
                  if (index < sliderImages.length) {
                    imagePath = sliderImages[index];
                  } else {
                    imagePath = imageAssets[index - sliderImages.length];
                  }

                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Optional border
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
