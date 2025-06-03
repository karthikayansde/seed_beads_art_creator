// import 'package:flutter/material.dart';
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
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             CircleAvatar(
//               radius: 6,
//               backgroundColor: Colors.red,
//               child: Image.asset("assets/seed bead-modified.png"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//---------------------------only image reduce quality--------------------------------------------------------------
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image/image.dart' as img;
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
//   Uint8List? reducedImageBytes;
//   double reducedWidth = 50;
//   int reducedHeight = 0;  // store height for display
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
//     // Maintain aspect ratio
//     final aspectRatio = original.width / original.height;
//     reducedHeight = (reducedWidth / aspectRatio).round();
//
//     final resized = img.copyResize(original, width: reducedWidth.round(), height: reducedHeight);
//     final result = Uint8List.fromList(img.encodePng(resized));
//
//     setState(() {
//       reducedImageBytes = result;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Pixel Reducer')),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Width: ${reducedWidth.round()} px, Height: $reducedHeight px', style: const TextStyle(fontSize: 18)),
//             Slider(
//               min: 10,
//               max: 500,
//               divisions: 49,
//               value: reducedWidth,
//               label: reducedWidth.round().toString(),
//               onChanged: (value) async {
//                 setState(() {
//                   reducedWidth = value;
//                 });
//                 await reduceImage();
//               },
//             ),
//             const SizedBox(height: 20),
//             if (reducedImageBytes != null)
//               Image.memory(
//                 reducedImageBytes!,
//                 width: 500,
//                 fit: BoxFit.contain,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//------------------------------------image reduce quality with border----------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(const MaterialApp(home: ImagePixelReducer()));
}

class ImagePixelReducer extends StatefulWidget {
  const ImagePixelReducer({super.key});

  @override
  State<ImagePixelReducer> createState() => _ImagePixelReducerState();
}

class _ImagePixelReducerState extends State<ImagePixelReducer> {
  img.Image? reducedImage;
  double reducedWidth = 50;
  int reducedHeight = 0;
  late img.Image original;

  @override
  void initState() {
    super.initState();
    loadAndReduceImage();
  }

  Future<void> loadAndReduceImage() async {
    final byteData = await rootBundle.load("assets/download.jpg");
    final bytes = byteData.buffer.asUint8List();
    original = img.decodeImage(bytes)!;
    await reduceImage();
  }

  Future<void> reduceImage() async {
    final aspectRatio = original.width / original.height;
    reducedHeight = (reducedWidth / aspectRatio).round();
    final resized = img.copyResize(original,
        width: reducedWidth.round(), height: reducedHeight);
    setState(() {
      reducedImage = resized;
    });
  }

  List<List<List<int>>> colorMatrix1 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pixel Reducer')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Width: ${reducedWidth.round()} px, Height: $reducedHeight px',
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                if (reducedImage != null) {
                  List<List<List<int>>> list = [];
                  for (int y = 0; y < reducedImage!.height; y++) {
                    List<List<int>> listTemp = [];
                    for (int x = 0; x < reducedImage!.width; x++) {
                      final pixel = reducedImage!.getPixel(x, y);
                      List<int> temp = [];
                      temp.add(pixel.r.toInt());
                      temp.add(pixel.g.toInt());
                      temp.add(pixel.b.toInt());
                      listTemp.add (temp);
                    }
                    list.add(listTemp);
                  }
                  colorMatrix1 = list;
                  print(list);
                }
                setState(() {

                });
              },
              child: const Text('Print Pixels'),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.vertical,
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: ColorMatrixDisplay(colorMatrix: colorMatrix1),
            //     ),
            //   ),
            // ),
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
              Expanded(
                child: Center(
                  child: CustomPaint(
                    painter: PixelPainter(reducedImage!),
                    size: Size(500, (500 * (reducedHeight / reducedWidth))),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

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

        final r = pixel.r;
        final g = pixel.g;
        final b = pixel.b;
        final a = pixel.a;

        paint.color = Color.fromARGB(a.toInt(), r.toInt(), g.toInt(), b.toInt());

        final rect = Rect.fromLTWH(
          x * pixelWidth,
          y * pixelHeight,
          pixelWidth,
          pixelHeight,
        );

        canvas.drawRect(rect, paint);        // Fill pixel
        canvas.drawRect(rect, borderPaint);  // Draw thin border
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
//------------------------------------------------------------------------------------------------------------------------------
class ColorMatrixDisplay extends StatelessWidget {

  final List<List<List<int>>> colorMatrix;
  ColorMatrixDisplay({super.key, required this.colorMatrix});

  // Example 2D matrix of colors (r, g, b)
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: colorMatrix.map((row) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: row.map((rgb) {
              final color = Color.fromARGB(255, rgb[0], rgb[1], rgb[2]);
              return
                CircleAvatar(
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
