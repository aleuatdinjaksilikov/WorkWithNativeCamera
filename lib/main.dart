import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(camerasList: cameras,));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> camerasList;
  const MyApp({super.key, required this.camerasList});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(camerasList: camerasList,),
    );
  }
}



