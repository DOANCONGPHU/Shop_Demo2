import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'dart:convert';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  String? _geoJson;
  String _selectedProvinceName = 'Chưa chọn'; // Khởi tạo giá trị mặc định để tránh lỗi late
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGeoJson();
  }

  Future<void> loadGeoJson() async {
    try {
      // 1. Load file từ assets
      final String response = await rootBundle.loadString('assets/vietnam.json');
      final data = jsonDecode(response);

      // 2. Trích xuất đúng phần geoJSON từ file ông đã gửi
      if (data['geoJSON'] != null) {
        setState(() {
          _geoJson = jsonEncode(data['geoJSON']);
          _isLoading = false;
        });
      } else {
        throw Exception("File không chứa key geoJSON");
      }
    } catch (e) {
      debugPrint("Lỗi load bản đồ: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _buildOption() {
    return '''
    {
      tooltip: { trigger: 'item' },
      series: [{
        name: 'Việt Nam',
        type: 'map',
        map: 'vietnam_map', // Tên này phải khớp với registerMap
        roam: true,
        emphasis: {
          label: { show: true },
          itemStyle: { areaColor: '#ffcc00' }
        },
        data: []
      }]
    }
    ''';
  }

  String _buildExtraScript() {
    if (_geoJson == null) return "";
    // Đăng ký bản đồ vào bộ nhớ Echarts bên trong WebView
    return 'echarts.registerMap("vietnam_map", $_geoJson);';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bản đồ ORA')),
      body: Column(
        children: [
          if (_selectedProvinceName != 'Chưa chọn')
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.blue.withOpacity(0.1),
              child: Text('Đang chọn: $_selectedProvinceName'),
            ),
          Expanded(
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator())
              : _geoJson != null
                ? Echarts(
                    option: _buildOption(),
                    extraScript: _buildExtraScript(),
                    onMessage: (String message) {
                      // Xử lý khi nhấn vào bản đồ
                      final data = jsonDecode(message);
                      setState(() {
                        _selectedProvinceName = data['name'];
                      });
                    },
                  )
                : const Center(child: Text('Lỗi: Không có dữ liệu bản đồ')),
          ),
        ],
      ),
    );
  }
}