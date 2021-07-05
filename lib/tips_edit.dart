import 'package:flutter/material.dart';
import 'package:healthify/tips_detail.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class TipsEdit extends StatefulWidget {
  final List list;
  final int index;

  TipsEdit({this.list, this.index});

  @override
  _TipsEditState createState() => _TipsEditState();
}

class _TipsEditState extends State<TipsEdit> {
  TextEditingController controllerTips;
  TextEditingController controllerDesc;

  void editData() {
    http.post(Uri.parse("http://10.0.2.2/healthify/tips_editdata.php"), body: {
      "id": widget.list[widget.index]['id'],
      "nama_tips": controllerTips.text,
      "keterangan": controllerDesc.text,
    });
  }

  @override
  void initState() {
    controllerTips =
        new TextEditingController(text: widget.list[widget.index]['nama_tips']);
    controllerDesc = new TextEditingController(
        text: widget.list[widget.index]['keterangan']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("UBAH DATA"),
          backgroundColor: Color(0xff1DBAB5),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              new Column(
                children: [
                  new TextField(
                    controller: controllerTips,
                    decoration: new InputDecoration(
                        hintText: "Nama Tips", labelText: "Nama Tips"),
                  ),
                  new TextField(
                    controller: controllerDesc,
                    decoration: new InputDecoration(
                        hintText: "Keterangan", labelText: "Keterangan"),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  new RaisedButton(
                      child: Text("SIMPAN"),
                      onPressed: () {
                        editData();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ),
                        );
                      })
                ],
              ),
            ],
          ),
        ));
  }
}
