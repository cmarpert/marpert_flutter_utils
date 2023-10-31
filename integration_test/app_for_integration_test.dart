import 'package:flutter/material.dart';
import 'package:marpert_flutter_utils/marpert_flutter_utils.dart';

class MyApp extends StatelessWidget {
  final GlobalKey orientationKey = GlobalKey();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Orientation Test App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                key: const Key('orientationButton'),
                onPressed: () {
                  final orientation = MediaQuery.of(orientationKey.currentContext!).orientation;
                  (orientation == Orientation.portrait) ? toLandscape() : toPortrait();
                },
                child: const Text('Toggle Orientation'),
              ),
              Container(
                key: orientationKey,
                child: const Text('Current Orientation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
