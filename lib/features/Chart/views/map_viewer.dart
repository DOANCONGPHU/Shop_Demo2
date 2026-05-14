import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class MapViewer extends StatefulWidget {
  final String geoJsonRaw;
  final String seriesData;
  final void Function(String) onProvinceTap;

  const MapViewer({
    super.key,
    required this.geoJsonRaw,
    required this.seriesData,
    required this.onProvinceTap,
  });

  @override
  State<MapViewer> createState() => _MapViewerState();
}

class _MapViewerState extends State<MapViewer>
    with AutomaticKeepAliveClientMixin {
  late final String _option;
  late final String _extraScript;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initChart();
  }

  void _initChart() {
    _option = '''
{
  backgroundColor: '#2A3849',
  animation: false,
  tooltip: {
    trigger: 'item',
    formatter: '{b}',
    confine: true
  },
  series: [{
    type: 'map',
    map: 'vietnam',
    nameProperty: 'ten_tinh',

    roam: false,         
    zoom: 1.15,          

    label: { show: false },

    itemStyle: {
      borderColor: 'rgba(255,255,255,0.25)',
      borderWidth: 0.5,
      areaColor: '#1e2937'
    },

    emphasis: {
      label: { show: false },
      itemStyle: { areaColor: '#fbbf24' }
    },

    progressive: 2000,
    progressiveThreshold: 3000,

    data: ${widget.seriesData}
  }]
}
''';

    _extraScript = '''
(function () {

  if (!window.__VN_MAP_REGISTERED__) {
    try {
      const geoJson = JSON.parse(${jsonEncode(widget.geoJsonRaw)});
      echarts.registerMap('vietnam', geoJson);
      window.__VN_MAP_REGISTERED__ = true;
    } catch (e) {
      console.error(e);
    }
  }

  if (typeof chart !== 'undefined' && !window.__VN_CLICK_BOUND__) {
    chart.on('click', function (params) {
      if (params.name) {
        Messager.postMessage(params.name);
      }
    });
    window.__VN_CLICK_BOUND__ = true;
  }


})();
''';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Echarts(
      option: _option,
      extraScript: _extraScript,
      onMessage: widget.onProvinceTap,
    );
  }
}