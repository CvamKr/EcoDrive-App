import 'package:ecodrive/pages/plans.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';

class Selectdate extends StatefulWidget {
  @override
  _SelectdateState createState() => _SelectdateState();
}

class _SelectdateState extends State<Selectdate> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime startDate;
  DateTime endDate;

  DateFormat formatDate = DateFormat('dd/MM/yyyy');

  String _dropDownValue;

  TextEditingController couponController = TextEditingController();
  bool isCouponCodeApplied = false;

  int noOfDays = 0;
  double discount = 0;

  bool IsAvailable() {
    //check availablity from the database.
    return true;
  }

  List<String> couponCodes = [
    'ECO15',
    'ECO40',
    'ECO50',
  ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //     totalAmount = noOfDays * 250;

  // }

  List<DateTime> picked = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Book your ride',
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          height: 60,
                          child: Container(
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                startDate == null
                                    ? 'Start Date'
                                    : formatDate.format(startDate),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          height: 60,
                          child: Container(
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                endDate == null
                                    ? 'End Date'
                                    : formatDate.format(endDate),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                    color: Colors.green,
                    textColor: Colors.black,
                    onPressed: () async {
                      // final List<DateTime> picked =
                      picked = await DateRangePicker.showDatePicker(
                        context: context,
                        initialFirstDate: DateTime.now(),
                        initialLastDate: (DateTime.now()).add(
                          Duration(days: 7),
                        ),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked.length == 2) {
                        setState(
                          () {
                            startDate = picked[0];
                            endDate = picked[1];
                            debugPrint('${startDate.day.toString()}');
                            debugPrint('${endDate.day.toString()}');
                            noOfDays = (endDate.day - startDate.day) + 1;
                            debugPrint('${noOfDays * 5}');
                          },
                        );
                      }
                    },
                    child: Text(
                      'Pick Dates',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 32,
                  //   ),
                  //   child: DropdownButton<String>(
                  //     hint: Text('Please select an option'),
                  //     isExpanded: true,
                  //     isDense: true,
                  //     elevation: 3,
                  //     value: _dropDownValue,
                  //     items: [
                  //       DropdownMenuItem(
                  //         value: 'Daily',
                  //         child: Row(
                  //           children: <Widget>[
                  //             Text(
                  //               'Daily',
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       DropdownMenuItem(
                  //         value: 'Weekly',
                  //         child: Row(
                  //           children: <Widget>[
                  //             Text('Weekly'),
                  //           ],
                  //         ),
                  //       ),
                  //       DropdownMenuItem(
                  //         value: 'Monthly',
                  //         child: Row(
                  //           children: <Widget>[
                  //             Text('Monthly'),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //     onChanged: (value) {
                  //       setState(
                  //         () {
                  //           _dropDownValue = value;
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),

                  picked != null
                      ? IsAvailable != null
                          ? Text('Available!',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.green))
                          : Text('Sorry Not Available. Change Dates',
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.red))
                      : Container(),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 16.0, right: 16.0),
                    child: Card(
                      color: Colors.grey[100],
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 18.0, left: 8.0, right: 8.0),
                              child: Text('Booking Details',
                                  style: TextStyle(fontSize: 18.0)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 4.0, left: 8.0, right: 8.0),
                              child: Text('No of days: $noOfDays',
                                  style: TextStyle(fontSize: 14.0)),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 4.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text('Amount:',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      )),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  isCouponCodeApplied
                                      ? Text('Rs ${noOfDays * basePrice}',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough))
                                      : Text('Rs ${noOfDays * basePrice}',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  isCouponCodeApplied
                                      ? Text(
                                          ' ${noOfDays * basePrice - (getApplicableDiscount())}    [${getApplicableDiscount()} off!] ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Container(),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                ],
                              ),
                            ),
                            isCouponCodeApplied
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Coupon applied successfully!!',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.green),
                                    ),
                                  )
                                : Container(height: 8.0),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                onChanged: (val) {
                                  // initiateSearch(val);
                                },
                                controller: couponController,
                                // keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Enter coupon code",
                                    hintText: "",
                                    errorStyle: TextStyle(
                                        color: Colors.white, fontSize: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0))),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                width: double.infinity,
                                child: RaisedButton(
                                  color: Colors.blue[100],
                                  child: Text('Apply Coupon'),
                                  onPressed: () {
                                    setState(() {
                                      if (couponCodes
                                          .contains(couponController.text)) {
                                        if (isCouponCodeApplied) {
                                          final snackBar = SnackBar(
                                              content: Text(
                                                  "You greedy! Coupon code already applied."));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
                                          _scaffoldKey.currentState
                                              .showSnackBar(snackBar);
//Scaffold.of(context).showSnackBar(snackBar);
                                        } else {
                                          if (couponController.text.isEmpty) {
                                            final snackBar = SnackBar(
                                                content: Text(
                                                    "Coupon code can't be empty"));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
                                            _scaffoldKey.currentState
                                                .showSnackBar(snackBar);
//Scaffold.of(context).showSnackBar(snackBar);
                                          } else {
                                            this.isCouponCodeApplied = true;
                                            // couponController.text = '';
                                          }
                                        }
                                      } else {
                                        final snackBar = SnackBar(
                                            content: Text("Invalid Coupon"));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
                                        _scaffoldKey.currentState
                                            .showSnackBar(snackBar);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Align(
                  //       alignment: Alignment.bottomLeft,
                  //       child: Container(
                  //           child: Text(
                  //         'Offers',
                  //         style: TextStyle(fontSize: 24.0),
                  //         textAlign: TextAlign.left,
                  //       ))),
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 100.0,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.blue,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'code ECO15. 15% off!',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.green,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'code ECO40. 40% off!',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.pink,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'code ECO50. 50% off!',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Material(
            color: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: bookDrive,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Book',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void bookDrive() {
    if (startDate == null || endDate == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Container(
            height: 30.0,
            child: Text(
              'Please Select Date',
            ),
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlansPage()),
    );
  }

  int basePrice = 250;
  double getApplicableDiscount() {
    String enteredCoupon = couponController.text;
    // if (enteredCoupon == 'ECO15') {
      if (noOfDays >= 15 && noOfDays < 30) {
        // if (couponController.text=='ECO14') {
        return discount = noOfDays * basePrice * 0.15;
      }
      // debugPrint(couponController.text);
    // }
     else {
      final snackBar =
          SnackBar(content: Text("Only ECO15 is valid for 15 days."));

// Find the Scaffold in the widget tree and use it to show a SnackBar.
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    if (noOfDays >= 30 && noOfDays < 60) {
      return discount = noOfDays * basePrice * 0.4;
    }
    if (noOfDays == 60) {
      return discount = noOfDays * basePrice * 0.5;
    }
  }
}
