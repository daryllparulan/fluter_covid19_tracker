import 'package:flutter/material.dart';
import 'package:flutter_covid19_tracker/screens/country.dart';
import 'package:flutter_covid19_tracker/screens/global.dart';
import 'package:flutter_covid19_tracker/screens/naivigation_option.dart';
import 'package:flutter_covid19_tracker/utils/constants.dart';

enum NavigationStatus { GLOBAL, COUNTRY }

class Tracker extends StatefulWidget {
  const Tracker({Key? key}) : super(key: key);

  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  NavigationStatus navigationStatus = NavigationStatus.GLOBAL;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: const Text('COVID-19 Tracker Live Data'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                )),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: navigationStatus == NavigationStatus.GLOBAL
                  ? const Global()
                  : const Country(),
            ),
          )),
          SizedBox(
            height: size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavigationOption(
                    title: "Global",
                    selected: navigationStatus == NavigationStatus.GLOBAL,
                    onSelected: () {
                      setState(() {
                        navigationStatus = NavigationStatus.GLOBAL;
                      });
                    }),
                NavigationOption(
                    title: "Country",
                    selected: navigationStatus == NavigationStatus.COUNTRY,
                    onSelected: () {
                      setState(() {
                        navigationStatus = NavigationStatus.COUNTRY;
                      });
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
