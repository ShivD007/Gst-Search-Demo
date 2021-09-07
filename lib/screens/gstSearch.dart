import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gstsearch/model/gstProfile.dart';
import 'package:gstsearch/screens/gstProfile.dart';

class GSTSearch extends StatefulWidget {
  @override
  _GSTSearchState createState() => _GSTSearchState();
}

class _GSTSearchState extends State<GSTSearch>
    with SingleTickerProviderStateMixin {
  Color _green = Color(0xff2DA05E);
  TabController _tabController;
  TextEditingController _textEditingController;
  List gstList = [];
  List tempList = [];
  var currentFocus;
  FocusNode focusNode = new FocusNode();
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _textEditingController = TextEditingController();
    getGstList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  color: _green,
                ),
                height: size.height / 3.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Select the type for",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 6,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "GST Number Search Tool",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Color(0xff1A884B),
                        ),
                        padding: const EdgeInsets.all(3.0),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white,
                          ),
                          labelColor: _green,
                          unselectedLabelColor: Colors.white,
                          tabs: [
                            Tab(
                              text: "Search GST Number",
                            ),
                            Tab(
                              text: "GST Return Status",
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: [
                  gstserch(size),
                  Container(),
                ],
              ))
            ],
          ),
        ));
  }

  gstserch(size) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Enter GST number",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
                focusNode: focusNode,
                controller: _textEditingController,
                decoration: InputDecoration(
                  fillColor: Colors.grey[350],
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  hintText: "Ex: 07AACCM9910C1ZP",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: () {
                  tempList.clear();
                  unFocus();
                  print(gstList.length);
                  print(gstList);
                  for (var map in gstList) {
                    if (map.containsKey("gst")) {
                      if (map["gst"].toString().toLowerCase() ==
                          _textEditingController.text.toLowerCase()) {
                        tempList.add(map);
                        setState(() {});
                      }
                    }
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: _green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Search",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return GSTProfile(tempList[index]);
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "GSTIN of the Tax Payer",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${tempList[index]["gst"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: tempList.length,
            )
          ],
        ),
      ),
    );
  }

  unFocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future<void> getGstList() async {
    final data = await rootBundle.loadString("assets/gstprofile.json");
    gstList = await json.decode(data);
    setState(() {});
  }
}
