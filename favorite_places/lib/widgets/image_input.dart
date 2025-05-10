import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _takenImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    
    if (imageFile == null) return;

    setState(() {
      _takenImage = File(imageFile.path);
    });

    widget.onPickImage(_takenImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePicture,
    );

    if (_takenImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _takenImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      width: double.infinity,
      height: 250,
      alignment: Alignment.center,
      child: content,
    );
  }
}
