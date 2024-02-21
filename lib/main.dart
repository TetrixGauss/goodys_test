import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
// import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:virtual_keyboard_multi_language/virtual_keyboard_multi_language.dart';
import 'package:window_manager/window_manager.dart';

getJson() async {
  try {
    final appDataPath = Platform.environment['APPDATA']; // Get the AppData path
    final jsonFilePath = '$appDataPath\\sample1.json'; // Replace 'yourfile.json' with your file name

    final jsonFile = File(jsonFilePath);
    var value = await jsonFile.readAsString();
    Map<String, dynamic> jsonData = jsonDecode(value);
    return jsonData;
    // bool flag = jsonData['full_screen_mode'] as bool;
    // return flag;
  } catch (e) {
    var value = await rootBundle.loadString('assets/json/sample1.json');
    Map<String, dynamic> jsonData = jsonDecode(value);
    return jsonData;
    // bool flag = jsonData['full_screen_mode'] as bool;
    // return flag;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDataPath = Platform.environment['APPDATA'];
  final logsPath = '$appDataPath\\gLOGS.txt';
  final file = File(logsPath);
  await file.writeAsString("GoodysKIOSK - INITIATED");
  await windowManager.ensureInitialized();
  await file.writeAsString("\nGoodysKIOSK - windowManager.ensureInitialized()", mode: FileMode.append);

  Map json = await getJson();
  await file.writeAsString("\nGoodysKIOSK - getJson", mode: FileMode.append);

// log(flag.toString());
  WindowOptions windowOptions = WindowOptions(
    alwaysOnTop: false, //json != null ? json['always_on_top'] ?? false : false,
    fullScreen: json != null ? json['full_screen_mode'] ?? false : false,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  // windowManager.
  await file.writeAsString("\nGoodysKIOSK - waitUntilReadyToShow", mode: FileMode.append);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  launchAtStartup.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );

  await launchAtStartup.enable();
  await file.writeAsString("\nGoodysKIOSK - launchAtStartup.enable()", mode: FileMode.append);

  await launchAtStartup.disable();
  bool isEnabled = await launchAtStartup.isEnabled();
  // log(isEnabled.toString());
  // await hotKeyManager.unregisterAll();

  // HotKey _hotKey = HotKey(
  //   KeyCode.keyQ,
  //   modifiers: [], //KeyModifier.shift
  //   // Set hotkey scope (default is HotKeyScope.system)
  //   scope: HotKeyScope.inapp, // Set as inapp-wide hotkey.
  // );

  // await hotKeyManager.register(
  //   _hotKey,
  //   keyDownHandler: (hotKey) {
  //     print('onKeyDown+${hotKey.toJson()}');
  //   },
  //   // Only works on macOS.
  //   keyUpHandler: (hotKey) {
  //     print('onKeyUp+${hotKey.toJson()}');
  //   },
  // );

  if (kReleaseMode) {
    // I'm on release mode, absolute linking
    // final String local_lib =  join('data',  'flutter_assets', 'assets', 'libturbojpeg.dll');
    // String pathToLib = join(Directory(Platform.resolvedExecutable).parent.path, local_lib);
    // DynamicLibrary lib = DynamicLibrary.open(pathToLib);
  } else {
    // I'm on debug mode, local linking
    // var path = Directory.current.path;
    // DynamicLibrary lib = DynamicLibrary.open('$path/assets/Newtonsoft.Json.dll');
    //
    // final add = lib.lookupFunction('DeserializeAnonymousType');
  }

  await file.writeAsString("\nGoodysKIOSK - before --- runApp", mode: FileMode.append);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _incrementCounter() async {
    // final appDataPath = Platform.environment['APPDATA']; // Get the AppData path
    //
    // final jsonFilePath =
    //     '$appDataPath\\sample1.json'; // Replace 'yourfile.json' with your file name
    //
    // final jsonFile = File(jsonFilePath);
    // jsonFile.readAsString().then((value) {
    //   print(value);
    //   final jsonData = jsonDecode(value);
    //   print(jsonData);
    // });

    // ByteData data = await rootBundle.load('assets/dll/Newtonsoft.Json.dll');
    // List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // File tempFile = File('${Directory.systemTemp.path}/Newtonsoft.Json.dll');
    // await tempFile.writeAsBytes(bytes);
    //
    // DynamicLibrary lib = DynamicLibrary.open(tempFile.path);
    //
    // final function = lib.lookupFunction<Void Function(), void Function()>('DeserializeAnonymousType');
    // function();
    // var path = Directory.current.path;
    // DynamicLibrary lib = DynamicLibrary.open('$path/assets/dll/Newtonsoft.Json.dll');
    //
    // // final DynamicLibrary lib = DynamicLibrary.open('assets/dll/wrapper.dylib');
    //
    // final DeserializeAnonymousTypeFunc = lib.lookupFunction<Void Function(), void Function()>('DeserializeAnonymousType');
    setState(() {
      _counter++;
    });

    // exit(0);
    await closeApp(context);
  }

  String text = '';

  // CustomLayoutKeys _customLayoutKeys;
  // True if shift enabled.
  bool shiftEnabled = false;

  //
  // // is true will show the numeric keyboard.
  // bool isNumericMode = false;

  TextEditingController controllerText = TextEditingController();
  bool openKeyboard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        openKeyboard = !openKeyboard;
                      });
                    },
                    child: Text(
                      '$_counter ' + controllerText.text.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Text("TEST3")
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: keyboard(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  keyboard() {
    if (openKeyboard) {
      return Container(
        color: Colors.grey,
        child: VirtualKeyboard(
            height: 300,
            // width: 500,
            textColor: Colors.white,
            textController: controllerText,
            //customLayoutKeys: _customLayoutKeys,
            defaultLayouts: [VirtualKeyboardDefaultLayouts.English],
            //reverseLayout :true,
            type: VirtualKeyboardType.Alphanumeric,
            onKeyPress: _onKeyPress),
      );
    }
  }

  _onKeyPress(VirtualKeyboardKey key) {
    if (controllerText.text.toString() == "12345") {
      exit(0);
      log("DONE");
    }
    if (key.keyType == VirtualKeyboardKeyType.String) {
      // text = text + (shiftEnabled ? key.capsText : key.text)!;
      if (key.text == 'Q' && shiftEnabled) {
        print('Shift + Q was pressed');
        // Perform your action here
      }
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text.length == 0) return;
          text = text.substring(0, text.length - 1);
          break;
        case VirtualKeyboardKeyAction.Return:
          text = text + '\n';
          break;
        // case VirtualKeyboardKeyAction.Space:
        //   text = text + key.text;
        //   break;
        case VirtualKeyboardKeyAction.Shift:
          setState(() {
            log('Shift');
            shiftEnabled = !shiftEnabled;
            log(shiftEnabled.toString());
          });

          break;

        default:
      }
    }
    // Update the screen
    setState(() {});
  }

  void switchToIdleApp() async {
    const url = 'idle_app://';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> closeApp(BuildContext context) async {
    switchToIdleApp();
    await windowManager.close();
  }
}
