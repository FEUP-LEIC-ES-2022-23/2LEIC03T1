import 'package:flutter/material.dart';
import 'package:gameshare/view/components/TopBar.dart';

import '../../services/providers/ScrollProvider.dart';
import '../components/NavBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: TopBar(),

      body: Container(

        child: ListView(
          scrollDirection: Axis.vertical,
          controller: ScrollProvider().controller,
            children: [
            Container(
              child: Text("hello"),
              height: 2000,
            ),

          ],
      ),

        ),

      bottomNavigationBar: NavBar(),

    );
  }
}
