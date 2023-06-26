import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/custom_button.dart';
import 'package:smartcare_web/reusable/project_colors.dart';
import 'package:smartcare_web/system/user.dart';
import 'Services.dart';

class DataTableDemo extends StatefulWidget {
  const DataTableDemo({super.key});

  final String title = "Flutter Data Table";

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  late List<User> _users;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late User _selectedUser;
  late bool _isUpdating;
  late String _titleProgress;

  @override
  void initState() {
    super.initState();
    _users = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getUsers();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(
          backgroundColor: ProjectColors.green,
        content: Text("The table"),));
        _getUsers();
      }
    });
  }

  _addUser() {
    if (_firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty) {
      print("Empty fields");
      return;
    }
    _showProgress('Adding User...');
    Services.addUser(_firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getUsers();
      }
      _clearValues();
    });
  }

  _getUsers() {
    _showProgress('Loading Users...');
    Services.getUsers().then((users) {
      setState(() {
        _users = users;
      });
      _showProgress(widget.title);
      print("Length: ${users.length}");
    });
  }

  _deleteUser(User user) {
    _showProgress('Deleting User...');
    Services.deleteUser(user.id).then((result) {
      if ('success' == result) {
        setState(() {
          _users.remove(user);
        });
        _getUsers();
      }
    });
  }

  _updateUser(User user) {
    _showProgress('Updating User...');
    Services.updateUser(
        user.id, _firstNameController.text, _lastNameController.text)
        .then((result) {
      if ('success' == result) {
        _getUsers();
        setState(() {
          _isUpdating = false;
        });
        _firstNameController.text = '';
        _lastNameController.text = '';
      }
    });
  }

  _setValues(User user) {
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    setState(() {
      _isUpdating = true;
    });
  }

  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(
                label: Text("ID"),
                numeric: false,
                tooltip: "This is the User id"),
            DataColumn(
                label: Text(
                  "FIRST",
                ),
                numeric: false,
                tooltip: "This is the last name"),
            DataColumn(
                label: Text("LAST"),
                numeric: false,
                tooltip: "This is the last name"),
            DataColumn(
                label: Text("DELETE"),
                numeric: false,
                tooltip: "Delete Action"),
          ],
          rows: _users
              .map(
                (user) => DataRow(
              cells: [
                DataCell(
                  Text(user.id),
                  onTap: () {
                    print("Tapped ${user.firstName}");
                    _setValues(user);
                    _selectedUser = user;
                  },
                ),
                DataCell(
                  Text(
                    user.firstName.toUpperCase(),
                  ),
                  onTap: () {
                    print("Tapped ${user.firstName}");
                    _setValues(user);
                    _selectedUser = user;
                  },
                ),
                DataCell(
                  Text(
                    user.lastName.toUpperCase(),
                  ),
                  onTap: () {
                    print("Tapped ${user.firstName}");
                    _setValues(user);
                    _selectedUser = user;
                  },
                ),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteUser(user);
                    },
                  ),
                  onTap: () {
                    print("Tapped ${user.firstName}");
                  },
                ),
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }

  // showSnackBar(context, message) {
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(
  //     content: Text(message),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _getUsers();
            },
          ),
        ],
      ),
      body: Container(
        // color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _firstNameController,
                decoration: const InputDecoration.collapsed(
                  hintText: "First Name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _lastNameController,
                decoration: const InputDecoration.collapsed(
                  hintText: "Last Name",
                ),
              ),
            ),
            _isUpdating
                ? Row(
              children: <Widget>[
                CustomButton(
                  child: const Text('UPDATE'),
                  onTap: () {
                    _updateUser(_selectedUser);
                  },
                ),
                CustomButton(
                  child: const Text('CANCEL'),
                  onTap: () {
                    setState(() {
                      _isUpdating = false;
                    });
                    _clearValues();
                  },
                ),
              ],
            )
                : Container(),
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addUser();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
