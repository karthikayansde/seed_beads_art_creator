import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'dart:typed_data'; // For Uint8List
import 'dart:ui' as ui; // For ui.Image, ui.Canvas, ui.PictureRecorder etc.
import 'dart:convert'; // For base64Encode
import 'package:flutter/foundation.dart'; // For kIsWeb
// Conditional import for dart:html (only available on web)
// import 'dart:html' as html;
import 'dart:math';
import 'package:path_provider/path_provider.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  @override
  State<HomeUi> createState() => _HomeUiState();
}

List<int> colorsList = [
  0xFF8DB600,
  0xFF7FFFD4,
  0xFF000000,
  0xFFFFB6C1,
  0xFFCC7722,
  0xFFFFEF00,
  0xFF960018,
  0xFF7FFF00,
  0xFFFFFDD0,
  0xFFDC143C,
  0xFF654321,
  0xFF013220,
  0xFF674C47,
  0xFFB06500,
  0xFFDAA520,
  0xFF7CFC00,
  0xFFC4C3D0,
  0xFF3F00FF,
  0xFF8FE3D1,
  0xFFFFDAB9,
  0xFFD2B48C,
  0xFFBFFF00,
  0xFF90CEE1,
  0xFFFF00FF,
  0xFFD4AF37,
  0xFFC0C0C0,
  0xFFC54B8C,
  0xFF708238,
  0xFFFFA500,
  0xFFE6674B,
  0xFFBDA0CB,
  0xFFFFE5B4,
  0xFF006994,
  0xFFFFC0CB,
  0xFFFF4500,
  0xFFFE2712,
  0xFF882D17,
  0xFFE86100,
  0xFF00FF7F,
  0xFF0073CF,
  0xFF009F6B,
  0xFF7C4848,
  0xFF3F00FF,
  0xFF8F00FF,
  0xFF324AB2,
  0xFFFFFFFF,
  0xFFC39953,
  0xFFFFAA1D,
];

class _HomeUiState extends State<HomeUi> {
  File? image;

  img.Image? reducedImage;
  double reducedWidth = 50;
  int reducedHeight = 0;
  late img.Image original;
  List<List<List<int>>> colorMatrix1 = [];

