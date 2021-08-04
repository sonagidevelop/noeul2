import 'dart:ui';

import 'event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:navstackexer/database/db.dart';
import 'package:navstackexer/database/diary.dart';

// void main() {
//   initializeDateFormatting().then((_) => runApp(MyApp()));
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarView(),
    );
  }
}

class CalendarView extends StatefulWidget {
  CalendarView({
    Key? key,
  }) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

// class MyTime {
//   final
// }

class _CalendarViewState extends State<CalendarView> {
  //오류시 확인필요

  Map<DateTime, List<Event>>? selectedEvents;
  // late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime dataToSend = DateTime.now();

  Future<List<Diary>> loadDiary() async {
    DBHelper sd = DBHelper();
    return await sd.diarys();
  }

  Widget diaryBuilder() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if ((projectSnap.data as List).length == 0) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container(child: Text("메모를 추가 해 보세요"));
        } else {
          return Expanded(
              child: ListView.builder(
            itemCount: (projectSnap.data as List).length,
            itemBuilder: (context, index) {
              Diary diary = (projectSnap.data as List)[index];
              return LimitedBox(
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 5)),
                    child: Column(
                      children: <Widget>[
                        Text(
                          diary.title,
                          style: TextStyle(fontSize: 50),
                        ),
                        Text(diary.text),
                        Text(diary.id.toString()),
                        // Widget to display the list of project
                      ],
                    )),
              );
            },
          ));
        }
      },
      future: loadDiary(),
    );
  }

  // @override
  // void initState() {
  //   selectedEvents = {};
  //   super.initState();
  // }

  // List<Event> _getEvnetsfromDay(DateTime date) {
  //   //오류시 확인필요

  //   return selectedEvents?[date] ?? [];
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   _selectedDay = _focusedDay;
  //   _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  // }

  // @override
  // void dispose() {
  //   _selectedEvents.dispose();
  //   super.dispose();
  // }

  // List<Event> _getEventsForDay(DateTime day) {
  //   return events[day] ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    final urlImage1 = 'assets/001.png';
    final urlImage2 = 'assets/002.png';
    final urlImage3 = 'assets/003.png';
    int index = 3;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,

            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            availableGestures: AvailableGestures.horizontalSwipe,

            //네비게이터위치

            onDaySelected: (selectedDay, focusedDay) {
              if (_selectedDay == selectedDay) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SecondPage(received: dataToSend)));
              }
              setState(() {
                _selectedDay = selectedDay;

                _focusedDay = focusedDay;
                dataToSend = selectedDay;
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              headerPadding: EdgeInsets.all(5),
              // headerMargin: EdgeInsets.only(top: 40),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
                decoration: BoxDecoration(), weekdayStyle: TextStyle()),
            rowHeight: 90,
            daysOfWeekHeight: 60,

            //Styles
            calendarStyle: CalendarStyle(

                //꼭기억하자
                selectedDecoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(urlImage2),
                  ),
                ),
                outsideDaysVisible: false,
                cellMargin: EdgeInsets.all(1),
                todayTextStyle: TextStyle(height: -3),
                todayDecoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 22,
                  height: -2,
                  fontWeight: FontWeight.bold,
                ),
                // selectedDecoration: BoxDecoration(image: DecorationImage(image: urlIm)),

                weekendTextStyle: TextStyle(
                  color: Colors.blue,
                  height: -3,
                ),
                defaultTextStyle: TextStyle(height: -3),
                rowDecoration: BoxDecoration(),
                weekendDecoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  shape: BoxShape.circle,
                ),
                defaultDecoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  shape: BoxShape.circle,
                )),

            // calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
            //   if (day.weekday == DateTime.sunday) {
            //     final text = DateFormat.E().format(day);

            //     return Center(
            //       child: Text(
            //         text,
            //         style: TextStyle(color: Colors.red),
            //       ),
            //     );
            //   }
            // }),
          ),
          Container(
            color: Colors.blue,
            height: 300,
            child: LimitedBox(
              maxHeight: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(_selectedDay
                            .toString()
                            .split(" ")[0]
                            .split("-")[0] +
                        "년" +
                        _selectedDay.toString().split(" ")[0].split("-")[1] +
                        "월" +
                        _selectedDay.toString().split(" ")[0].split("-")[2] +
                        "일"),
                  ),
                  diaryBuilder()
                ],
              ),
            ),
          )
          // TextButton(
          //   onPressed: () {},
          //   child: Image.asset(
          //     urlImage2,
          //     height: 60,
          //     width: 60,
          //   ),
          // ),
        ],
      )),
    );
  }
}

