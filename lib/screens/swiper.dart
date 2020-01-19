import 'dart:convert';

import 'package:desi_mingle/components/profile_card.dart';
import 'package:desi_mingle/models/user.dart';
import 'package:desi_mingle/utilities/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import "../services/api/user-api.service.dart" as apiService;

class SwiperController extends StatefulWidget {
  SwiperController({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SwiperControllerState createState() => _SwiperControllerState();
}

class _SwiperControllerState extends State<SwiperController> {
  List<User> users = new List();

  @override
  void initState() {
    super.initState();
    this._getUsers();
  }

  _getUsers() async {
    await apiService.getUsers().then((users) {
      // printWrapped("Users: ");
      // print(jsonEncode(users));
      this.users = users;
    }).catchError((error) {
      this.users = new List<User>();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: new Swiper(
        layout: SwiperLayout.TINDER,
        customLayoutOption:
            new CustomLayoutOption(startIndex: -1, stateCount: 3)
                .addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate([
          new Offset(-370.0, -40.0),
          new Offset(0.0, 0.0),
          new Offset(370.0, -40.0)
        ]),
        itemWidth: screenSize.width - 20,
        itemHeight: screenSize.height - 20,
        itemBuilder: (BuildContext context, int index) {
          // var img = "assets/images/sahaj" + ((index + 1).toString()) + ".jpg";
          // Profile profile = new Profile(
          //   img,
          //   "Sahaj Arora",
          //   "Development Manager",
          //   "What's not to like?",
          // );
          print("users: ");
          print(this.users);
          return new ProfileCardWidget(
            user: this.users[index],
          );
        },
        itemCount: users.length,
        pagination: null,
        control: null,
      ),
    );
  }
}
