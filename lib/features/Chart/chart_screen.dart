import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';


class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  Future<String> _loadGeoJson() async {
    return await rootBundle.loadString('assets/vietnam.geojson');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadGeoJson(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final geoJson = jsonEncode(snapshot.data!);

        return Scaffold(
          appBar: AppBar(title: const Text('Vietnam Map')),
          body: Echarts(
            extraScript: '''
              const geoJson = JSON.parse($geoJson);
              echarts.registerMap('vietnam', geoJson);
              console.log("Map loaded");
            ''',
            option: '''
            {
              title: {
                text: 'Vietnam Map',
                left: 'center'
              },
              tooltip: {
                trigger: 'item'
              },
              visualMap: {
                min: 0,
                max: 100,
                left: 'left',
                bottom: '5%',
                calculable: true
              },
              series: [{
                type: 'map',
                map: 'vietnam',
                roam: true,
                emphasis: {
                  label: { show: true }
                }
              }]
            }
            ''',
          ),
        );
      },
    );
  }
}