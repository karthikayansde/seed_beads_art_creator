// import 'package:flutter/material.dart';
// import 'package:seed_beats/views/home_ui.dart';
// import 'package:http/http.dart' as http;
//
// Future<void> main() async {
//   runApp(const HomeUi());
// }

/// reduce quality with border----------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image/image.dart' as img;
// import 'package:flutter/services.dart' show rootBundle;
//
//
// void main() {
//   runApp(const MaterialApp(home: ImagePixelReducer()));
// }
//
// class ImagePixelReducer extends StatefulWidget {
//   const ImagePixelReducer({super.key});
//
//   @override
//   State<ImagePixelReducer> createState() => _ImagePixelReducerState();
// }
//
// class _ImagePixelReducerState extends State<ImagePixelReducer> {
//   img.Image? reducedImage;
//   double reducedWidth = 50;
//   int reducedHeight = 0;
//   late img.Image original;
//
//   @override
//   void initState() {
//     super.initState();
//     loadAndReduceImage();
//   }
//
//   Future<void> loadAndReduceImage() async {
//     final byteData = await rootBundle.load("assets/download.jpg");
//     final bytes = byteData.buffer.asUint8List();
//     original = img.decodeImage(bytes)!;
//     await reduceImage();
//   }
//
//   Future<void> reduceImage() async {
//     final aspectRatio = original.width / original.height;
//     reducedHeight = (reducedWidth / aspectRatio).round();
//     final resized = img.copyResize(original,
//         width: reducedWidth.round(), height: reducedHeight);
//     setState(() {
//       reducedImage = resized;
//     });
//   }
//
//   List<List<List<int>>> colorMatrix1 = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Seed Beads Art Creator')),
//       body: Padding(
//         padding: const EdgeInsets.all(4),
//         child: Column(
//           children: [
//             Text(
//               'Width: ${reducedWidth.round()} px, Height: $reducedHeight px',
//               style: const TextStyle(fontSize: 18),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (reducedImage != null) {
//                   List<List<List<int>>> list = [];
//                   for (int y = 0; y < reducedImage!.height; y++) {
//                     List<List<int>> listTemp = [];
//                     for (int x = 0; x < reducedImage!.width; x++) {
//                       final pixel = reducedImage!.getPixel(x, y);
//                       List<int> temp = [];
//                       temp.add(pixel.r.toInt());
//                       temp.add(pixel.g.toInt());
//                       temp.add(pixel.b.toInt());
//                       listTemp.add (temp);
//                     }
//                     list.add(listTemp);
//                   }
//                   colorMatrix1 = list;
//                   print(list);
//                 }
//                 setState(() {
//
//                 });
//               },
//               child: const Text('Print Pixels'),
//             ),
//             Slider(
//               min: 10,
//               max: 300,
//               divisions: 29,
//               value: reducedWidth,
//               label: reducedWidth.round().toString(),
//               onChanged: (value) async {
//                 setState(() {
//                   reducedWidth = value;
//                 });
//                 await reduceImage();
//               },
//             ),
//             const SizedBox(height: 10),
//             if (reducedImage != null)
//               Center(
//                 child: InteractiveViewer(
//                   child: CustomPaint(
//                     painter: PixelPainter(reducedImage!),
//                     size: Size(320, (320 * (reducedHeight / reducedWidth))),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
//
// class PixelPainter extends CustomPainter {
//   final img.Image image;
//
//   PixelPainter(this.image);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint();
//     final borderPaint = Paint()
//       ..style = PaintingStyle.stroke
//       ..color = Colors.black
//       ..strokeWidth = 0.2;
//
//     final pixelWidth = size.width / image.width;
//     final pixelHeight = size.height / image.height;
//
//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         final pixel = image.getPixel(x, y); // returns a Pixel object
//
//         final r = pixel.r;
//         final g = pixel.g;
//         final b = pixel.b;
//         final a = pixel.a;
//
//         paint.color = Color.fromARGB(a.toInt(), r.toInt(), g.toInt(), b.toInt());
//
//         final rect = Rect.fromLTWH(
//           x * pixelWidth,
//           y * pixelHeight,
//           pixelWidth,
//           pixelHeight,
//         );
//
//         canvas.drawRect(rect, paint);        // Fill pixel
//         canvas.drawRect(rect, borderPaint);  // Draw thin border
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
// //-----------------------------------------
// class ColorMatrixDisplay extends StatelessWidget {
//
//   final List<List<List<int>>> colorMatrix;
//   ColorMatrixDisplay({super.key, required this.colorMatrix});
//
//   // Example 2D matrix of colors (r, g, b)
//   @override
//   Widget build(BuildContext context) {
//     return  Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: colorMatrix.map((row) {
//           return Row(
//             mainAxisSize: MainAxisSize.min,
//             children: row.map((rgb) {
//               final color = Color.fromARGB(255, rgb[0], rgb[1], rgb[2]);
//               return
//                 CircleAvatar(
//                   radius: 6,
//                   backgroundColor: color,
//                   child: Image.asset("assets/seed bead-modified.png"),
//                 );
//             }).toList(),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

