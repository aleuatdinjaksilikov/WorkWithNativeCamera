import 'package:camera/camera.dart';
import 'package:camera_permission/take_picture_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<CameraDescription> camerasList;
  const HomeScreen({super.key, required this.camerasList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'),),
      body: Center(
        child: ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => TakePictureScreen(camera: camerasList.first,
                      )
                  )
              );
            },
            child: Text('Take Picture')
        ),
      ),
    );
  }
}
