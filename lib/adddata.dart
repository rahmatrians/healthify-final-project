import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerCode = new TextEditingController();
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerPrice = new TextEditingController();
  TextEditingController controllerStock = new TextEditingController();

  void AddingData() {
    http.post(Uri.parse("http://10.0.2.2/healthify/adddata.php"), body: {
      'itemcode': controllerCode.text,
      'itemname': controllerName.text,
      'price': controllerPrice.text,
      'stock': controllerStock.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Text("ADD DATA"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              new Column(
                children: [
                  new TextField(
                    controller: controllerCode,
                    decoration: new InputDecoration(
                        hintText: "Item Code", labelText: "Item Code"),
                  ),
                  new TextField(
                    controller: controllerName,
                    decoration: new InputDecoration(
                        hintText: "Item Name", labelText: "Item Name"),
                  ),
                  new TextField(
                    controller: controllerPrice,
                    decoration: new InputDecoration(
                        hintText: "Price", labelText: "Price"),
                  ),
                  new TextField(
                    controller: controllerStock,
                    decoration: new InputDecoration(
                        hintText: "Stock", labelText: "Stock"),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  new RaisedButton(
                      child: Text("Simpan"),
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
