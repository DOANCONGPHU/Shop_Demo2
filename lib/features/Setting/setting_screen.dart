import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Future<String> _loadContent() async {
    return rootBundle.loadString(
      'assets/markdown/policy.md',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Chính sách'),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        shadowColor: Colors.black,
        elevation: 1,
      ),
      body: FutureBuilder<String>(
        future: _loadContent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Không tải được nội dung'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 72),
            physics: const BouncingScrollPhysics(),
            child: MarkdownBody(
              data: snapshot.data!,
              selectable: true,
            ),
          );
        },
      ),
    );
  }
}