  // Define your 2D list of colors (can be bulk)
  List<List<Color>> circleColorsGrid = [];
  static const double _circleTileSize =
      50.0; // Defines the size of each circle tile in the generated image
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> requestPermission() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      return true;
    } else {
      openAppSettings();
      return false;
    }
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<void> loadAndReduceImage() async {
    // final byteData = await rootBundle.load("assets/download.jpg");
    // final bytes = byteData.buffer.asUint8List();
    final bytes = await image!.readAsBytes();
    original = img.decodeImage(bytes)!;
    await reduceImage();
  }

  Future<void> reduceImage() async {
    final aspectRatio = original.width / original.height;
    reducedHeight = (reducedWidth / aspectRatio).round();
    final resized = img.copyResize(
      original,
      width: reducedWidth.round(),
      height: reducedHeight,
    );
    setState(() {
      reducedImage = resized;
    });
  }

  //----------------------------------------------------

  Future<Uint8List> _generateImageFromColors(
    List<List<Color>> gridColors,
    double tileSize,
  ) async
  {
    final int numRows = gridColors.length;
    final int numCols =
        gridColors[0].length; // Assuming all rows have same number of columns

    final double imageWidth = numCols * tileSize;
    final double imageHeight = numRows * tileSize;

    // Create a PictureRecorder to record drawing commands
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    // Create a Canvas to draw on
    final ui.Canvas canvas = ui.Canvas(
      recorder,
      ui.Rect.fromLTWH(0, 0, imageWidth, imageHeight),
    );

    // Fill the entire canvas with a background color (e.g., white)
    canvas.drawRect(
      ui.Rect.fromLTWH(0, 0, imageWidth, imageHeight),
      Paint()..color = Colors.white,
    );

    // Iterate through the 2D array and draw each circle
    for (int r = 0; r < numRows; r++) {
      for (int c = 0; c < numCols; c++) {
        final Color outerColor = gridColors[r][c];

        // Calculate the top-left corner of the current tile
        final double tileLeft = c * tileSize;
        final double tileTop = r * tileSize;

        // Calculate the center of the current tile
        final Offset center = Offset(
          tileLeft + tileSize / 2,
          tileTop + tileSize / 2,
        );

        // Determine the maximum possible radius for a circle to fit perfectly in the tile
        final double maxRadius = tileSize / 2;

        // --- Outer Circle ---
        final double outerCircleRadius =
            maxRadius * 0.95; // Fills the entire tile
        final Paint outerPaint = Paint()
          ..color = outerColor
          ..style = PaintingStyle.fill;
        canvas.drawCircle(center, outerCircleRadius, outerPaint);

        // --- Inner White Circle (1/3 ratio of the outer circle's radius) ---
        final double innerCircleRadius = outerCircleRadius / 3;
        final Paint innerPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
        canvas.drawCircle(center, innerCircleRadius, innerPaint);
      }
    }

    // End recording and get the Picture
    final ui.Picture picture = recorder.endRecording();

    // Convert the Picture to an Image
    // Use a higher pixelRatio if you want a higher resolution image
    final ui.Image img = await picture.toImage(
      imageWidth.toInt(),
      imageHeight.toInt(),
    );

    // Convert the Image to ByteData in PNG format
    final ByteData? byteData = await img.toByteData(
      format: ui.ImageByteFormat.png,
    );

    if (byteData == null) {
      throw Exception('Failed to convert image to bytes.');
    }

    return byteData.buffer.asUint8List();
  }

  /// Handles the button click: shows loading, generates image, and downloads it.
  Future<void> _processAndDownloadImage() async {
    setState(() {
      _isGenerating = true;
    });
    await Future.delayed(Duration.zero);
    try {
      if (reducedImage != null) {
        circleColorsGrid = [];
        for (int y = 0; y < reducedImage!.height; y++) {
          List<Color> listTemp = [];
          for (int x = 0; x < reducedImage!.width; x++) {
            final pixel = reducedImage!.getPixel(x, y);
            listTemp.add(
              findNearestColor(Color.fromARGB(
                255,
                pixel.r.toInt(),
                pixel.g.toInt(),
                pixel.b.toInt(),
              ))
            );
          }
          circleColorsGrid.add(listTemp);
        }
        // List<List<List<int>>> list = [];
        // for (int y = 0; y < reducedImage!.height; y++) {
        //   List<List<int>> listTemp = [];
        //   for (int x = 0; x < reducedImage!.width; x++) {
        //     final pixel = reducedImage!.getPixel(x, y);
        //     List<int> temp = [];
        //     temp.add(pixel.r.toInt());
        //     temp.add(pixel.g.toInt());
        //     temp.add(pixel.b.toInt());
        //     listTemp.add (temp);
        //   }
        //   list.add(listTemp);
        // }
        // colorMatrix1 = list;
        // print(list);
      }
      // Process: Generate the image
      final Uint8List pngBytes = await _generateImageFromColors(
        circleColorsGrid,
        _circleTileSize,
      );

      // Download: Platform-specific logic
      // if (kIsWeb) {
      //   final base64data = base64Encode(pngBytes);
      //   final fileName = 'circle_grid_${DateTime.now().millisecondsSinceEpoch}.png';
      //
      //   final anchor = html.AnchorElement(
      //     href: 'data:image/png;base64,$base64data',
      //   )..setAttribute('download', fileName);
      //
      //   html.document.body?.append(anchor);
      //   anchor.click();
      //   anchor.remove();
      //
      //   if (mounted) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('Image "$fileName" downloaded successfully!')),
      //     );
      //   }
      // } else
      // {
      //   // Mobile download logic
      //   final fileName = 'circle_grid_${DateTime.now().millisecondsSinceEpoch}.png';
      //
      //   // Get the appropriate directory
      //   final directory = await getApplicationDocumentsDirectory();
      //   final filePath = '${directory.path}/$fileName';
      //
      //   // Write the file
      //   final file = File(filePath);
      //   await file.writeAsBytes(pngBytes);
      //
      //   if (mounted) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text('Image saved to: $filePath'),
      //         duration: const Duration(seconds: 4),
      //       ),
      //     );
      //   }
      // }
      {
        // Request storage permission
        // if (Platform.isAndroid) {
        //   final status = await Permission.storage.request();
        //   if (!status.isGranted) {
        //     if (mounted) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(content: Text('Storage permission denied')),
        //       );
        //     }
        //     return;
        //   }
        // }

        final fileName =
            'circle_grid_${DateTime.now().millisecondsSinceEpoch}.png';

        // Get Downloads directory
        final directory = Platform.isAndroid
            ? Directory('/storage/emulated/0/Download')
            : await getApplicationDocumentsDirectory();

        final filePath = '${directory.path}/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(pngBytes);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Image saved to Downloads!\n$fileName'),
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error generating or downloading image: $e')),
        );
      }
      print('Error generating or downloading image: $e');
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seed Bead Art Creator")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("upload image"),
                  SizedBox(width: 20),
                  FloatingActionButton(
                    child: Icon(Icons.image),
                    onPressed: () async {
                      image = await pickImage();
                      await loadAndReduceImage();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Width: ${reducedWidth.round()} px, Height: $reducedHeight px',
              style: const TextStyle(fontSize: 18),
            ),
            Slider(
              min: 10,
              max: 300,
              divisions: 29,
              value: reducedWidth,
              label: reducedWidth.round().toString(),
              onChanged: (value) async {
                setState(() {
                  reducedWidth = value;
                });
                await reduceImage();
              },
            ),
            const SizedBox(height: 10),
            if (reducedImage != null)
              Center(
                child: InteractiveViewer(
                  child: CustomPaint(
                    painter: PixelPainter(reducedImage!),
                    size: Size(320, (320 * (reducedHeight / reducedWidth))),
                  ),
                ),
              ),

            //----------------------------------------
            if (_isGenerating)
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // CircularProgressIndicator(),
                    // SizedBox(height: 10),
                    Text('Processing image...'),
                  ],
                ),
              )
            else
              ElevatedButton(
                onPressed: _processAndDownloadImage,
                child: const Text('Generate and Download Image'),
              ),
            //---------------------------------------

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: colorsList.map((e) => Container(margin: EdgeInsets.all(10),decoration: BoxDecoration(border: Border.all(color:
                Colors.black, width: 1.5),color: Color(e), ), height: 50, width: 50, ),).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color findNearestColor(Color sourceColor) {
  double minDistance = double.infinity;
  Color nearestColor = Color(colorsList[0]);

  for (int colorValue in colorsList) {
    Color targetColor = Color(colorValue);

    // Calculate Euclidean distance in RGB space
    double distance = sqrt(
      pow(sourceColor.red - targetColor.red, 2) +
          pow(sourceColor.green - targetColor.green, 2) +
          pow(sourceColor.blue - targetColor.blue, 2),
    );

    if (distance < minDistance) {
      minDistance = distance;
      nearestColor = targetColor;
    }
  }

  return nearestColor;
}
class PixelPainter extends CustomPainter {
  final img.Image image;

  PixelPainter(this.image);


  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 0.2;

    final pixelWidth = size.width / image.width;
    final pixelHeight = size.height / image.height;

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y); // returns a Pixel object

        final sourceColor = Color.fromARGB(
          255,
          pixel.r.toInt(),
          pixel.g.toInt(),
          pixel.b.toInt(),
        );

        // Find the nearest matching color from our palette
        paint.color = findNearestColor(sourceColor);

        final rect = Rect.fromLTWH(
          x * pixelWidth,
          y * pixelHeight,
          pixelWidth,
          pixelHeight,
        );

        canvas.drawRect(rect, paint); // Fill pixel
        canvas.drawRect(rect, borderPaint); // Draw thin border
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

//-----------------------------------------
class ColorMatrixDisplay extends StatelessWidget {
  final List<List<List<int>>> colorMatrix;
  ColorMatrixDisplay({super.key, required this.colorMatrix});

  // Example 2D matrix of colors (r, g, b)
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: colorMatrix.map((row) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: row.map((rgb) {
              final color = Color.fromARGB(255, rgb[0], rgb[1], rgb[2]);
              return CircleAvatar(
                radius: 6,
                backgroundColor: color,
                child: Image.asset("assets/seed bead-modified.png"),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

//-----------------------------------------
