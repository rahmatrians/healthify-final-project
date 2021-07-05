import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list, this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController controllerCode;
  TextEditingController controllerName;
  TextEditingController controllerPrice;
  TextEditingController controllerStock;

  void editData() {
    http.post(Uri.parse("http://10.0.2.2/healthify/editdata.php"), body: {
      "id": widget.list[widget.index]['id'],
      "item_code": controllerCode.text,
      "item_name": controllerName.text,
      "price": controllerPrice.text,
      "stock": controllerStock.text
    });
  }

  @override
  void initState() {
    controllerCode = controllerCode =
        new TextEditingController(text: widget.list[widget.index]['item_code']);
    controllerName =
        new TextEditingController(text: widget.list[widget.index]['item_name']);
    controllerPrice =
        new TextEditingController(text: widget.list[widget.index]['price']);
    controllerStock =
        new TextEditingController(text: widget.list[widget.index]['stock']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("EDIT DATA"),
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
                        editData();
                        Navigator.pop(context);
                      })
                ],
              ),
            ],
          ),
        ));
  }
}
