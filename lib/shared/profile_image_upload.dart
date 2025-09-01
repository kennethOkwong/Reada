import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class ImageUploadWidget extends StatefulWidget {
  final double size; // allow custom sizing
  final Function(File? file) onSelected;

  const ImageUploadWidget(
      {super.key, this.size = 120, required this.onSelected});

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onSelected(_imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              width: 2),
        ),
        child: _imageFile == null
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: widget.size * 0.5,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  Positioned(
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: context.colorScheme.onSurface
                            .withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text("Upload",
                          style: context.textTheme.labelSmall
                              ?.copyWith(color: context.colorScheme.surface)),
                    ),
                  )
                ],
              )
            : ClipOval(
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: widget.size,
                  height: widget.size,
                ),
              ),
      ),
    );
  }
}