/// creating image and downloading it---------------------------------------------------------------

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


//------------------------------------------------old versions--------------------------------------------------

// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/foundation.dart';
//
// import 'dart:html' as html;
//
//
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
//       title: '2D Circle Grid Download',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const SmoothCircleGridScreen(),
//     );
//   }
// }
//
// class SmoothCircleGridScreen extends StatefulWidget {
//   const SmoothCircleGridScreen({super.key});
//
//   @override
//   _SmoothCircleGridScreenState createState() => _SmoothCircleGridScreenState();
// }
//
// class _SmoothCircleGridScreenState extends State<SmoothCircleGridScreen> {
//   final GlobalKey _gridKey = GlobalKey();
//
//   final List<List<Color>> _circleColorsGrid = [
//     [Colors.red, Colors.green, Colors.blue, Colors.purple],
//     [Colors.orange, Colors.teal, Colors.pink, Colors.brown],
//     [Colors.amber, Colors.cyan, Colors.indigo, Colors.lime],
//     [Colors.red, Colors.green, Colors.blue, Colors.purple],
//   ];
//
//   static const double _circleTileSize = 10.0;
//
//   Future<void> _captureAndDownloadImage() async {
//     try {
//       RenderRepaintBoundary? boundary =
//       _gridKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
//
//       if (boundary == null) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Could not find render object.')),
//           );
//         }
//         return;
//       }
//
//       ui.Image image = await boundary.toImage(pixelRatio: 2.0);
//
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       if (byteData == null) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Failed to convert image to bytes.')),
//           );
//         }
//         return;
//       }
//
//       Uint8List pngBytes = byteData.buffer.asUint8List();
//
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
//           SnackBar(content: Text('Error capturing or downloading image: $e')),
//         );
//       }
//       print('Error capturing or downloading image: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('2D Circle Grid (No Padding)'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // RepaintBoundary captures the visual output of its child
//             RepaintBoundary(
//               key: _gridKey,
//               // The white background is moved here to ensure the captured image has a background
//               // If you want a transparent background, change this to Colors.transparent
//               child: Container(
//                 color: Colors.white,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   // We use MainAxisSize.min to ensure the Column only takes up as much space as its children
//                   mainAxisSize: MainAxisSize.min,
//                   children: _circleColorsGrid.map((rowColors) {
//                     return Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: rowColors.map((color) {
//                         // The Container no longer has margin or decoration (border)
//                         return Container(
//                           width: _circleTileSize,
//                           height: _circleTileSize,
//                           child: CustomPaint(
//                             painter: CircleRatioPainter(outerCircleColor: color),
//                           ),
//                         );
//                       }).toList(),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             // The SizedBox for spacing is removed
//             ElevatedButton(
//               onPressed: _captureAndDownloadImage,
//               child: const Text('Download Grid as Image (Web Only)'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Our CustomPainter class remains exactly the same
// class CircleRatioPainter extends CustomPainter {
//   final Color outerCircleColor;
//
//   CircleRatioPainter({required this.outerCircleColor});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Offset center = Offset(size.width / 2, size.height / 2);
//     final double maxRadius = size.shortestSide / 2;
//
//     final double outerCircleRadius = maxRadius;
//     final Paint outerPaint = Paint()
//       ..color = outerCircleColor
//       ..style = PaintingStyle.fill;
//     canvas.drawCircle(center, outerCircleRadius, outerPaint);
//
//     final double innerCircleRadius = outerCircleRadius / 3;
//     final Paint innerPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//     canvas.drawCircle(center, innerCircleRadius, innerPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CircleRatioPainter oldDelegate) {
//     return oldDelegate.outerCircleColor != outerCircleColor;
//   }
// }