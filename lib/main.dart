// // import 'package:flutter/material.dart';
// // import 'package:seed_beats/views/home_ui.dart';
// // import 'package:http/http.dart' as http;
// //
// // Future<void> main() async {
// //   runApp(const HomeUi());
// // }
// //
// // / reduce quality with border----------------------------------------------------------------
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:image/image.dart' as img;
// // import 'package:flutter/services.dart' show rootBundle;
// //
// //
// // void main() {
// //   runApp(const MaterialApp(home: ImagePixelReducer()));
// // }
// //
// // class ImagePixelReducer extends StatefulWidget {
// //   const ImagePixelReducer({super.key});
// //
// //   @override
// //   State<ImagePixelReducer> createState() => _ImagePixelReducerState();
// // }
// //
// // class _ImagePixelReducerState extends State<ImagePixelReducer> {
// //   img.Image? reducedImage;
// //   double reducedWidth = 50;
// //   int reducedHeight = 0;
// //   late img.Image original;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     loadAndReduceImage();
// //   }
// //
// //   Future<void> loadAndReduceImage() async {
// //     final byteData = await rootBundle.load("assets/download.jpg");
// //     final bytes = byteData.buffer.asUint8List();
// //     original = img.decodeImage(bytes)!;
// //     await reduceImage();
// //   }
// //
// //   Future<void> reduceImage() async {
// //     final aspectRatio = original.width / original.height;
// //     reducedHeight = (reducedWidth / aspectRatio).round();
// //     final resized = img.copyResize(original,
// //         width: reducedWidth.round(), height: reducedHeight);
// //     setState(() {
// //       reducedImage = resized;
// //     });
// //   }
// //
// //   List<List<List<int>>> colorMatrix1 = [];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Seed Beads Art Creator')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(4),
// //         child: Column(
// //           children: [
// //             Text(
// //               'Width: ${reducedWidth.round()} px, Height: $reducedHeight px',
// //               style: const TextStyle(fontSize: 18),
// //             ),
// //             ElevatedButton(
// //               onPressed: () {
// //                 if (reducedImage != null) {
// //                   List<List<List<int>>> list = [];
// //                   for (int y = 0; y < reducedImage!.height; y++) {
// //                     List<List<int>> listTemp = [];
// //                     for (int x = 0; x < reducedImage!.width; x++) {
// //                       final pixel = reducedImage!.getPixel(x, y);
// //                       List<int> temp = [];
// //                       temp.add(pixel.r.toInt());
// //                       temp.add(pixel.g.toInt());
// //                       temp.add(pixel.b.toInt());
// //                       listTemp.add (temp);
// //                     }
// //                     list.add(listTemp);
// //                   }
// //                   colorMatrix1 = list;
// //                   print(list);
// //                 }
// //                 setState(() {
// //
// //                 });
// //               },
// //               child: const Text('Print Pixels'),
// //             ),
// //             Slider(
// //               min: 10,
// //               max: 300,
// //               divisions: 29,
// //               value: reducedWidth,
// //               label: reducedWidth.round().toString(),
// //               onChanged: (value) async {
// //                 setState(() {
// //                   reducedWidth = value;
// //                 });
// //                 await reduceImage();
// //               },
// //             ),
// //             const SizedBox(height: 10),
// //             if (reducedImage != null)
// //               Center(
// //                 child: InteractiveViewer(
// //                   child: CustomPaint(
// //                     painter: PixelPainter(reducedImage!),
// //                     size: Size(320, (320 * (reducedHeight / reducedWidth))),
// //                   ),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// // }
// //
// // class PixelPainter extends CustomPainter {
// //   final img.Image image;
// //
// //   PixelPainter(this.image);
// //
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint();
// //     final borderPaint = Paint()
// //       ..style = PaintingStyle.stroke
// //       ..color = Colors.black
// //       ..strokeWidth = 0.2;
// //
// //     final pixelWidth = size.width / image.width;
// //     final pixelHeight = size.height / image.height;
// //
// //     for (int y = 0; y < image.height; y++) {
// //       for (int x = 0; x < image.width; x++) {
// //         final pixel = image.getPixel(x, y); // returns a Pixel object
// //
// //         final r = pixel.r;
// //         final g = pixel.g;
// //         final b = pixel.b;
// //         final a = pixel.a;
// //
// //         paint.color = Color.fromARGB(a.toInt(), r.toInt(), g.toInt(), b.toInt());
// //
// //         final rect = Rect.fromLTWH(
// //           x * pixelWidth,
// //           y * pixelHeight,
// //           pixelWidth,
// //           pixelHeight,
// //         );
// //
// //         canvas.drawRect(rect, paint);        // Fill pixel
// //         canvas.drawRect(rect, borderPaint);  // Draw thin border
// //       }
// //     }
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// // }
// // //-----------------------------------------
// // class ColorMatrixDisplay extends StatelessWidget {
// //
// //   final List<List<List<int>>> colorMatrix;
// //   ColorMatrixDisplay({super.key, required this.colorMatrix});
// //
// //   // Example 2D matrix of colors (r, g, b)
// //   @override
// //   Widget build(BuildContext context) {
// //     return  Center(
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: colorMatrix.map((row) {
// //           return Row(
// //             mainAxisSize: MainAxisSize.min,
// //             children: row.map((rgb) {
// //               final color = Color.fromARGB(255, rgb[0], rgb[1], rgb[2]);
// //               return
// //                 CircleAvatar(
// //                   radius: 6,
// //                   backgroundColor: color,
// //                   child: Image.asset("assets/seed bead-modified.png"),
// //                 );
// //             }).toList(),
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }
// // }
// //
// // / creating image and downloading it---------------------------------------------------------------
//
// import 'dart:typed_data'; // For Uint8List
// import 'dart:ui' as ui; // For ui.Image, ui.Canvas, ui.PictureRecorder etc.
// import 'dart:convert'; // For base64Encode
//
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart'; // For kIsWeb
//
// // Conditional import for dart:html (only available on web)
// import 'dart:html' as html;
// import 'dart:math';
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Generate & Download Image',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ImageGeneratorScreen(),
//     );
//   }
// }
//
// class ImageGeneratorScreen extends StatefulWidget {
//   const ImageGeneratorScreen({super.key});
//
//   @override
//   _ImageGeneratorScreenState createState() => _ImageGeneratorScreenState();
// }
//
// class _ImageGeneratorScreenState extends State<ImageGeneratorScreen> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     circleColorsGrid = generateRandomColorGrid(200);
//   }
//   bool _isGenerating = false; // State to show loading indicator
//   List<List<Color>> generateRandomColorGrid(int size) {
//     final random = Random();
//     return List.generate(size, (_) {
//       return List.generate(size, (_) {
//         // Generate a random opaque color
//         return Color.fromARGB(
//           255,
//           random.nextInt(256),
//           random.nextInt(256),
//           random.nextInt(256),
//         );
//       });
//     });
//   }
//   // Define your 2D list of colors (can be bulk)
//   List<List<Color>> circleColorsGrid = [];
//   static const double _circleTileSize = 25.0; // Defines the size of each circle tile in the generated image
//
//   /// Generates the image from the 2D color grid directly onto an off-screen canvas.
//   Future<Uint8List> _generateImageFromColors(
//       List<List<Color>> gridColors, double tileSize) async {
//     final int numRows = gridColors.length;
//     final int numCols = gridColors[0].length; // Assuming all rows have same number of columns
//
//     final double imageWidth = numCols * tileSize;
//     final double imageHeight = numRows * tileSize;
//
//     // Create a PictureRecorder to record drawing commands
//     final ui.PictureRecorder recorder = ui.PictureRecorder();
//     // Create a Canvas to draw on
//     final ui.Canvas canvas =
//     ui.Canvas(recorder, ui.Rect.fromLTWH(0, 0, imageWidth, imageHeight));
//
//     // Fill the entire canvas with a background color (e.g., white)
//     canvas.drawRect(
//         ui.Rect.fromLTWH(0, 0, imageWidth, imageHeight), Paint()..color = Colors.white);
//
//     // Iterate through the 2D array and draw each circle
//     for (int r = 0; r < numRows; r++) {
//       for (int c = 0; c < numCols; c++) {
//         final Color outerColor = gridColors[r][c];
//
//         // Calculate the top-left corner of the current tile
//         final double tileLeft = c * tileSize;
//         final double tileTop = r * tileSize;
//
//         // Calculate the center of the current tile
//         final Offset center = Offset(tileLeft + tileSize / 2, tileTop + tileSize / 2);
//
//         // Determine the maximum possible radius for a circle to fit perfectly in the tile
//         final double maxRadius = tileSize / 2;
//
//         // --- Outer Circle ---
//         final double outerCircleRadius = maxRadius * 0.95; // Fills the entire tile
//         final Paint outerPaint = Paint()
//           ..color = outerColor
//           ..style = PaintingStyle.fill;
//         canvas.drawCircle(center, outerCircleRadius, outerPaint);
//
//         // --- Inner White Circle (1/3 ratio of the outer circle's radius) ---
//         final double innerCircleRadius = outerCircleRadius / 3;
//         final Paint innerPaint = Paint()
//           ..color = Colors.white
//           ..style = PaintingStyle.fill;
//         canvas.drawCircle(center, innerCircleRadius, innerPaint);
//       }
//     }
//
//     // End recording and get the Picture
//     final ui.Picture picture = recorder.endRecording();
//
//     // Convert the Picture to an Image
//     // Use a higher pixelRatio if you want a higher resolution image
//     final ui.Image img = await picture.toImage(imageWidth.toInt(), imageHeight.toInt());
//
//     // Convert the Image to ByteData in PNG format
//     final ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
//
//     if (byteData == null) {
//       throw Exception('Failed to convert image to bytes.');
//     }
//
//     return byteData.buffer.asUint8List();
//   }
//
//   /// Handles the button click: shows loading, generates image, and downloads it.
//   Future<void> _processAndDownloadImage() async {
//     setState(() {
//       _isGenerating = true;
//     });
//     await Future.delayed(Duration.zero);
//     try {
//       // Process: Generate the image
//       final Uint8List pngBytes =
//       await _generateImageFromColors(circleColorsGrid, _circleTileSize);
//
//       // Download: Web-specific logic
//       if (kIsWeb) {
//         final base64data = base64Encode(pngBytes);
//         final fileName = 'circle_grid_${DateTime.now().millisecondsSinceEpoch}.png';
//
//         final anchor = html.AnchorElement(
//           href: 'data:image/png;base64,$base64data',
//         )..setAttribute('download', fileName);
//
//         html.document.body?.append(anchor);
//         anchor.click();
//         anchor.remove();
//
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Image "$fileName" downloaded successfully!')),
//           );
//         }
//       } else {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Downloading is only supported on web in this example.')),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error generating or downloading image: $e')),
//         );
//       }
//       print('Error generating or downloading image: $e');
//     } finally {
//       setState(() {
//         _isGenerating = false; // Hide loading indicator
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Generate & Download Image'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (_isGenerating)
//               const Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     // CircularProgressIndicator(),
//                     // SizedBox(height: 10),
//                     Text('Processing image...'),
//                   ],
//                 ),
//               )
//             else
//               ElevatedButton(
//                 onPressed: _processAndDownloadImage,
//                 child: const Text('Generate and Download Image'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// // ------------------------------------------------old versions--------------------------------------------------
// //
// // import 'dart:typed_data';
// // import 'dart:ui' as ui;
// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter/rendering.dart';
// // import 'package:flutter/foundation.dart';
// //
// // import 'dart:html' as html;
// //
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: '2D Circle Grid Download',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const SmoothCircleGridScreen(),
// //     );
// //   }
// // }
// //
// // class SmoothCircleGridScreen extends StatefulWidget {
// //   const SmoothCircleGridScreen({super.key});
// //
// //   @override
// //   _SmoothCircleGridScreenState createState() => _SmoothCircleGridScreenState();
// // }
// //
// // class _SmoothCircleGridScreenState extends State<SmoothCircleGridScreen> {
// //   final GlobalKey _gridKey = GlobalKey();
// //
// //   final List<List<Color>> _circleColorsGrid = [
// //     [Colors.red, Colors.green, Colors.blue, Colors.purple],
// //     [Colors.orange, Colors.teal, Colors.pink, Colors.brown],
// //     [Colors.amber, Colors.cyan, Colors.indigo, Colors.lime],
// //     [Colors.red, Colors.green, Colors.blue, Colors.purple],
// //   ];
// //
// //   static const double _circleTileSize = 10.0;
// //
// //   Future<void> _captureAndDownloadImage() async {
// //     try {
// //       RenderRepaintBoundary? boundary =
// //       _gridKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
// //
// //       if (boundary == null) {
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Could not find render object.')),
// //           );
// //         }
// //         return;
// //       }
// //
// //       ui.Image image = await boundary.toImage(pixelRatio: 2.0);
// //
// //       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
// //       if (byteData == null) {
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Failed to convert image to bytes.')),
// //           );
// //         }
// //         return;
// //       }
// //
// //       Uint8List pngBytes = byteData.buffer.asUint8List();
// //
// //       if (kIsWeb) {
// //         final base64data = base64Encode(pngBytes);
// //         final fileName = 'circle_grid_${DateTime.now().millisecondsSinceEpoch}.png';
// //
// //         final anchor = html.AnchorElement(
// //           href: 'data:image/png;base64,$base64data',
// //         )..setAttribute('download', fileName);
// //
// //         html.document.body?.append(anchor);
// //         anchor.click();
// //         anchor.remove();
// //
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(content: Text('Image "$fileName" downloaded successfully!')),
// //           );
// //         }
// //       } else {
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Downloading is only supported on web in this example.')),
// //           );
// //         }
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Error capturing or downloading image: $e')),
// //         );
// //       }
// //       print('Error capturing or downloading image: $e');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('2D Circle Grid (No Padding)'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             // RepaintBoundary captures the visual output of its child
// //             RepaintBoundary(
// //               key: _gridKey,
// //               // The white background is moved here to ensure the captured image has a background
// //               // If you want a transparent background, change this to Colors.transparent
// //               child: Container(
// //                 color: Colors.white,
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   // We use MainAxisSize.min to ensure the Column only takes up as much space as its children
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: _circleColorsGrid.map((rowColors) {
// //                     return Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: rowColors.map((color) {
// //                         // The Container no longer has margin or decoration (border)
// //                         return Container(
// //                           width: _circleTileSize,
// //                           height: _circleTileSize,
// //                           child: CustomPaint(
// //                             painter: CircleRatioPainter(outerCircleColor: color),
// //                           ),
// //                         );
// //                       }).toList(),
// //                     );
// //                   }).toList(),
// //                 ),
// //               ),
// //             ),
// //             // The SizedBox for spacing is removed
// //             ElevatedButton(
// //               onPressed: _captureAndDownloadImage,
// //               child: const Text('Download Grid as Image (Web Only)'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // Our CustomPainter class remains exactly the same
// // class CircleRatioPainter extends CustomPainter {
// //   final Color outerCircleColor;
// //
// //   CircleRatioPainter({required this.outerCircleColor});
// //
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final Offset center = Offset(size.width / 2, size.height / 2);
// //     final double maxRadius = size.shortestSide / 2;
// //
// //     final double outerCircleRadius = maxRadius;
// //     final Paint outerPaint = Paint()
// //       ..color = outerCircleColor
// //       ..style = PaintingStyle.fill;
// //     canvas.drawCircle(center, outerCircleRadius, outerPaint);
// //
// //     final double innerCircleRadius = outerCircleRadius / 3;
// //     final Paint innerPaint = Paint()
// //       ..color = Colors.white
// //       ..style = PaintingStyle.fill;
// //     canvas.drawCircle(center, innerCircleRadius, innerPaint);
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant CircleRatioPainter oldDelegate) {
// //     return oldDelegate.outerCircleColor != outerCircleColor;
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'dart:math'; // For min and max functions
//
// void main() {
//   runApp(const ColorDisplayApp());
// }
//
// class ColorDisplayApp extends StatelessWidget {
//   const ColorDisplayApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hex Color Display',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         fontFamily: 'Inter', // Using Inter font as per instructions
//       ),
//       home: const ColorListPage(),
//     );
//   }
// }
//
// class ColorListPage extends StatefulWidget {
//   const ColorListPage({super.key});
//
//   @override
//   State<ColorListPage> createState() => _ColorListPageState();
// }
//
// class _ColorListPageState extends State<ColorListPage> {
//   final TextEditingController _hexInputController = TextEditingController();
//   final List<ColorItem> _colorItems = [];
//
//   // Function to parse and validate a single hex code
//   Color? _parseHexColor(String hexString) {
//     String formattedHex = hexString.trim().toUpperCase();
//
//     // Remove '#' if present
//     if (formattedHex.startsWith('#')) {
//       formattedHex = formattedHex.substring(1);
//     }
//
//     // Check if it's a valid 6-digit hex code
//     if (formattedHex.length == 6 && RegExp(r'^[0-9A-F]{6}$').hasMatch(formattedHex)) {
//       try {
//         // Add FF for full opacity (ARGB format)
//         return Color(int.parse('FF$formattedHex', radix: 16));
//       } catch (e) {
//         // Handle parsing errors, though regex should prevent most
//         print('Error parsing hex: $hexString, Error: $e');
//         return null;
//       }
//     }
//     return null;
//   }
//
//   // Helper function to convert RGB to HSV for sorting
//   // Returns a list [h, s, v] where h is 0-360, s and v are 0-1
//   List<double> _rgbToHsv(Color color) {
//     double r = color.red / 255.0;
//     double g = color.green / 255.0;
//     double b = color.blue / 255.0;
//
//     double maxVal = max(max(r, g), b);
//     double minVal = min(min(r, g), b);
//     double delta = maxVal - minVal;
//
//     double h = 0.0;
//     double s = 0.0;
//     double v = maxVal; // Value is simply the maximum component
//
//     if (maxVal != 0.0) {
//       s = delta / maxVal; // Saturation
//     }
//
//     if (delta != 0.0) {
//       if (maxVal == r) {
//         h = (g - b) / delta + (g < b ? 6 : 0);
//       } else if (maxVal == g) {
//         h = (b - r) / delta + 2;
//       } else {
//         h = (r - g) / delta + 4;
//       }
//       h /= 6.0; // Convert to 0-1 range
//     }
//
//     return [h * 360, s, v]; // Hue in degrees (0-360), Saturation 0-1, Value 0-1
//   }
//
//   // Function to add colors from the input field
//   void _addColorsFromInput() {
//     final String input = _hexInputController.text;
//     if (input.isEmpty) {
//       _showMessage('Please enter hex codes.', Colors.orange);
//       return;
//     }
//
//     // Split by common delimiters: comma, space, newline
//     final List<String> hexStrings = input
//         .split(RegExp(r'[,\s\n]+'))
//         .where((s) => s.isNotEmpty)
//         .toList();
//
//     bool anyAdded = false;
//     for (String hexStr in hexStrings) {
//       final Color? color = _parseHexColor(hexStr);
//       if (color != null) {
//         // Check if the color already exists to avoid duplicates
//         if (!_colorItems.any((item) => item.color == color)) {
//           setState(() {
//             _colorItems.add(ColorItem(color: color, hexCode: '#${hexStr.toUpperCase()}'));
//           });
//           anyAdded = true;
//         }
//       } else {
//         print('Invalid hex code skipped: $hexStr');
//       }
//     }
//
//     if (anyAdded) {
//       // Sort the list after adding new colors based on HSV
//       setState(() {
//         _colorItems.sort((a, b) {
//           List<double> hsvA = _rgbToHsv(a.color);
//           List<double> hsvB = _rgbToHsv(b.color);
//
//           // Sort primarily by Hue (0-360) - ascending
//           if (hsvA[0] != hsvB[0]) {
//             return hsvA[0].compareTo(hsvB[0]);
//           }
//           // Then by Value/Brightness (0-1) - descending (brighter first)
//           if (hsvA[2] != hsvB[2]) {
//             return hsvB[2].compareTo(hsvA[2]); // Note the reversed comparison for descending
//           }
//           // Finally by Saturation (0-1) - descending (more saturated first)
//           return hsvB[1].compareTo(hsvA[1]); // Note the reversed comparison for descending
//         });
//       });
//       _hexInputController.clear(); // Clear input after adding
//       _showMessage('Colors added and sorted successfully!', Colors.green);
//     } else {
//       _showMessage('No new valid colors found in input or all were duplicates.', Colors.red);
//     }
//   }
//
//   // Helper function to show snackbar messages
//   void _showMessage(String message, Color color) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: color,
//         duration: const Duration(seconds: 2),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         margin: const EdgeInsets.all(10),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hex Color Viewer'),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Input Section
//             Container(
//               padding: const EdgeInsets.all(12.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextField(
//                     controller: _hexInputController,
//                     decoration: InputDecoration(
//                       labelText: 'Enter Hex Codes (e.g., #FF0000, 00FF00)',
//                       hintText: 'Separate by comma, space, or new line',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                     ),
//                     maxLines: 3,
//                     keyboardType: TextInputType.multiline,
//                   ),
//                   const SizedBox(height: 15),
//                   ElevatedButton(
//                     onPressed: _addColorsFromInput,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blueAccent, // Button background color
//                       foregroundColor: Colors.white, // Text color
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       elevation: 5,
//                     ),
//                     child: const Text(
//                       'Add Colors',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Display Section
//             Expanded(
//               child: _colorItems.isEmpty
//                   ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.color_lens_outlined, size: 80, color: Colors.grey[400]),
//                     const SizedBox(height: 10),
//                     Text(
//                       'No colors added yet. Enter hex codes above!',
//                       style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               )
//                   : Scrollbar( // Added Scrollbar here
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 10.0, // Max width for each tile (approx 50px)
//                     crossAxisSpacing: 2.0, // Small spacing between tiles
//                     mainAxisSpacing: 2.0, // Small spacing between tiles
//                     childAspectRatio: 1.0, // Makes tiles square (50x50)
//                   ),
//                   itemCount: _colorItems.length,
//                   itemBuilder: (context, index) {
//                     final ColorItem item = _colorItems[index];
//                     return ColorCard(item: item);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ColorItem {
//   final Color color;
//   final String hexCode;
//
//   ColorItem({required this.color, required this.hexCode});
// }
//
// class ColorCard extends StatelessWidget {
//   final ColorItem item;
//
//   const ColorCard({super.key, required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 1, // Reduced elevation for a flatter look
//       margin: EdgeInsets.zero, // Remove default card margin
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(4.0), // Slightly rounded corners for tiles
//         side: BorderSide(color: Colors.grey.shade300, width: 0.5), // Subtle border
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: item.color,
//           borderRadius: BorderRadius.circular(4.0),
//         ),
//         // No text overlay for fixed 50x50 tiles, as it would be too small.
//         // If you need to see the hex code, you might consider a hover/tap effect,
//         // but for a dense grid, it's usually just the color itself.
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:collection/collection.dart'; // For more advanced list operations if needed
//
// // You'll likely need a package for HSL conversion, e.g., 'hsluv' or a custom utility.
// // For simplicity in this example, I'll use a conceptual HSL conversion.
// // For a real app, consider adding 'hsluv: ^X.Y.Z' to your pubspec.yaml and importing it.
//
// void main() {
//   runApp(const ColorGridApp());
// }
//
// class ColorGridApp extends StatelessWidget {
//   const ColorGridApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Color Sorter',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ColorInputScreen(),
//     );
//   }
// }
//
// class ColorInputScreen extends StatefulWidget {
//   const ColorInputScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ColorInputScreen> createState() => _ColorInputScreenState();
// }
//
// class _ColorInputScreenState extends State<ColorInputScreen> {
//   final TextEditingController _textEditingController = TextEditingController();
//   List<String> _inputHexColors = [];
//
//   void _processInput() {
//     setState(() {
//       _inputHexColors = _textEditingController.text
//           .split(',')
//           .map((s) => s.trim())
//           .where((s) => s.isNotEmpty && s.startsWith('#') && (s.length == 7 || s.length == 9)) // Basic validation
//           .toList();
//     });
//
//     if (_inputHexColors.isNotEmpty) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ColorGridDisplayScreen(hexColors: _inputHexColors),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter valid hex color codes separated by commas.')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enter Color Hex Codes'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _textEditingController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter hex color codes (e.g., #FF0000, #00FF00)',
//                 hintText: 'Enter thousands of colors to see how they map!',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 10, // Increased lines for more input
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _processInput,
//               child: const Text('Show Sorted Colors'),
//             ),
//             const SizedBox(height: 16.0),
//             Text('Number of colors entered: ${_inputHexColors.length}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Data model for HSL color
// class HSLColorData {
//   final Color color;
//   final double h; // Hue (0-360)
//   final double s; // Saturation (0-1)
//   final double l; // Lightness (0-1)
//
//   HSLColorData({required this.color, required this.h, required this.s, required this.l});
//
//   // For debugging
//   @override
//   String toString() => 'Color(H:${h.toStringAsFixed(0)}, S:${s.toStringAsFixed(2)}, L:${l.toStringAsFixed(2)}, Hex:${color.toHexString()})';
// }
//
// // Utility for HSL conversion (simplified - for a real app, use a package)
// class ColorConverter {
//   static HSLColorData rgbToHsl(Color color) {
//     double r = color.red / 255.0;
//     double g = color.green / 255.0;
//     double b = color.blue / 255.0;
//
//     double max = [r, g, b].reduce((a, b) => a > b ? a : b);
//     double min = [r, g, b].reduce((a, b) => a < b ? a : b);
//
//     double h = 0.0;
//     double s = 0.0;
//     double l = (max + min) / 2.0;
//
//     if (max == min) {
//       h = s = 0.0; // achromatic
//     } else {
//       double d = max - min;
//       s = l > 0.5 ? d / (2.0 - max - min) : d / (max + min);
//
//       if (max == r) {
//         h = (g - b) / d + (g < b ? 6.0 : 0.0);
//       } else if (max == g) {
//         h = (b - r) / d + 2.0;
//       } else if (max == b) {
//         h = (r - g) / d + 4.0;
//       }
//       h /= 6.0;
//     }
//
//     return HSLColorData(
//       color: color,
//       h: h * 360.0, // Convert to 0-360 degrees
//       s: s,
//       l: l,
//     );
//   }
//
//   // Helper to parse hex string to Color object
//   static Color hexToColor(String hexString) {
//     String formattedHex = hexString.replaceAll("#", "");
//     if (formattedHex.length == 6) {
//       formattedHex = "FF$formattedHex"; // Add alpha if not present
//     }
//     // Handle potential errors in parsing
//     try {
//       return Color(int.parse(formattedHex, radix: 16));
//     } catch (e) {
//       print('Error parsing hex color $hexString: $e');
//       return Colors.red; // Return a default error color
//     }
//   }
// }
//
// class ColorGridDisplayScreen extends StatefulWidget {
//   final List<String> hexColors;
//
//   const ColorGridDisplayScreen({Key? key, required this.hexColors}) : super(key: key);
//
//   @override
//   State<ColorGridDisplayScreen> createState() => _ColorGridDisplayScreenState();
// }
//
// class _ColorGridDisplayScreenState extends State<ColorGridDisplayScreen> {
//   // Now, each cell will store a list of colors that fall into its range
//   List<List<List<HSLColorData>>> _sortedColorGrid = [];
//   final int _gridColumns = 20; // Increased columns for more granularity
//   final int _gridRows = 15;   // Increased rows for more granularity
//
//   @override
//   void initState() {
//     super.initState();
//     _sortAndArrangeColors();
//   }
//
//   void _sortAndArrangeColors() {
//     List<HSLColorData> hslColors = widget.hexColors
//         .map((hex) => ColorConverter.rgbToHsl(ColorConverter.hexToColor(hex)))
//         .toList();
//
//     // Sort by Hue primarily, then by Lightness, then by Saturation
//     // This sorting is important for the input to ensure consistent placement
//     hslColors.sort((a, b) {
//       int hueCompare = a.h.compareTo(b.h);
//       if (hueCompare != 0) {
//         return hueCompare;
//       }
//       int lightnessCompare = b.l.compareTo(a.l); // Descending lightness
//       if (lightnessCompare != 0) {
//         return lightnessCompare;
//       }
//       return b.s.compareTo(a.s); // Descending saturation as tie-breaker
//     });
//
//     // Initialize the grid with empty lists
//     _sortedColorGrid = List.generate(_gridRows, (_) => List.generate(_gridColumns, (_) => []));
//
//     // Distribute colors into the grid cells based on quantized HSL values
//     for (var hslColor in hslColors) {
//       // Quantize hue to column index
//       int colIndex = ((hslColor.h / 360.0) * _gridColumns).floor();
//       colIndex = colIndex.clamp(0, _gridColumns - 1); // Ensure index is within bounds
//
//       // Quantize lightness to row index
//       // Invert lightness for top-to-bottom: higher L (brighter) at lower row index
//       int rowIndex = ((1.0 - hslColor.l) * _gridRows).floor();
//       rowIndex = rowIndex.clamp(0, _gridRows - 1); // Ensure index is within bounds
//
//       _sortedColorGrid[rowIndex][colIndex].add(hslColor);
//     }
//
//     // After populating, you might want to sort the lists within each cell
//     // (e.g., if a cell has multiple colors, which one should be the "primary" displayed?)
//     // For now, we'll just take the first one that was added.
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sorted Colors (${widget.hexColors.length} colors)'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal, // Horizontal scrolling for columns
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical, // Vertical scrolling for rows
//             child: Column(
//               children: [
//                 for (int r = 0; r < _gridRows; r++)
//                   Row(
//                     children: [
//                       for (int c = 0; c < _gridColumns; c++)
//                         _buildColorCell(_sortedColorGrid[r][c]),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildColorCell(List<HSLColorData> hslColorDataList) {
//     // If the list is empty, it means "no color" for this specific quantized range
//     final HSLColorData? primaryColor = hslColorDataList.isNotEmpty ? hslColorDataList.first : null;
//     final int count = hslColorDataList.length;
//
//     return Container(
//       width: 40, // Reduced cell size to fit more on screen
//       height: 40, // Reduced cell size
//       margin: const EdgeInsets.all(1), // Reduced margin
//       decoration: BoxDecoration(
//         color: primaryColor != null ? primaryColor.color : Colors.grey[200], // Placeholder for "no color"
//         border: Border.all(color: Colors.black12),
//       ),
//       child: primaryColor == null
//           ? const Center(
//         child: RotatedBox(
//           quarterTurns: 3,
//           child: Text(
//             'No Color',
//             style: TextStyle(fontSize: 8, color: Colors.black54),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       )
//           : Tooltip(
//         message: '${primaryColor.color.toHexString()} (and ${count - 1} more)', // Show count of colors
//         child: Center(
//           child: Text(
//             count > 1 ? '+$count' : '', // Show count if more than one color maps here
//             style: TextStyle(
//               fontSize: 10,
//               fontWeight: FontWeight.bold,
//               color: primaryColor.l > 0.5 ? Colors.black : Colors.white,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Extension to get hex string from Color (for display/tooltip)
// extension ColorExtension on Color {
//   String toHexString({bool withAlpha = true}) {
//     String hex = value.toRadixString(16).toUpperCase();
//     if (!withAlpha) {
//       hex = hex.substring(2); // Remove alpha if not needed
//     }
//     return '#$hex';
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:math';
//
// void main() {
//   runApp(const MaterialApp(home: ColorPatchesDemo()));
// }
//
// class ColorPatchesDemo extends StatefulWidget {
//   const ColorPatchesDemo({super.key});
//
//   @override
//   State<ColorPatchesDemo> createState() => _ColorPatchesDemoState();
// }
//
// class _ColorPatchesDemoState extends State<ColorPatchesDemo> {
//   List<String> hexColors = [
//     '#000000', '#FFFFFF', '#FF0000', '#00FF00', '#0000FF',
//     '#FFA500', '#FFFF00', '#800080', '#FFC0CB', '#A52A2A',
//     '#2E8B57', '#90EE90', '#008000', '#008B8B', '#00CED1',
//     '#F5F5DC', '#4B0082', '#F08080', '#808080', '#D3D3D3'
//   ];
//
//   List<Color> sortedColors = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _processColors();
//   }
//
//   void _processColors() {
//     final Map<String, List<Color>> colorGroups = {};
//
//     for (var hex in hexColors) {
//       final color = Color(int.parse('0xFF${hex.substring(1)}'));
//       final group = _classifyColor(color);
//       colorGroups.putIfAbsent(group, () => []).add(color);
//     }
//
//     // Sort each group by brightness
//     for (var group in colorGroups.entries) {
//       group.value.sort((a, b) =>
//           HSVColor.fromColor(a).value.compareTo(HSVColor.fromColor(b).value));
//     }
//
//     // Patch display order
//     final patchOrder = [
//       'Black',
//       'Gray',
//       'White',
//       'Red',
//       'Orange',
//       'Yellow',
//       'Dark Green',
//       'Light Green',
//       'Teal',
//       'Blue',
//       'Purple',
//       'Pink',
//       'Brown',
//     ];
//
//     sortedColors = [];
//
//     for (var patch in patchOrder) {
//       if (colorGroups.containsKey(patch)) {
//         sortedColors.addAll(colorGroups[patch]!);
//       }
//     }
//
//     setState(() {});
//   }
//
//   String _classifyColor(Color color) {
//     final hsv = HSVColor.fromColor(color);
//     final h = hsv.hue;
//     final s = hsv.saturation;
//     final v = hsv.value;
//
//     if (s < 0.1 && v < 0.2) return 'Black';
//     if (s < 0.1 && v > 0.85) return 'White';
//     if (s < 0.1) return 'Gray';
//
//     if (h >= 0 && h < 30) return 'Red';
//     if (h >= 30 && h < 60) return 'Orange';
//     if (h >= 60 && h < 90) return 'Yellow';
//     if (h >= 90 && h < 150) return v < 0.5 ? 'Dark Green' : 'Light Green';
//     if (h >= 150 && h < 180) return 'Teal';
//     if (h >= 180 && h < 240) return 'Blue';
//     if (h >= 240 && h < 290) return 'Purple';
//     if (h >= 290 && h < 330) return 'Pink';
//     return 'Red'; // h >= 330 to 360
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Color Patches")),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: sortedColors.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 5,
//           mainAxisSpacing: 8,
//           crossAxisSpacing: 8,
//           childAspectRatio: 1,
//         ),
//         itemBuilder: (context, index) {
//           final color = sortedColors[index];
//           return Container(
//             color: color,
//             child: Center(
//               child: Text(
//                 '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase().substring(2)}',
//                 style: TextStyle(
//                   color: color.computeLuminance() > 0.5
//                       ? Colors.black
//                       : Colors.white,
//                   fontSize: 10,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(home: ColorGridScreen()));
}

class ColorGridScreen extends StatefulWidget {
  const ColorGridScreen({super.key});

  @override
  State<ColorGridScreen> createState() => _ColorGridScreenState();
}

class _ColorGridScreenState extends State<ColorGridScreen> {
  List<Color> savedColors = [];
  Set<String> selectedHexColors = {};

  @override
  void initState() {
    super.initState();
    loadFromPrefs();
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final colorHexList = prefs.getStringList('colors') ?? [];
    final selectedList = prefs.getStringList('selected') ?? [];

    setState(() {
      savedColors = colorHexList
          .map((hex) => Color(int.parse(hex, radix: 16)))
          .toList();
      selectedHexColors = selectedList.toSet();
    });
  }

  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final hexList = savedColors
        .map((c) => c.value.toRadixString(16).padLeft(8, '0'))
        .toList();
    prefs.setStringList('colors', hexList);
    prefs.setStringList('selected', selectedHexColors.toList());
  }

  void addColorDialog() {
    Color selectedColor = Colors.blue;
    TextEditingController hexController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
                hexController.text =
                '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
              },
            ),
            TextField(
              controller: hexController,
              decoration: const InputDecoration(labelText: "Hex Code"),
              onChanged: (value) {
                try {
                  value = value.replaceAll('#', '');
                  if (value.length == 6) value = 'FF$value'; // add alpha
                  selectedColor = Color(int.parse(value, radix: 16));
                } catch (_) {}
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                savedColors.add(selectedColor);
              });
              saveToPrefs();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void deleteColor(int index) {
    final color = savedColors[index];
    final hex = color.value.toRadixString(16).padLeft(8, '0');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Color'),
        content: const Text('Are you sure you want to delete this color?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                savedColors.removeAt(index);
                selectedHexColors.remove(hex);
              });
              saveToPrefs();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void printSelectedColors() {
    debugPrint('Selected Colors:');
    for (var hex in selectedHexColors) {
      debugPrint('#$hex');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Grid'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addColorDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: savedColors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final color = savedColors[index];
                final hex = color.value.toRadixString(16).padLeft(8, '0');
                final isSelected = selectedHexColors.contains(hex);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedHexColors.remove(hex);
                      } else {
                        selectedHexColors.add(hex);
                      }
                    });
                    saveToPrefs();
                  },
                  child: Card(
                    color: color,
                    shape: RoundedRectangleBorder(
                      side: isSelected
                          ? const BorderSide(color: Colors.black, width: 3)
                          : BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 4,
                          top: 4,
                          child: InkWell(
                            onTap: () => deleteColor(index),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(Icons.close,
                                  size: 16, color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton.icon(
              onPressed: printSelectedColors,
              icon: const Icon(Icons.print),
              label: const Text("Print Selected Colors"),
            ),
          ),
        ],
      ),
    );
  }
}
