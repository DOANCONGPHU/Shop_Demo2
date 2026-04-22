import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class MediaUploadSection extends StatefulWidget {
  const MediaUploadSection({super.key});

  @override
  State<MediaUploadSection> createState() => _MediaUploadSectionState();
}

class _MediaUploadSectionState extends State<MediaUploadSection> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];

  Future<void> _showImageSourceDialog() async {

  
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text('Chụp ảnh'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                if (photo != null) {
                  setState(() => _selectedImages.add(photo));
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text('Chọn từ thư viện'),
              onTap: () async {
                Navigator.pop(context);
                final List<XFile> images = await _picker.pickMultiImage();
                setState(() => _selectedImages.addAll(images));
              },
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Thêm ít nhất 1 hình ảnh/video về sản phẩm",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 12),

        if (_selectedImages.isEmpty)
          // Phần DottedBorder ban đầu
          GestureDetector(
            onTap: _showImageSourceDialog,
            child: DottedBorder(
              options: RectDottedBorderOptions(
                dashPattern: [6, 4],
                strokeWidth: 1.5,
                padding: const EdgeInsets.all(20),
                color: Colors.grey.shade400,
              ),
              child: const Center(
                child: Column(
                  children: [
                    Icon(Icons.camera_alt_outlined, size: 48, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      "Thêm hình ảnh / video",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Text(
                      "Chạm để chọn",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          // Phần hiển thị danh sách ảnh đã chọn + nút thêm
          Column(
            children: [
              SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length + 1, // +1 cho nút thêm
                  itemBuilder: (context, index) {
                    if (index == _selectedImages.length) {
                      // Nút thêm ảnh
                      return GestureDetector(
                        onTap: _showImageSourceDialog,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: DottedBorder(
                            options: RectDottedBorderOptions(
                              dashPattern: [4, 3],
                              strokeWidth: 1.5,
                              padding: const EdgeInsets.all(8),
                              color: Colors.grey.shade400,
                            ),
                            child: const SizedBox(
                              width: 90,
                              height: 90,
                              child: Center(
                                child: Icon(Icons.add_photo_alternate, size: 32, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    // Hiển thị ảnh đã chọn
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(_selectedImages[index].path),
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${_selectedImages.length} hình ảnh đã chọn",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
      ],
    );
  }
}