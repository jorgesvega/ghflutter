import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as provider;

import 'member.dart';
import 'strings.dart';


// We're creating a StatefulWidget subclass and overriding createState() method to create its state object.
class GHFlutter extends StatefulWidget { 
  @override
  createState() => new GHFlutterState();
}

// Now, add a GHFlutterState
// GHFlutterState extends State with a parameter of GHFlutter
class GHFlutterState extends State<GHFlutter> {

  var _members = <Member>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    String dataURL = "https://api.github.com/orgs/raywenderlich/members";
    provider.Response response = await provider.get(dataURL);
    setState(() {
          final membersJSON = JSON.decode(response.body);

          for (var memberJSON in membersJSON) {
            final member = new Member(memberJSON["login"], memberJSON["avatar_url"]);
            _members.add(member);
          }
    });
  }

  // 1º- When making a new widget, the first task is to override the build() method that gets called when the widgete is rendered to the screen.
  @override
  Widget build(BuildContext context) {
    return new Scaffold( // A Scaffold is a container for material design widgets. It acts as the root of a widget hierarchy. Adds too an AppBar and a Body to the Scaffold.
      appBar: new AppBar(
        title: new Text(Strings.appTitle),
      ),
      body: new ListView.builder(
        itemCount: _members.length * 2,
        itemBuilder: (BuildContext context, int position) {
          if (position.isOdd) return new Divider();

          final index = position  ~/ 2;
          return _buildRow(index);
        }
      ),
    );
  }

  Widget _buildRow(int i) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new ListTile(
        title: new Text("${_members[i].login}", style: _biggerFont),
        leading: new CircleAvatar( // By setting the avatar as the leading attribute of the ListTile, it will show before the title within the row.
          backgroundColor: Colors.green,
          backgroundImage: new NetworkImage(_members[i].avatarURL),
        ),
      ),
    );
  }
}
