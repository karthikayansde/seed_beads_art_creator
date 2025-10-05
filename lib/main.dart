import 'package:flutter/material.dart';
import 'package:seed_beats/views/home_ui.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  runApp(MaterialApp(home: const HomeUi()));
}

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
// import 'dart:math' as math;
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
//       title: 'Color Circle',
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
//           .where((s) => s.isNotEmpty && s.startsWith('#') && (s.length == 7 || s.length == 9))
//           .toList();
//     });
//
//     if (_inputHexColors.isNotEmpty) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ColorCircleDisplayScreen(hexColors: _inputHexColors),
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
//                 hintText: 'Enter colors to see them on a color wheel!',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 10,
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _processInput,
//               child: const Text('Show Color Circle'),
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
// class HSLColorData {
//   final Color color;
//   final double h;
//   final double s;
//   final double l;
//   final String hexString;
//   final int index;
//
//   HSLColorData({
//     required this.color,
//     required this.h,
//     required this.s,
//     required this.l,
//     required this.hexString,
//     required this.index,
//   });
// }
//
// class ColorConverter {
//   static HSLColorData rgbToHsl(Color color, String hexString, int index) {
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
//       h = s = 0.0;
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
//       h: h * 360.0,
//       s: s,
//       l: l,
//       hexString: hexString,
//       index: index,
//     );
//   }
//
//   static Color hexToColor(String hexString) {
//     String formattedHex = hexString.replaceAll("#", "");
//     if (formattedHex.length == 6) {
//       formattedHex = "FF$formattedHex";
//     }
//     try {
//       return Color(int.parse(formattedHex, radix: 16));
//     } catch (e) {
//       print('Error parsing hex color $hexString: $e');
//       return Colors.red;
//     }
//   }
// }
//
// class ColorCircleDisplayScreen extends StatefulWidget {
//   final List<String> hexColors;
//
//   const ColorCircleDisplayScreen({Key? key, required this.hexColors}) : super(key: key);
//
//   @override
//   State<ColorCircleDisplayScreen> createState() => _ColorCircleDisplayScreenState();
// }
//
// class _ColorCircleDisplayScreenState extends State<ColorCircleDisplayScreen> {
//   List<HSLColorData> _colors = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadColors();
//   }
//
//   void _loadColors() {
//     _colors = [];
//     for (int i = 0; i < widget.hexColors.length; i++) {
//       final hex = widget.hexColors[i];
//       _colors.add(ColorConverter.rgbToHsl(ColorConverter.hexToColor(hex), hex, i + 1));
//     }
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Color Wheel (${widget.hexColors.length} colors)'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Color Wheel
//             Container(
//               padding: const EdgeInsets.all(20),
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   final size = math.min(constraints.maxWidth, 650.0);
//                   return Center(
//                     child: SizedBox(
//                       width: size,
//                       height: size,
//                       child: CustomPaint(
//                         painter: ColorCirclePainter(colors: _colors),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             const Divider(thickness: 2),
//             // Color List
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Color List',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 16),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: _colors.length,
//                     itemBuilder: (context, index) {
//                       final colorData = _colors[index];
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 8),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             backgroundColor: colorData.color,
//                             child: Text(
//                               '${colorData.index}',
//                               style: TextStyle(
//                                 color: colorData.l > 0.5 ? Colors.black : Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           title: Text(
//                             colorData.hexString,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text(
//                             'H: ${colorData.h.toStringAsFixed(0)}° S: ${(colorData.s * 100).toStringAsFixed(0)}% L: ${(colorData.l * 100).toStringAsFixed(0)}%',
//                           ),
//                           trailing: Container(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: colorData.color,
//                               border: Border.all(color: Colors.black26, width: 2),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ColorCirclePainter extends CustomPainter {
//   final List<HSLColorData> colors;
//
//   ColorCirclePainter({required this.colors});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final maxRadius = math.min(size.width, size.height) / 2;
//
//     // Draw color wheel gradient background
//     final rect = Rect.fromCircle(center: center, radius: maxRadius);
//
//     // Create radial gradient for saturation (from white center to saturated edge)
//     final saturationGradient = Paint()
//       ..shader = RadialGradient(
//         colors: [Colors.white, Colors.white.withOpacity(0)],
//         stops: [0.0, 1.0],
//       ).createShader(rect);
//
//     // Draw hue wheel segments
//     const segmentCount = 360;
//     for (int i = 0; i < segmentCount; i++) {
//       final startAngle = (i - 90) * math.pi / 180;
//       final sweepAngle = (1) * math.pi / 180;
//       final hue = i.toDouble();
//
//       final color = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
//       final paint = Paint()
//         ..color = color
//         ..style = PaintingStyle.fill;
//
//       final path = Path()
//         ..moveTo(center.dx, center.dy)
//         ..arcTo(rect, startAngle, sweepAngle, false)
//         ..close();
//
//       canvas.drawPath(path, paint);
//     }
//
//     // Draw saturation gradient overlay (white in center fading out)
//     canvas.drawCircle(center, maxRadius, saturationGradient);
//
//     // Draw border
//     final borderPaint = Paint()
//       ..color = Colors.black26
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3;
//     canvas.drawCircle(center, maxRadius, borderPaint);
//
//     const circleSize = 14.0;
//     const minSpacing = circleSize * 2.5;
//
//     List<Offset> placedPositions = [];
//
//     // Sort colors by hue, then saturation
//     List<HSLColorData> sortedColors = List.from(colors);
//     sortedColors.sort((a, b) {
//       int hueCompare = a.h.compareTo(b.h);
//       if (hueCompare != 0) return hueCompare;
//       return a.s.compareTo(b.s);
//     });
//
//     // Place each color without overlap
//     for (var colorData in sortedColors) {
//       Offset? finalPosition;
//
//       double baseRadius = colorData.s * (maxRadius - 40);
//       double angleRad = (colorData.h - 90) * math.pi / 180;
//
//       for (int radiusAttempt = 0; radiusAttempt < 10; radiusAttempt++) {
//         double testRadius = baseRadius + (radiusAttempt * 25);
//
//         if (testRadius > maxRadius - 30) continue;
//
//         for (int angleAttempt = 0; angleAttempt < 12; angleAttempt++) {
//           double angleOffset = (angleAttempt * 5) * math.pi / 180;
//           double testAngle = angleRad + (angleAttempt % 2 == 0 ? angleOffset : -angleOffset);
//
//           double x = center.dx + testRadius * math.cos(testAngle);
//           double y = center.dy + testRadius * math.sin(testAngle);
//           Offset testPosition = Offset(x, y);
//
//           bool hasOverlap = false;
//           for (var placedPos in placedPositions) {
//             double distance = math.sqrt(
//                 math.pow(testPosition.dx - placedPos.dx, 2) +
//                     math.pow(testPosition.dy - placedPos.dy, 2)
//             );
//             if (distance < minSpacing) {
//               hasOverlap = true;
//               break;
//             }
//           }
//
//           if (!hasOverlap) {
//             finalPosition = testPosition;
//             break;
//           }
//         }
//
//         if (finalPosition != null) break;
//       }
//
//       if (finalPosition == null) {
//         double x = center.dx + baseRadius * math.cos(angleRad);
//         double y = center.dy + baseRadius * math.sin(angleRad);
//         finalPosition = Offset(x, y);
//       }
//
//       placedPositions.add(finalPosition);
//
//       // Draw color circle (the actual color)
//       final colorPaint = Paint()
//         ..color = colorData.color
//         ..style = PaintingStyle.fill;
//       canvas.drawCircle(finalPosition, circleSize, colorPaint);
//
//       // Draw black border around color
//       final circleBorderPaint = Paint()
//         ..color = Colors.black87
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2;
//       canvas.drawCircle(finalPosition, circleSize, circleBorderPaint);
//
//       // Draw number on top with white background circle
//       final numberBgSize = circleSize * 0.6;
//       final numberBgPaint = Paint()
//         ..color = Colors.white
//         ..style = PaintingStyle.fill;
//       canvas.drawCircle(finalPosition, numberBgSize, numberBgPaint);
//
//       // Draw number in black
//       final textPainter = TextPainter(
//         text: TextSpan(
//           text: '${colorData.index}',
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 9,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         textDirection: TextDirection.ltr,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(
//           finalPosition.dx - textPainter.width / 2,
//           finalPosition.dy - textPainter.height / 2,
//         ),
//       );
//     }
//   }
//
//   @override
//   bool shouldRepaint(ColorCirclePainter oldDelegate) {
//     return oldDelegate.colors != colors;
//   }
// }
// import 'package:flutter/material.dart';
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
//       title: 'Color Grid',
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
//           .where((s) => s.isNotEmpty && s.startsWith('#') && (s.length == 7 || s.length == 9))
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
//                 hintText: 'Enter colors to arrange them!',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 10,
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _processInput,
//               child: const Text('Show Colors'),
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
// class HSLColorData {
//   final Color color;
//   final double h;
//   final double s;
//   final double l;
//   final String hexString;
//
//   HSLColorData({
//     required this.color,
//     required this.h,
//     required this.s,
//     required this.l,
//     required this.hexString,
//   });
// }
//
// class ColorConverter {
//   static HSLColorData rgbToHsl(Color color, String hexString) {
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
//       h = s = 0.0;
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
//       h: h * 360.0,
//       s: s,
//       l: l,
//       hexString: hexString,
//     );
//   }
//
//   static Color hexToColor(String hexString) {
//     String formattedHex = hexString.replaceAll("#", "");
//     if (formattedHex.length == 6) {
//       formattedHex = "FF$formattedHex";
//     }
//     try {
//       return Color(int.parse(formattedHex, radix: 16));
//     } catch (e) {
//       print('Error parsing hex color $hexString: $e');
//       return Colors.red;
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
//   List<HSLColorData> _colors = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadColors();
//   }
//
//   void _loadColors() {
//     _colors = [];
//     for (int i = 0; i < widget.hexColors.length; i++) {
//       final hex = widget.hexColors[i];
//       _colors.add(ColorConverter.rgbToHsl(ColorConverter.hexToColor(hex), hex));
//     }
//     // Sort by hue, then lightness, then saturation
//     _colors.sort((a, b) {
//       int hueCompare = a.h.compareTo(b.h);
//       if (hueCompare != 0) return hueCompare;
//       int lightnessCompare = b.l.compareTo(a.l);
//       if (lightnessCompare != 0) return lightnessCompare;
//       return b.s.compareTo(a.s);
//     });
//     setState(() {});
//   }
//
//   void _onReorder(int oldIndex, int newIndex) {
//     setState(() {
//       if (newIndex > oldIndex) {
//         newIndex -= 1;
//       }
//       final item = _colors.removeAt(oldIndex);
//       _colors.insert(newIndex, item);
//     });
//   }
//
//   void _printColors() {
//     final hashCodes = _colors.map((c) => c.hexString).join(', ');
//     print('Rearranged colors: $hashCodes');
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Rearranged Color Codes'),
//         content: SingleChildScrollView(
//           child: SelectableText(
//             hashCodes,
//             style: const TextStyle(fontSize: 12),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showColorDialog(HSLColorData colorData) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Color Details'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 color: colorData.color,
//                 border: Border.all(color: Colors.black26, width: 2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             const SizedBox(height: 16),
//             SelectableText(
//               colorData.hexString,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text('Hue: ${colorData.h.toStringAsFixed(1)}°'),
//             Text('Saturation: ${(colorData.s * 100).toStringAsFixed(1)}%'),
//             Text('Lightness: ${(colorData.l * 100).toStringAsFixed(1)}%'),
//             Text('RGB: ${colorData.color.red}, ${colorData.color.green}, ${colorData.color.blue}'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Color Grid (${widget.hexColors.length} colors)'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.print),
//             onPressed: _printColors,
//             tooltip: 'Print hash codes',
//           ),
//           IconButton(
//             icon: const Icon(Icons.sort),
//             onPressed: _loadColors,
//             tooltip: 'Re-sort colors',
//           ),
//         ],
//       ),
//       body: ReorderableListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.all(16),
//         itemCount: _colors.length,
//         onReorder: _onReorder,
//         itemBuilder: (context, index) {
//           final colorData = _colors[index];
//           return GestureDetector(
//             key: ValueKey('${colorData.hexString}_$index'),
//             onTap: () => _showColorDialog(colorData),
//             child: Container(
//               width: 80,
//               margin: const EdgeInsets.symmetric(horizontal: 2),
//               decoration: BoxDecoration(
//                 color: colorData.color,
//                 border: Border.all(color: Colors.black26, width: 1),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     colorData.hexString.substring(0, 7),
//                     style: TextStyle(
//                       color: colorData.l > 0.5 ? Colors.black : Colors.white,
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                       shadows: [
//                         Shadow(
//                           color: colorData.l > 0.5 ? Colors.white : Colors.black,
//                           blurRadius: 2,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Icon(
//                     Icons.drag_handle,
//                     size: 20,
//                     color: colorData.l > 0.5 ? Colors.black38 : Colors.white38,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }