import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/features/Chart/model/vietnam_regions.dart';
import 'package:my_app/features/Chart/views/map_viewer.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  String? _geoJsonRaw;
  String? _seriesData;

  Map<String, VietnamRegion>? _regionMap;
  VietnamRegion? _selectedRegion;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final geoJson =
        await rootBundle.loadString('assets/vietnam.geojson');

    final regionMap = buildProvinceToRegionMap();

    final indexMap = {
      for (int i = 0; i < vietnamRegions.length; i++)
        vietnamRegions[i].name: i + 1
    };

    final List<Map<String, dynamic>> data = [];
    for (final entry in regionMap.entries) {
      data.add({
        "name": entry.key,
        "value": indexMap[entry.value.name] ?? 0,
        "itemStyle": {"areaColor": entry.value.color},
      });
    }

    if (mounted) {
      setState(() {
        _geoJsonRaw = geoJson;
        _regionMap = regionMap;
        _seriesData = jsonEncode(data);
      });
    }
  }

  void _onProvinceTap(String province) {
    final region = _regionMap?[province];
    if (region != null) {
      setState(() => _selectedRegion = region);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_geoJsonRaw == null || _seriesData == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0D1B2A),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text(
          'Bản đồ Việt Nam theo vùng',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF467DCB),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0D1B2A),
      ),
      body: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              child: MapViewer(
                geoJsonRaw: _geoJsonRaw!,
                seriesData: _seriesData!,
                onProvinceTap: _onProvinceTap,
              ),
            ),
          ),
          _LegendBar(regions: vietnamRegions),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: _selectedRegion != null
                ? SizedBox(
                    height: 180,
                    child: _RegionInfoPanel(
                      region: _selectedRegion!,
                      onClose: () =>
                          setState(() => _selectedRegion = null),
                    ),
                  )
                : const SizedBox(
                    height: 48,
                    child: _HintBar(),
                  ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}



class _LegendBar extends StatelessWidget {
  final List<VietnamRegion> regions;
  const _LegendBar({required this.regions});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1B2A),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Wrap(
        spacing: 12,
        runSpacing: 6,
        children: regions.map((r) {
          final color = Color(int.parse(r.color.replaceFirst('#', '0xFF')));
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                r.shortName,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _HintBar extends StatelessWidget {
  const _HintBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111E2E),
      alignment: Alignment.center,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.touch_app_outlined, color: Colors.white38, size: 16),
          SizedBox(width: 8),
          Text(
            'Chạm vào tỉnh/thành để xem thông tin',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _RegionInfoPanel extends StatelessWidget {
  final VietnamRegion region;
  final VoidCallback onClose;

  const _RegionInfoPanel({required this.region, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(region.color.replaceFirst('#', '0xFF')));

    return Container(
      color: const Color(0xFF111E2E),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  region.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: onClose,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            region.description,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _StatChip(
                label: 'Dân số',
                value: '~${region.population}M',
                color: color,
              ),
              const SizedBox(width: 8),
              _StatChip(
                label: 'GDP',
                value: '${region.gdpShare}%',
                color: color,
              ),
              const SizedBox(width: 8),
              _StatChip(
                label: 'Tỉnh',
                value: '${region.provinces.length}',
                color: color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 9),
          ),
        ],
      ),
    );
  }
}