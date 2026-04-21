// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_echarts/flutter_echarts.dart';
// import 'package:my_app/features/Chart/model/vietnam_regions.dart';

// class ChartScreensdfsd extends StatefulWidget {
//   const ChartScreensdfsd({super.key});

//   @override
//   State<ChartScreensdfsd> createState() => _ChartScreensdfsdState();
// }

// class _ChartScreensdfsdState extends State<ChartScreensdfsd> {
//   String? _geoJsonRaw;
//   VietnamRegion? _selectedRegion;
//   bool _showLegend = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     final raw = await rootBundle.loadString('assets/vietnam.geojson');
//     setState(() => _geoJsonRaw = raw);
//   }

//   // ── KEY FIX: mỗi tỉnh có itemStyle.areaColor riêng, KHÔNG dùng visualMap ──
//   String _buildSeriesData() {
//     final regionMap = buildProvinceToRegionMap();
//     final buffer = StringBuffer('[');
//     bool first = true;
//     for (final entry in regionMap.entries) {
//       final region = entry.value;
//       final idx = vietnamRegions.indexOf(region) + 1;
//       if (!first) buffer.write(',\n');
//       first = false;
//       buffer.write('''
// {
//   name: "${entry.key}",
//   value: $idx,
//   itemStyle: {
//     areaColor: "${region.color}",
//     borderColor: "${region.borderColor}",
//     borderWidth: 0.8
//   }
// }''');
//     }
//     buffer.write(']');
//     return buffer.toString();
//   }

