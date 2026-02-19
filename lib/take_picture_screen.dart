import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_permission/display_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({super.key, required this.camera});

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              Positioned.fill(child: CameraPreview(_controller)),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: FloatingActionButton(
                    onPressed: () async {
                      try{
                        await _initializeControllerFuture;

                        final image = await _controller.takePicture();
                        final file = File(image.path);

                        await fixImageRotation(file);

                        if(!context.mounted) return;

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => DisplayPictureScreen(
                                file: file,
                              )
                          )
                        );
                      }catch(e){
                        print(e);
                      }
                    },
                    child: Icon(Icons.camera_alt_outlined),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> fixImageRotation(File file) async {
    final bytes = await file.readAsBytes();

    final image = img.decodeImage(bytes);
    if (image == null) return;

    final fixedImage = img.bakeOrientation(image);
    final fixedBytes = img.encodeJpg(fixedImage);

    await file.writeAsBytes(fixedBytes);
  }
}
