import 'dart:ui';

import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomView extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final Service service;

  const CustomView(
      {required this.children,
      this.mainAxisAlignment = MainAxisAlignment.center,
      required this.service});

  @override
  Widget build(BuildContext context) {
    print(service.loader);
    return Scaffold(
      body: GestureDetector(
        onTap: () => {Keyboard.shared().unfocus(context), print("asdfsadf")},
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: bigValue),
            child: Stack(
              children: [
                Column(
                    mainAxisAlignment: mainAxisAlignment, children: children),
                if (service.loader)
                  Center(
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        return GFLoader(type: GFLoaderType.ios);
                      },
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<Widget> children;
  final bool constraint;
  final MainAxisAlignment mainAxisAlignment;
  final Service service;
  const CustomListView(
      {required this.children,
      this.constraint = true,
      this.mainAxisAlignment = MainAxisAlignment.end,
      required this.service});

  @override
  Widget build(BuildContext context) {
    print(service.loader);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;

    final double usableScreenHeight = screenHeight - appBarHeight;

    return Scaffold(
        body: GestureDetector(
            onTap: () => {Keyboard.shared().unfocus(context)},
            child: Container(
                height: usableScreenHeight,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraint ? bigValue : 0,
                        vertical: constraint ? bigValue : 0),
                    child: Stack(children: [
                      ListView(children: children),
                      if (service.loader)
                        Center(
                          child: FutureBuilder(
                            builder: (context, snapshot) {
                              return GFLoader(type: GFLoaderType.ios);
                            },
                          ),
                        )
                    ])))));
  }
}

class Keyboard {
  static final Keyboard _shared = Keyboard();
  factory Keyboard.shared() {
    return _shared;
  }
  Keyboard();
  void unfocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
