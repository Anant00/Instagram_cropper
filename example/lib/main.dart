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

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Pick Image'),
          onPressed: () async {
            var imagePath = await getImage();
            if (imagePath != null) {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return MyHomePage(
                  title: imagePath,
                );
              }));
            }
          },
        ),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Testing"),
      ),
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: BlurViewWidget(
              onBlurViewWidgetCreated: _onBlurViewWidgetCreated,
            ),
          ),
          Positioned(
            child: Icon(Icons.add),
            bottom: 10,
            left: 20,
          ),
        ],
      ),
    );
  }

  void _onBlurViewWidgetCreated(BlurViewWidgetController controller) async {
    await controller.getView();
    await controller.setUri(widget.title);
  }
}
