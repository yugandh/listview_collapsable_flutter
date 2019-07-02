import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: "List View Collapsable",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageScreenState createState() => new _MyHomePageScreenState();
}

class _MyHomePageScreenState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView.builder(
        itemCount: policies.length,
        itemBuilder: (context, i) {
          return new ExpansionTile(
            title: new Text(
              policies[i].title,
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue),
            ),
            children: <Widget>[
              new Column(
                children: _buildExpandableContent(policies[i]),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildExpandableContent(Websites policies) {
    List<Widget> columnContent = [];

    for (String content in policies.contents)
      columnContent.add(
        new ListTile(
            title: new Text(
              content,
              style: new TextStyle(fontSize: 18.0, color: Colors.lightBlue),
            ),
            onTap: () {
              _openWebUrl(Websites.endpoints[content], content);
            }),
      );

    return columnContent;
  }

  _openWebUrl(String url, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GeneralWebScreen(url: url, item: title),
      ),
    );
  }
}

class Websites {
  final String title;
  List<String> contents = [];

  static final Map<String, String> endpoints = const {
    "git": "https://github.com/",
    "google": "https://www.google.com/",
    "flutter": "https://flutter.dev/docs/get-started/install",
    "swift": "https://developer.apple.com/swift/"
  };

  Websites(this.title, this.contents);
}

final titles = [
  'websites sample 1',
  'websites sample 2',
];

List<Websites> policies = [
  new Websites('websites sample 1', [
    'git',
    'flutter',
  ]),
  new Websites('Websites sample 2', ['google', 'swift']),
];


class GeneralWebScreen extends StatelessWidget {
  final String url;
  final String item;

  GeneralWebScreen({Key key, @required this.url, @required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(item),
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