//   // Build JS array tên vùng + màu để dùng trong tooltip
//   String _buildRegionInfoJS() {
//     final names = vietnamRegions.map((r) => '"${r.name}"').join(',');
//     final colors = vietnamRegions.map((r) => '"${r.color}"').join(',');
//     return 'const _rNames=[$names]; const _rColors=[$colors];';
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_geoJsonRaw == null) {
//       return const Scaffold(
//         backgroundColor: Color(0xFF0D1B2A),
//         body: Center(child: CircularProgressIndicator(color: Colors.white54)),
//       );
//     }

//     final escapedGeoJson = jsonEncode(_geoJsonRaw);
//     final seriesData = _buildSeriesData();
//     final regionInfoJS = _buildRegionInfoJS();

//     return Scaffold(
//       backgroundColor: const Color(0xFF0D1B2A),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0D1B2A),
//         elevation: 0,
//         title: const Text(
//           'Bản đồ Việt Nam',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               _showLegend ? Icons.layers : Icons.layers_outlined,
//               color: Colors.white70,
//             ),
//             onPressed: () => setState(() => _showLegend = !_showLegend),
//             tooltip: 'Hiện/ẩn chú thích vùng',
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // ── Bản đồ chính ──
//           Expanded(
//             flex: 3,
//             child: Echarts(
//               extraScript:
//                   '''
//                 $regionInfoJS

//                 // 1. Load GeoJSON
//                 try {
//                   const geoJson = JSON.parse($escapedGeoJson);
//                   echarts.registerMap('vietnam', geoJson);
//                 } catch(e) {
//                   console.error('GeoJSON error:', e);
//                 }

//                 // 2. Bắt sự kiện click → gửi về Flutter
//                 chart.on('click', function(params) {
//                   if (params.componentType === 'series' && params.name) {
//                     app.postMessage(JSON.stringify({
//                       type: 'mapClick',
//                       name: params.name,
//                       value: params.value
//                     }));
//                   }
//                 });
//               ''',
//               option:
//                   '''
//               {
//                 backgroundColor: '#0D1B2A',

//                 tooltip: {
//                   trigger: 'item',
//                   backgroundColor: 'rgba(8,16,28,0.95)',
//                   borderColor: 'rgba(255,255,255,0.12)',
//                   borderWidth: 1,
//                   padding: [10,14],
//                   textStyle: { color: '#eee', fontSize: 13 },
//                   formatter: function(params) {
//                     if (!params.name) return '';
//                     const v = params.value;
//                     const idx = (v >= 1 && v <= 6) ? v - 1 : -1;
//                     const rName = idx >= 0 ? _rNames[idx] : 'Không xác định';
//                     const rColor = idx >= 0 ? _rColors[idx] : '#888';
//                     return '<div>'
//                       + '<div style="font-weight:700;font-size:14px;margin-bottom:6px;color:#fff">'
//                       + params.name + '</div>'
//                       + '<div style="display:flex;align-items:center;gap:7px">'
//                       + '<span style="width:9px;height:9px;border-radius:2px;background:'
//                       + rColor + ';flex-shrink:0;display:inline-block"></span>'
//                       + '<span style="color:rgba(255,255,255,0.6);font-size:12px">'
//                       + rName + '</span>'
//                       + '</div></div>';
//                   }
//                 },

//                 series: [{
//                   type: 'map',
//                   map: 'vietnam',
//                   roam: true,
//                   scaleLimit: { min: 0.8, max: 10 },
//                   zoom: 1.15,
//                   selectedMode: 'single',

//                   label: {
//                     show: false,
//                     color: 'rgba(255,255,255,0.85)',
//                     fontSize: 8,
//                     fontWeight: 'normal'
//                   },

//                   itemStyle: {
//                     borderColor: 'rgba(255,255,255,0.2)',
//                     borderWidth: 0.5
//                   },

//                   emphasis: {
//                     label: {
//                       show: true,
//                       color: '#fff',
//                       fontSize: 10,
//                       fontWeight: 'bold'
//                     },
//                     itemStyle: {
//                       areaColor: '#FFD700',
//                       borderColor: '#fff',
//                       borderWidth: 1.5,
//                       shadowBlur: 16,
//                       shadowColor: 'rgba(255,215,0,0.5)'
//                     }
//                   },

//                   select: {
//                     label: { show: true, color: '#fff', fontSize: 10 },
//                     itemStyle: {
//                       areaColor: '#FFD700',
//                       borderColor: '#fff',
//                       borderWidth: 2,
//                       shadowBlur: 20,
//                       shadowColor: 'rgba(255,215,0,0.6)'
//                     }
//                   },

//                   data: $seriesData
//                 }]
//               }
//               ''',
//               onMessage: (String message) {
//                 try {
//                   final data = jsonDecode(message) as Map<String, dynamic>;
//                   if (data['type'] == 'mapClick') {
//                     final name = data['name'] as String?;
//                     if (name != null) {
//                       final regionMap = buildProvinceToRegionMap();
//                       setState(() => _selectedRegion = regionMap[name]);
//                     }
//                   }
//                 } catch (_) {}
//               },
//             ),
//           ),

//           // ── Legend Flutter thuần (không phụ thuộc ECharts visualMap) ──
//           if (_showLegend) _LegendBar(regions: vietnamRegions),

//           // ── Panel thông tin khi click tỉnh ──
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             height: _selectedRegion != null ? 190 : 48,
//             child: _selectedRegion != null
//                 ? _RegionInfoPanel(
//                     region: _selectedRegion!,
//                     onClose: () => setState(() => _selectedRegion = null),
//                   )
//                 : const _HintBar(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Legend hiển thị 6 vùng bằng Flutter widget ──────────────────────────────
// class _LegendBar extends StatelessWidget {
//   final List<VietnamRegion> regions;
//   const _LegendBar({required this.regions});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF0D1B2A),
//       padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
//       child: Wrap(
//         spacing: 10,
//         runSpacing: 6,
//         children: regions.map((r) {
//           final color = Color(int.parse(r.color.replaceFirst('#', '0xFF')));
//           return Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 10,
//                 height: 10,
//                 decoration: BoxDecoration(
//                   color: color,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(width: 4),
//               Text(
//                 r.shortName,
//                 style: const TextStyle(color: Colors.white60, fontSize: 10),
//               ),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// // ── Hint bar ─────────────────────────────────────────────────────────────────
// class _HintBar extends StatelessWidget {
//   const _HintBar();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF111E2E),
//       alignment: Alignment.center,
//       child: const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.touch_app_outlined, color: Colors.white24, size: 14),
//           SizedBox(width: 6),
//           Text(
//             'Chạm vào tỉnh/thành để xem thông tin',
//             style: TextStyle(color: Colors.white38, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Panel chi tiết vùng ──────────────────────────────────────────────────────
// class _RegionInfoPanel extends StatelessWidget {
//   final VietnamRegion region;
//   final VoidCallback onClose;
//   const _RegionInfoPanel({required this.region, required this.onClose});

//   @override
//   Widget build(BuildContext context) {
//     final color = Color(int.parse(region.color.replaceFirst('#', '0xFF')));

//     return Container(
//       color: const Color(0xFF111E2E),
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Row(
//             children: [
//               Container(
//                 width: 12,
//                 height: 12,
//                 decoration: BoxDecoration(
//                   color: color,
//                   borderRadius: BorderRadius.circular(3),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   region.name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: onClose,
//                 child: const Icon(Icons.close, color: Colors.white38, size: 18),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           Text(
//             region.description,
//             style: const TextStyle(color: Colors.white38, fontSize: 11),
//           ),
//           const SizedBox(height: 10),
//           // Stats
//           Row(
//             children: [
//               _StatChip(
//                 label: 'Dân số',
//                 value: '~${region.population}M',
//                 color: color,
//               ),
//               const SizedBox(width: 8),
//               _StatChip(
//                 label: 'GDP share',
//                 value: '${region.gdpShare}%',
//                 color: color,
//               ),
//               const SizedBox(width: 8),
//               _StatChip(
//                 label: 'Số tỉnh/TP',
//                 value: '${region.provinces.length}',
//                 color: color,
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           // Tỉnh
//           SizedBox(
//             height: 22,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: region.provinces.length,
//               separatorBuilder: (_, __) => const SizedBox(width: 6),
//               itemBuilder: (_, i) => Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.13),
//                   borderRadius: BorderRadius.circular(11),
//                   border: Border.all(
//                     color: color.withOpacity(0.35),
//                     width: 0.5,
//                   ),
//                 ),
//                 child: Text(
//                   region.provinces[i],
//                   style: TextStyle(color: color, fontSize: 10),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StatChip extends StatelessWidget {
//   final String label;
//   final String value;
//   final Color color;
//   const _StatChip({
//     required this.label,
//     required this.value,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: color.withOpacity(0.3), width: 0.5),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             value,
//             style: TextStyle(
//               color: color,
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(height: 1),
//           Text(
//             label,
//             style: const TextStyle(color: Colors.white38, fontSize: 9),
//           ),
//         ],
//       ),
//     );
//   }
// }

// extension IterableIndexed<T> on Iterable<T> {
//   Iterable<R> mapIndexed<R>(R Function(int index, T item) f) sync* {
//     var i = 0;
//     for (final item in this) {
//       yield f(i++, item);
//     }
//   }
// }
