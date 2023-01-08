import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
// import 'package:image/image.dart' as img;

class UploadPage extends ConsumerStatefulWidget {
  UploadPage({super.key, required this.image});

  final XFile image;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadPageState();
}

class _UploadPageState extends ConsumerState<UploadPage> {
  final TextEditingController _placeNameTextEditingController =
      TextEditingController();
  final TextEditingController _locationTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    _placeNameTextEditingController.dispose();
    _locationTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: (() {
                            context.pop();
                          }),
                          icon: Icon(Icons.arrow_back_ios)),
                      const SizedBox(width: 10),
                      Text("New Spot",
                          style: Theme.of(context).textTheme.headline5)
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                            width: double.maxFinite,
                            height: 300,
                            decoration: BoxDecoration(
                                // image:
                                // DecorationImage(image: AssetImage(widget.image.path)),
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(4)),
                            child: Image.file(
                              File(widget.image.path),
                              fit: BoxFit.contain,
                            )),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _placeNameTextEditingController,
                          decoration: InputDecoration(
                              label: const Text("Place Name"),
                              filled: true,
                              fillColor: Colors.grey.shade200),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _locationTextEditingController,
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintText: "Location",
                              filled: true,
                              fillColor: Colors.grey.shade200),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _descriptionTextEditingController,
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintText: "Some Pain Points",
                              filled: true,
                              fillColor: Colors.grey.shade200),
                        ),
                        // Lottie.asset("assets/lottie/polution.json",
                        // fit: BoxFit.contain),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: (() async {}),
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      textStyle: const TextStyle(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.upload),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Upload",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ));
  }
}
