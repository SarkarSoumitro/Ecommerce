// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:app_web/controller/banner_controller.dart';
import 'package:app_web/views/side_bar_screens/widget/banner_widget.dart';
import 'package:flutter/material.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String id = '/uploadbannerscreen';

  const UploadBannerScreen({super.key});

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final BannerController _bannerController = BannerController();
  Uint8List? _image;
  final GlobalKey<BannerWidgetState> _bannerKey =
      GlobalKey<BannerWidgetState>();

  pickImage() {
    final html.FileUploadInputElement uploadInput =
        html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file == null) return;

      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          _image = reader.result as Uint8List;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Banners",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Divider(color: Colors.black, thickness: 2),
        Row(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.memory(
                        _image!,
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    )
                  : const Center(child: Text("Category image")),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await _bannerController.uploadBanner(
                    pickedImage: _image!,
                    context: context,
                  );
                },
                child: Text("Save"),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              pickImage();
            },
            child: Text("Pick image"),
          ),
        ),
        Divider(color: Colors.grey, thickness: 2),
        Row(
          children: [
            Text("Refresh"),
            IconButton(
              onPressed: () {
                _bannerKey.currentState?.refresh();
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),

        BannerWidget(key: _bannerKey),
      ],
    );
  }
}
