import 'package:flutter/material.dart';

import 'package:instagram_cropper/instagram_cropper.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          imagePath != null
              ? MyHomePage(
                  title: imagePath,
                )
              : AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                child: Text('Pick Image'),
                onPressed: () async {
                  var path = await getImage();
                  if (path != null) {
                    setState(() {
                      imagePath = path;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg'],
    );

    print('file result is $result');
    if (result != null) {
      PlatformFile file = result.files.first;

      print(file);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
      return file.path;
    }
    return null;

    // final pickedFile =
    //     await ImagePicker().getImage(source: ImageSource.gallery);
    // return pickedFile.path;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BlurViewWidgetController controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (controller != null) {
      controller.setUri(widget.title);
    }
    print('settings ');
    return AspectRatio(
      aspectRatio: 1,
      child: BlurViewWidget(
        onBlurViewWidgetCreated: _onBlurViewWidgetCreated,
      ),
    );
  }

  void _onBlurViewWidgetCreated(BlurViewWidgetController controller) async {
    print('settings controller set up $controller');
    if (controller != null) {
      this.controller = controller;
    }
    await controller.setUri(widget.title);
  }
}
