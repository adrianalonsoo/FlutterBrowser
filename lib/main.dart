// ignore_for_file: no_logic_in_create_state, use_key_in_widget_constructors, unnecessary_new, unnecessary_this, sized_box_for_whitespace, unnecessary_const

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(
      title: 'Flutter Browser',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    ));

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController _webViewController;
  final TextEditingController _teController = new TextEditingController();
  bool cargando = false;

  void verCarga(bool ls) {
    this.setState(() {
      cargando = ls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Flexible(
                            flex: 2,
                            child: Text(
                              "http://",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                            )),
                        Flexible(
                          flex: 4,
                          child: TextField(
                            autocorrect: false,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24),
                            decoration: const InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 2),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.white,
                                      width: 2),
                                )),
                            controller: _teController,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Center(
                            child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  String finalURL = _teController.text;
                                  if (!finalURL.startsWith("https://")) {
                                    finalURL = "https://" + finalURL;
                                  }
                                  if (_webViewController != null) {
                                    verCarga(true);
                                    _webViewController
                                        .loadUrl(finalURL)
                                        .then((onValue) {})
                                        .catchError((e) {
                                      verCarga(false);
                                    });
                                  }
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                  flex: 9,
                  child: Stack(
                    children: <Widget>[
                      WebView(
                        initialUrl: 'http://google.es',
                        onPageFinished: (data) {
                          verCarga(false);
                        },
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (controller) {
                          _webViewController = controller;
                        },
                      ),
                      (cargando)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Center()
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
