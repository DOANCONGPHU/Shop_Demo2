// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_echarts/flutter_echarts.dart';

// /// Màn hình debug tạm — chạy một lần để xem tên tỉnh trong GeoJSON
// /// Sau khi biết tên đúng thì xoá file này
// class ChartScreen extends StatefulWidget {
//   const ChartScreen({super.key});

//   @override
//   State<ChartScreen> createState() => _ChartScreenState();
// }

// class _ChartScreenState extends State<ChartScreen> {
//   String? _geoJsonRaw;
//   List<String> _provinceNames = [];

//   @override
//   void initState() {
//     super.initState();
//     _load();
//   }

//   Future<void> _load() async {
//     final raw = await rootBundle.loadString('assets/vietnam.geojson');
//     // Parse và lấy tất cả tên tỉnh từ GeoJSON
//     final json = jsonDecode(raw) as Map<String, dynamic>;
//     final features = json['features'] as List<dynamic>;
//     final names = features
//         .map((f) {
//           final props = f['properties'] as Map<String, dynamic>;
//           // Thử các key phổ biến
//           return props['name'] ??
//               props['Name'] ??
//               props['NAME'] ??
//               props['province'] ??
//               props['PROVINCE'] ??
//               props['ten_tinh'] ??
//               props['TEN_TINH'] ??
//               'UNKNOWN_KEY: ${props.keys.join(', ')}';
//         })
//         .map((e) => e.toString())
//         .toList()
//       ..sort();

//     setState(() {
//       _geoJsonRaw = raw;
//       _provinceNames = names;
//     });

//     // In ra console để copy
//     debugPrint('=== GEOJSON PROVINCE NAMES (${names.length}) ===');
//     for (final n in names) {
//       debugPrint('  "$n"');
//     }
//     debugPrint('=== END ===');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0D1B2A),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0D1B2A),
//         title: Text(
//           'Debug — ${_provinceNames.length} tỉnh/thành',
//           style: const TextStyle(color: Colors.white, fontSize: 14),
//         ),
//       ),
//       body: _provinceNames.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   color: const Color(0xFF1A2A3A),
//                   child: const Text(
//                     'Tên tỉnh trong GeoJSON — copy để map vào vietnam_regions.dart',
//                     style: TextStyle(color: Colors.amber, fontSize: 12),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: _provinceNames.length,
//                     itemBuilder: (_, i) => Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(
//                             color: Colors.white.withOpacity(0.06),
//                           ),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             '${i + 1}.',
//                             style: const TextStyle(
//                               color: Colors.white24,
//                               fontSize: 11,
//                               fontFamily: 'monospace',
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               _provinceNames[i],
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13,
//                                 fontFamily: 'monospace',
//                               ),
//                             ),
//                           ),
//                           // Copy button
//                           GestureDetector(
//                             onTap: () {
//                               // In ra để biết
//                               debugPrint('"${_provinceNames[i]}"');
//                             },
//                             child: const Icon(
//                               Icons.copy,
//                               color: Colors.white24,
//                               size: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }