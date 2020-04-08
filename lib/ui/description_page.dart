import 'package:flutter/material.dart';

class descrPage extends StatefulWidget {
  final String columnItemName;
  final String columnDateCreated;
  final String columnDueDate;
  final String columnDescription;
  final String columnStatus;
  final String columnTask;

  const descrPage(
      {Key key,
      this.columnItemName,
      this.columnDateCreated,
      this.columnDueDate,
      this.columnDescription,
      this.columnStatus,
      this.columnTask})
      : super(key: key);

  @override
  _descrPageState createState() => _descrPageState();
}

class _descrPageState extends State<descrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Description"),
      ),
      body: Container(
        color: Colors.black87,
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            SizedBox(height: 25.0,),
            Container(
              height: MediaQuery.of(context).size.height-270,
              width: MediaQuery.of(context).size.width-15.0,
              alignment: Alignment.topCenter,
              color: Colors.white10,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  Center(child: Text("Title :${widget.columnItemName}",style: TextStyle(fontSize: 20.0,color: Colors.blueAccent),)),
                  SizedBox(height: 10.0,),
                  ListTile(
                    title: Text("Created on:",style: TextStyle(fontSize: 10.0,color: Colors.pinkAccent)),
                      subtitle: Text("${widget.columnDateCreated}",style: TextStyle(fontSize: 15.0,color: Colors.teal)) ,
                  ),
                  ListTile(
                    title: Text("Due Date:",style: TextStyle(fontSize: 10.0,color: Colors.pinkAccent)),
                    subtitle: Text("${widget.columnDueDate}",style: TextStyle(fontSize: 15.0,color: Colors.teal)) ,
                  ),
                  ListTile(
                    title: Text("Description:",style: TextStyle(fontSize: 10.0,color: Colors.pinkAccent)),
                    subtitle: Text("${widget.columnDescription}",style: TextStyle(fontSize: 15.0,color: Colors.teal)) ,
                  ),
                  ListTile(
                    title: Text("Status:",style: TextStyle(fontSize: 10.0,color: Colors.pinkAccent)),
                    subtitle: _status() ,
                  ),
                  ListTile(
                    title: Text("Task:",style: TextStyle(fontSize: 10.0,color: Colors.pinkAccent)),
                    subtitle: Text("${widget.columnTask}",style: TextStyle(fontSize: 15.0,color: Colors.teal)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _status(){
    if (widget.columnStatus=="ND"){
      return Text("Not Done",style: TextStyle(fontSize: 15.0,color: Colors.teal));
    }else{
      return Text("Done",style: TextStyle(fontSize: 15.0,color: Colors.teal));
    }
  }

}
