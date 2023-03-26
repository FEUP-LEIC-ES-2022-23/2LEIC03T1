import 'package:flutter/material.dart';

import 'package:gameshare/view/components/TopBar.dart';

import '../../services/providers/ScrollProvider.dart';
import '../components/NavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      appBar: const TopBar(),
      body: ListView(controller: ScrollProvider.scrollController, children: [
        Container(
          height: 2000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: const NavBar(),
    );
  }
}