// class Todo {
//   final String title;
//   final String description;

//   Todo(this.title, this.description);
// }

//SecondPage

class SecondPage extends StatefulWidget {
  const SecondPage({
    Key? key,
    required this.received,
  }) : super(key: key);
  final DateTime received;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // TextEditingController _eventController = TextEditingController();
  Future<void> saveDB(String? datetime, String title, String text) async {
    DBHelper sd = DBHelper();

    datetime = datetime!.split(" ")[0];
    var fido = Diary(
      id: datetime,
      title: title,
      text: text,
    );

    await sd.insertDiary(fido);

    print(await sd.diarys());
  }

  int index = 3;

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormBuilderState>();
    final urlImage1 = 'assets/001.png';
    final urlImage2 = 'assets/002.png';
    final urlImage3 = 'assets/003.png';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final dateValue =
                    _formkey.currentState?.fields['date']?.value.toString();
                final titleValue =
                    _formkey.currentState?.fields['title']?.value;
                final textValue =
                    _formkey.currentState?.fields['description']?.value;
                print(titleValue.runtimeType);
                print(dateValue.runtimeType);
                saveDB(
                  dateValue,
                  titleValue,
                  textValue,
                );
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          FormBuilder(
            key: _formkey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(index.toString()),
                    TextButton(
                      child: Image.asset(
                        urlImage1,
                        width: 50,
                        height: 50,
                      ),
                      onPressed: () {
                        index = 0;
                        setState(() {
                          height:
                          150;
                        });
                      },
                    ),
                    FlatButton(
                      child: Image.asset(
                        urlImage2,
                        width: 50,
                        height: 50,
                      ),
                      onPressed: () {
                        index = 1;
                        setState(() {
                          height:
                          150;
                        });
                      },
                    ),
                    FlatButton(
                      child: Image.asset(
                        urlImage3,
                        width: 50,
                        height: 50,
                      ),
                      onPressed: () {
                        index = 2;
                        setState(() {
                          height:
                          150;
                        });
                      },
                    ),
                    FlatButton(
                      child: Icon(Icons.favorite),
                      onPressed: () {
                        index = 3;
                      },
                    )
                  ],
                ),
                // FormBuilderField(
                //   builder: _eventController,
                //   name: _eventController,
                // ),
                FormBuilderDateTimePicker(
                  name: "date",
                  initialValue: widget.received,
                  fieldHintText: "Add Date",
                  inputType: InputType.date,
                  format: DateFormat('EEEE, dd MMMM, yyyy'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.calendar_today_sharp),
                  ),
                ),
                Divider(),
                FormBuilderTextField(
                  name: "title",
                  decoration: InputDecoration(
                    hintText: "Add Title",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 48.0),
                  ),
                ),
                Divider(),
                FormBuilderTextField(
                  name: "description",
                  maxLines: 10,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Details",
                    prefixIcon: Icon(Icons.short_text),
                  ),
                ),
                Divider(),
                FormBuilderSwitch(
                  name: "public",
                  title: Text("Public"),
                  initialValue: false,
                  controlAffinity: ListTileControlAffinity.leading,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
                Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class TableBasicsExample extends StatefulWidget {
//   @override
//   _TableBasicsExampleState createState() => _TableBasicsExampleState();
// }

// class _TableBasicsExampleState extends State<TableBasicsExample> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TableCalendar - Basics'),
//       ),
//       body: TableCalendar(
//         firstDay: DateTime.utc(2010, 10, 16),
//         lastDay: DateTime.utc(2030, 3, 14),
//         focusedDay: _focusedDay,
//         calendarFormat: _calendarFormat,
//         selectedDayPredicate: (day) {
//           // Use `selectedDayPredicate` to determine which day is currently selected.
//           // If this returns true, then `day` will be marked as selected.

//           // Using `isSameDay` is recommended to disregard
//           // the time-part of compared DateTime objects.
//           return isSameDay(_selectedDay, day);
//         },
//         onDaySelected: (selectedDay, focusedDay) {
//           if (!isSameDay(_selectedDay, selectedDay)) {
//             // Call `setState()` when updating the selected day
//             setState(() {
//               _selectedDay = selectedDay;
//               _focusedDay = focusedDay;
//             });
//           }
//         },
//         onFormatChanged: (format) {
//           if (_calendarFormat != format) {
//             // Call `setState()` when updating calendar format
//             setState(() {
//               _calendarFormat = format;
//             });
//           }
//         },
//         onPageChanged: (focusedDay) {
//           // No need to call `setState()` here
//           _focusedDay = focusedDay;
//         },
//       ),
//     );
//   }
// }
