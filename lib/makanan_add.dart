import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MakananAdd extends StatefulWidget {
  @override
  _MakananAddState createState() => _MakananAddState();
}

class _MakananAddState extends State<MakananAdd> {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerDesc = new TextEditingController();

  void AddingData() {
    http.post(Uri.parse("http://10.0.2.2/healthify/makanan_adddata.php"),
        body: {
          'nama_makanan': controllerName.text,
          'keterangan': controllerDesc.text,
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1DBAB5),
          title: new Text("TAMBAH DATA"),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: [
              new Column(
                children: [
                  new TextField(
                    controller: controllerName,
                    decoration: new InputDecoration(
                        hintText: "Nama Makanan", labelText: "Nama Makanan"),
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
                        AddingData();
                        Navigator.pop(context);
                      })
                ],
              ),
            ],
          ),
        ));
  }
}
