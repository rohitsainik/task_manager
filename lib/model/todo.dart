import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/ui/description_page.dart';

class NoDoItem extends StatelessWidget {
  String _itemName;
  String _dateCreated;
  String _itemDescription;
  String _dueDate;
  String _status;
  String _task;
  int _id;

  NoDoItem(this._itemName, this._dateCreated, this._status, this._dueDate,
      this._task, this._itemDescription);

  NoDoItem.map(dynamic obj) {
    this._itemName = obj["itemName"];
    this._dateCreated = obj["dateCreated"];
    this._id = obj["id"];
    this._task = obj["task"];
    this._status = obj["status"];
    this._itemDescription = obj["description"];
    this._dueDate = obj["dueDate"];
  }

  String get itemName => _itemName;

  String get dateCreated => _dateCreated;

  int get id => _id;

  String get status => _status;

  String get description => _itemDescription;

  String get task => _task;

  String get dueDate => _dueDate;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["itemName"] = _itemName;
    map["dateCreated"] = _dateCreated;
    map["status"] = _status;
    map["description"] = _itemDescription;
    map["task"] = _task;
    map["dueDate"] = _dueDate;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  NoDoItem.fromMap(Map<String, dynamic> map) {
    this._itemName = map["itemName"];
    this._dateCreated = map["dateCreated"];
    this._id = map["id"];
    this._dueDate = map["dueDate"];
    this._task = map["task"];
    this._itemDescription = map['description'];
    this._status = map["status"];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            debugPrint("good");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>descrPage(
              columnDateCreated: _dateCreated,
              columnDescription: _itemDescription,
              columnDueDate: _dueDate,
              columnStatus: _status,
              columnItemName: _itemName,
              columnTask: _task,
            )));
          },
          child: ListTile(
            title: new Text(
              _itemName,
              style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.9),
            ),
            subtitle: new Text(
              "Due Date $_dueDate",
              style: new TextStyle(
                  color: Colors.white70,
                  fontSize: 12.5,
                  fontStyle: FontStyle.italic),
            ),
            leading: _taskIcon(),
            trailing: _statusIndicator(),
          ),
        ));
  }

  Widget _taskIcon() {
    if (_task == 'travel') {
      return FaIcon(
        FontAwesomeIcons.mapMarkedAlt,
        color: Colors.redAccent,
      );
    } else if (_task == 'gym') {
      return FaIcon(
        FontAwesomeIcons.dumbbell,
        color: Colors.greenAccent,
      );
    } else if (_task == 'shopping') {
      return FaIcon(
        FontAwesomeIcons.shoppingBag,
        color: Colors.blueAccent,
      );
    } else {
      return FaIcon(
        FontAwesomeIcons.glassCheers,
        color: Colors.pinkAccent,
      );
    }
  }

  Widget _statusIndicator() {
    if (_status == "ND") {
      return Icon(
        Icons.star,
        color: Colors.red,
      );
    } else {
      return Icon(
        Icons.stars,
        color: Colors.green,
      );
    }
  }
}
