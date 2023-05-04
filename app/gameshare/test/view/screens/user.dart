import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gameshare/view/components/circular_progress.dart';

import 'package:gameshare/view/components/text_utils/text_section.dart';
import 'package:gameshare/view/screens/login.dart';
import 'package:gameshare/view/screens/user.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import '../../mocks.dart';

void main() {
  testWidgets('Login screen has expected text', (WidgetTester tester) async {
    final MockUser user= MockUser(email: "souLindo@gmail.com");
    final FakeFirebaseFirestore fireStore= FakeFirebaseFirestore();
    fireStore.collection("users").add({
        "userName": "Soulindo",
        "email": "souLindo@gmail.com",
        "about": "I am extreme lindo",
        "image": "",
        "creationTimestamp":FieldValue.serverTimestamp(),
    }
    );
    await tester.pumpWidget(MaterialApp(home: UserPage(user: user.email!, isUser: true,firestore: fireStore,)));
    await tester.pumpFrames(MaterialApp(home: UserPage(user: user.email!, isUser: true,firestore: fireStore,)), Duration(seconds: 10));

    expect( find.text('Email: souLindo@gmail.com'), findsOneWidget);
    expect( find.text('Soulindo'), findsOneWidget);
    expect( find.text('I am extreme lindo'), findsOneWidget);
    expect( find.byType(UserName), findsOneWidget);
    expect( find.byType(UserEmail), findsOneWidget);
    expect( find.byType(MyReviews), findsOneWidget);
    expect( find.byType(TextSection), findsOneWidget);
    expect( find.byType(Logout), findsOneWidget);
    expect( find.byType(EditProfile), findsOneWidget);
  });

}