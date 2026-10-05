import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription>? camera;
  const CameraScreen({Key? key,this.camera}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  XFile? pictureFile;
  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.camera![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if(!controller.value.isInitialized)
      {
        return const SizedBox(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    return Column(
      children: [
        Padding(
         padding: const EdgeInsets.all(8.0),
         child: Center(
           child: SizedBox(
             height: 700,
             width: 600,
             child: CameraPreview(controller),
           ),
         ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
             style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
             ),
            onPressed: ()async{
              pictureFile = await controller.takePicture();
              setState(() {

              });
            },
            child: const Text(
                'Capture Image',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        if(pictureFile != null)
            Image.network(
            pictureFile!.path,
            height: 200,
            ),
      ],
    );
  }
}
