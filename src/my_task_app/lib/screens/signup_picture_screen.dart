import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SignUpPictureScreen extends StatefulWidget {
  const SignUpPictureScreen({super.key});

  @override
  State<SignUpPictureScreen> createState() => _SignUpPictureScreenState();
}

class _SignUpPictureScreenState extends State<SignUpPictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeControllerCamera();
  }

  Future<void> _initializeControllerCamera() async {
    try {
      print('Obtendo lista de câmeras disponíveis...');
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('Nenhuma câmera disponível');
      }
      print('Câmeras disponíveis: ${cameras.length}');
      final firstCamera = cameras.first;

      print('Inicializando controlador da câmera...');
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      await _controller.initialize();
      print('Controlador da câmera inicializado com sucesso');
    } catch (e) {
      print('Erro ao inicializar a câmera: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_controller.value.isInitialized) {
              print('Renderizando CameraPreview...');
              return CameraPreview(_controller);
            } else {
              print('Controlador da câmera não está inicializado');
              return Center(child: Text('Câmera não inicializada'));
            }
          } else if (snapshot.hasError) {
            print('Erro no FutureBuilder: ${snapshot.error}');
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            print('Inicializando...');
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () async {
          if (_controller.value.isInitialized) {
            try {
              print('Tirando foto...');
              XFile file = await _controller.takePicture();
              print('Foto tirada: ${file.path}');
              Navigator.of(context).pop(file.path);
            } catch (e) {
              print('Erro ao tirar foto: $e');
            }
          } else {
            print('Controlador não está inicializado');
          }
        },
      ),
    );
  }
}