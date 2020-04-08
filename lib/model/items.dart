import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/model/todo.dart';
import 'package:task_manager/utils/databaseclient.dart';
import 'package:task_manager/utils/dateformattor.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TaskmanagerScreen extends StatefulWidget {
  @override
  _TaskmanagerScreenState createState() => new _TaskmanagerScreenState();
}

class _TaskmanagerScreenState extends State<TaskmanagerScreen> {
  final TextEditingController _textEditingController1 =
      new TextEditingController();
  final TextEditingController _textEditingController2 =
      new TextEditingController();
  final TextEditingController _textEditingController3 =
      new TextEditingController();
  var db = new DatabaseHelper();
  final List<NoDoItem> _itemList = <NoDoItem>[];
  String _date = "Due Date";
  bool _validate = false;

  void _handleSubmitted(String title, String description, String dueDate,
      String task, String status) async {
    NoDoItem noDoItem = new NoDoItem(
        title, dateFormatted(), status, dueDate, task, description);
    int savedItemId = await db.saveItem(noDoItem);

    NoDoItem addedItem = await db.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });

    print("Item saved id: $savedItemId");
  }

  String val;
  String st = "ND";
  var _task = ["travel", 'gym', 'shopping', 'party'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readNoDoList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: false,
                itemCount: _itemList.length,
                itemBuilder: (_, int index) {
                  return Dismissible(
                    background: slideRightBackground(),
                    secondaryBackground: slideLeftBackground(),
                    // ignore: missing_return
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are you sure you want to delete ${_itemList[index].itemName}?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      // TODO: Delete the item from DB etc..
                                      setState(() {
                                        _deleteNoDo(_itemList[index].id, index);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      } else {
                        final bool res2 = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Are You sure You Have Completed these Task"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    onPressed: () async {
                                      var nst = "D";
                                      setState(() {
                                        _deleteNoDo(_itemList[index].id, index);
                                        _handleSubmitted(
                                            _itemList[index].itemName,
                                            _itemList[index].description,
                                            _itemList[index].dueDate,
                                            _itemList[index].task,
                                            nst);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                        return res2;
                      }
                    },
                    child: new Card(
                        color: Colors.white10, child: _itemList[index]),
                    key: Key(_itemList[index].itemName),
                  );
                }),
          ),
          new Divider(
            height: 1.0,
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          tooltip: "Add Item",
          backgroundColor: Colors.redAccent,
          child: ListTile(
            title: Icon(Icons.add),
          ),
          onPressed: () {
            _showFormDialog();
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Taskinput(),fullscreenDialog: true));
          }),
    );
  }

  void _showFormDialog() {
    var alert = new AlertDialog(
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 300.0,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: new TextField(
                  controller: _textEditingController1,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: "Title",
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      hintText: "Enter Title Here",
                      icon: Icon(
                        Icons.title,
                        color: Colors.teal,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: new TextField(
                  controller: _textEditingController2,
                  autofocus: true,
                  decoration: new InputDecoration(
                      labelText: "Description",
                      errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      hintText: "eg. Don't buy stuff",
                      icon: new Icon(
                        Icons.description,
                        color: Colors.teal,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 4.0,
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                      print('confirm $date');
                      setState(() {
                        this._date = duedateformatted(date);
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    size: 18.0,
                                    color: Colors.teal,
                                  ),
                                  Text(
                                    " ${this._date}",
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                      child: Text(
                    "Select Your Task",
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ))),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: DropdownButton(
                  items: _task.map<DropdownMenuItem>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.send, color: Colors.teal),
                          SizedBox(width: 10),
                          Text(value, style: TextStyle(color: Colors.teal)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      this.val = newValue;
                    });
                  },
                  value: this.val,
                  isExpanded: true,
                  hint: Text(("select task")),
                ),
              )
            ],
          ),
        );
      }),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
                _handleSubmitted(_textEditingController1.text,
                    _textEditingController2.text, _date.toString(), val, st);
                _textEditingController1.clear();
                _textEditingController2.clear();
                _textEditingController3.clear();
                _date = "Due Date";
                debugPrint(_date);
                Navigator.pop(context);
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.teal),
            )),
        new FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: Colors.teal)))
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _readNoDoList() async {
    List items = await db.getItems();
    items.forEach((item) {
      // NoDoItem noDoItem = NoDoItem.fromMap(item);
      setState(() {
        _itemList.add(NoDoItem.map(item));
      });
      // print("Db items: ${noDoItem.itemName}");
    });
  }

  _deleteNoDo(int id, int index) async {
    debugPrint("Deleted Item!");

    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.done_outline,
              color: Colors.white,
            ),
            Text(
              " Done",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Remove",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget _taskIcon() {
    if (val == 'travel') {
      return FaIcon(FontAwesomeIcons.mapMarkedAlt, color: Colors.teal);
    } else if (val == 'gym') {
      return FaIcon(FontAwesomeIcons.dumbbell, color: Colors.teal);
    } else if (val == 'shopping') {
      return FaIcon(FontAwesomeIcons.shoppingBag, color: Colors.teal);
    } else {
      return FaIcon(FontAwesomeIcons.glassCheers, color: Colors.teal);
    }
  }
}
