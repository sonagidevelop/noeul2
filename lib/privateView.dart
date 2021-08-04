import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class pvView extends StatefulWidget {
  @override
  _pvViewState createState() => _pvViewState();
}

class _pvViewState extends State<pvView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.save),
            Icon(Icons.delete),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => EditPage()));
                },
                icon: Icon(Icons.add))
          ],
        ),
        TextField()
      ],
    ));
  }
}

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EditDetail(),
    );
  }
}

class EditDetail extends StatefulWidget {
  @override
  _EditDetailState createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [TextField()],
        ),
      ),
    );
  }
}
