import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class MediaUploadSection extends StatefulWidget {
  final Function(List<XFile> selectedImages) onImagesChanged; 
  const MediaUploadSection({super.key, required this.onImagesChanged});

  @override
  State<MediaUploadSection> createState() => _MediaUploadSectionState();
}

class _MediaUploadSectionState extends State<MediaUploadSection> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];

  // Thông báo ảnh đã thay đổi
  void _notifyImagesChanged() {
    widget.onImagesChanged(List.from(_selectedImages)); 
    print("💥💥💥💥💥${_selectedImages}");
  }
  // Chọn ảnh
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
                  _notifyImagesChanged(); 
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
                _notifyImagesChanged();
              },
            ),
          ],
        ),
      ),
    );
  }
  
  // Xóa ảnh
  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    _notifyImagesChanged();
  }

  // Hiển thị ảnh đã chọn
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
                    Icon(Icons.camera_alt_outlined, size: 36, color: Colors.black),
                    SizedBox(height: 12),
                    Text(
                      "Thêm hình ảnh / video",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          Column(
            children: [
              SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length + 1, 
                  itemBuilder: (context, index) {
                    if (index == _selectedImages.length) {
                      return GestureDetector(
                        onTap: _showImageSourceDialog,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: DottedBorder(
                            options: RectDottedBorderOptions(
                              dashPattern: [4, 3],
                              strokeWidth: 1.5,
                              color: Colors.grey.shade400,
                            ),
                            child: const SizedBox(
                              width: 100,
                              height: 100,
                              child: Center(
                                child: Icon(Icons.add_photo_alternate, size: 32, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                        width: 100,
                        height: 90,
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(_selectedImages[index].path),
                                
                                width: 100,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
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