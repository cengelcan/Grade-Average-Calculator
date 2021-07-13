import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String lessonName;
  int lessonCredit = 1;
  double lessonLetterValue = 4;
  late List<Lesson> allLessons = [];
  static int counter = 0;

  var formKey = GlobalKey<FormState>();
  double average = 0;

  @override
  void initState() {
    super.initState();
    allLessons = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Grade Average"),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  allLessons.clear();
                });
              },
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
          }
        },
        child: Icon(Icons.bookmark_add),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return appBody();
        } else {
          return appBodyLandscape();
        }
      }),
    );
  }

  Widget appBody() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Add Lesson",
                      hintText: "Write Lesson Name",
                      hintStyle: TextStyle(fontSize: 18),
                      labelStyle: TextStyle(fontSize: 22),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (enteredValue) {
                      if (enteredValue!.length > 0) {
                        return null;
                      } else
                        return "Lesson name can not be empty!";
                    },
                    onSaved: (savedValue) {
                      lessonName = savedValue!;
                      setState(() {
                        allLessons.add(Lesson(
                            lessonName, lessonLetterValue, lessonCredit));
                        average = 0;
                        calculateAverage();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: lessonCreditsItems(),
                            value: lessonCredit,
                            onChanged: (selectedCredit) {
                              setState(() {
                                lessonCredit = selectedCredit!;
                              });
                            },
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            items: lessonLetterValuesItems(),
                            value: lessonLetterValue,
                            onChanged: (selectedLetter) {
                              setState(() {
                                lessonLetterValue = selectedLetter!;
                              });
                            },
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            decoration: BoxDecoration(
                color: Colors.blue,
                border: BorderDirectional(
                  top: BorderSide(color: Colors.blue, width: 2),
                  bottom: BorderSide(color: Colors.blue, width: 2),
                )),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: allLessons.length == 0
                            ? " Add lesson "
                            : "Average : ",
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                    TextSpan(
                        text: allLessons.length == 0
                            ? ""
                            : "${average.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
                  child: ListView.builder(
            itemBuilder: _createListItems,
            itemCount: allLessons.length,
          ))),
        ],
      ),
    );
  }

  Widget appBodyLandscape() {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Add Lesson",
                          hintText: "Write Lesson Name",
                          hintStyle: TextStyle(fontSize: 18),
                          labelStyle: TextStyle(fontSize: 22),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        validator: (enteredValue) {
                          if (enteredValue!.length > 0) {
                            return null;
                          } else
                            return "Lesson name can not be empty!";
                        },
                        onSaved: (savedValue) {
                          lessonName = savedValue!;
                          setState(() {
                            allLessons.add(Lesson(
                                lessonName, lessonLetterValue, lessonCredit));
                            average = 0;
                            calculateAverage();
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                items: lessonCreditsItems(),
                                value: lessonCredit,
                                onChanged: (selectedCredit) {
                                  setState(() {
                                    lessonCredit = selectedCredit!;
                                  });
                                },
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<double>(
                                items: lessonLetterValuesItems(),
                                value: lessonLetterValue,
                                onChanged: (selectedLetter) {
                                  setState(() {
                                    lessonLetterValue = selectedLetter!;
                                  });
                                },
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: BorderDirectional(
                        top: BorderSide(color: Colors.blue, width: 2),
                        bottom: BorderSide(color: Colors.blue, width: 2),
                      )),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: allLessons.length == 0
                                  ? " Add Lesson "
                                  : "Average : ",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                          TextSpan(
                              text: allLessons.length == 0
                                  ? ""
                                  : "${average.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              itemBuilder: _createListItems,
              itemCount: allLessons.length,
            ),
          ),
        ),
      ],
    ));
  }

  List<DropdownMenuItem<int>> lessonCreditsItems() {
    List<DropdownMenuItem<int>> credits = [];

    for (int i = 1; i <= 10; i++) {
      credits.add(DropdownMenuItem<int>(
        value: i,
        child: Text(
          "$i Credit",
          style: TextStyle(fontSize: 20),
        ),
      ));
    }

    return credits;
  }

  List<DropdownMenuItem<double>> lessonLetterValuesItems() {
    List<DropdownMenuItem<double>> letters = [];
    letters.add(DropdownMenuItem(
      child: Text(
        " AA ",
        style: TextStyle(fontSize: 20),
      ),
      value: 4,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        " BA ",
        style: TextStyle(fontSize: 20),
      ),
      value: 3.5,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        " BB ",
        style: TextStyle(fontSize: 20),
      ),
      value: 3,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        " CB ",
        style: TextStyle(fontSize: 20),
      ),
      value: 2.5,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        " CC ",
        style: TextStyle(fontSize: 20),
      ),
      value: 2,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        " DC ",
        style: TextStyle(fontSize: 20),
      ),
      value: 1.5,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        " DD ",
        style: TextStyle(fontSize: 20),
      ),
      value: 1,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        " FF ",
        style: TextStyle(fontSize: 20),
      ),
      value: 0,
    ));

    return letters;
  }

  Widget _createListItems(BuildContext context, int index) {
    counter++;
    debugPrint(counter.toString());

    return Dismissible(
      key: Key(counter.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          allLessons.removeAt(index);
          calculateAverage();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(4),
        child: ListTile(
          leading: Icon(
            Icons.bookmark,
            size: 36,
            color: Colors.blue,
          ),
          title: Text(allLessons[index].name),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.blue,
          ),
          subtitle: Text(allLessons[index].credit.toString() +
              " Credits Lesson Grade Value: " +
              allLessons[index].letterValue.toString()),
        ),
      ),
    );
  }

  void calculateAverage() {
    double totalGrade = 0;
    double totalCredit = 0;

    for (var currentLesson in allLessons) {
      var credit = currentLesson.credit;
      var letterValue = currentLesson.letterValue;

      totalGrade = totalGrade + (letterValue * credit);
      totalCredit += credit;
    }

    average = totalGrade / totalCredit;
  }
}

class Lesson {
  String name;
  double letterValue;
  int credit;

  Lesson(this.name, this.letterValue, this.credit);
}
