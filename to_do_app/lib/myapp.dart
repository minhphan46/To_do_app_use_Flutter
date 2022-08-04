import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'models/task.dart';
import 'package:intl/intl.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _contentController = TextEditingController();
  // object of the app
  Task _task = Task(content: "");
  List<Task> _tasks = <Task>[];

  void _insertTask() {
    if (_task.content == "") return;
    _task.createTime = DateTime.now();
    _tasks.add(_task);
    _task = Task(content: "");
    _contentController.text = "";
  }

  void _deleteTask() {
    _tasks = _tasks.where((task) => task.isChecked == false).toList();
  }

  void _onButtonShowModalSheet() {
    showModalBottomSheet(
      context: this.context,
      backgroundColor: Colors.transparent,
      //barrierColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              // In dong chu 'Nhap du lieu'
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Nhap du lieu: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              // textBox content
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Content',
                  ),
                  onChanged: (text) {
                    setState(() {
                      _task.content = text;
                    });
                  },
                ),
              ),
              // two button
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // cancel button
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Theme.of(context).colorScheme.secondary,
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            print("press cancel");
                            _contentController.text = "";
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    //khoang trong
                    const Padding(padding: EdgeInsets.all(8)),
                    // ok button
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Theme.of(context).primaryColor,
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            print(
                              "press Save",
                            );
                            //Task temp = _task;
                            setState(() {
                              this._insertTask();
                            });
                            // An modalBottomsheet , su dung Navigator
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // bottom add
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add transaction',
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 40,
        ),
        onPressed: () {
          print("Click add botton");
          this._onButtonShowModalSheet();
        },
      ),

      // contaner in the bottom
      /* bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Container(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ), */
      // adjust location of the add bottom
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // phan than
      body: Column(
        children: [
          // thanh phia tren
          Stack(
            children: <Widget>[
              // appbar
              Container(
                height: 168,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
              ),
              // Icon delete
              IconButton(
                padding: const EdgeInsets.only(
                  left: 48,
                  top: 43,
                ),
                onPressed: () {
                  print("you click delete");
                  setState(() {
                    this._deleteTask();
                  });
                },
                icon: const Icon(
                  Icons.delete_sweep_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              // Task text
              const Positioned(
                left: 48,
                top: 92,
                child: Text(
                  "Task",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Animation
              Positioned(
                top: 25,
                right: 40,
                child: Container(
                  height: 130,
                  width: 130,
                  child: Lottie.network(
                    "https://assets8.lottiefiles.com/packages/lf20_7tfxmuzv.json",
                  ),
                ),
              ),
            ],
          ),
          // phan list view
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: ListView(
                children: _tasks.map((eachTask) {
                  return ListTile(
                    // checkBox
                    leading: Transform.scale(
                      scale: 1.3,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          //Colors.amber[300]
                          unselectedWidgetColor: Theme.of(context).primaryColor,
                          //selectedRowColor: Colors.black,
                        ),
                        child: Checkbox(
                          checkColor: Colors.black,
                          activeColor: Theme.of(context).primaryColor,
                          shape: CircleBorder(),
                          value: eachTask.isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              eachTask.isChecked = value!;
                              print(eachTask.toString());
                            });
                          },
                        ),
                      ),
                    ),
                    // content
                    title: Text(
                      eachTask.content,
                      style: TextStyle(
                        fontSize: 23,
                        decoration: (eachTask.isChecked == true)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    // ontap
                    onTap: () {
                      //print("check: ${_task.isChecked}");
                      // hien thong tin them ben duoi snackBar
                      setState(() {
                        _scaffoldKey.currentState!.showSnackBar(SnackBar(
                          content: Text(
                              'Create Time: ${DateFormat.yMd().format(eachTask.createTime)}'),
                          duration: Duration(seconds: 1),
                        ));
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
