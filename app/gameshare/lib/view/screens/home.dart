import 'package:flutter/material.dart';

import '../../consts/themeData.dart';
import '../../services/darkThemePrefs.dart';
import '../components/lightDarkModeButton.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: const Text('GameShare'),
          flexibleSpace: lightDarkModeButton(),
        ),
        body: Scaffold(
          body: Scaffold(

            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  <Widget>[
                  Text(
                    'Home',
                    style:TextStyle(fontSize: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );

  }
}