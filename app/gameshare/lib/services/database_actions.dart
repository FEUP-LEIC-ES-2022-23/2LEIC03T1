import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gameshare/services/auth.dart';

import '../model/review.dart';
import '../model/user.dart';

void addReview(int rating, String reviewText, int gameId, String gameName) {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;
  var ref;

  final reviewData = {
    "rating": rating,
    "text": reviewText,
    "gameId": gameId,
    "userEmail": auth!.email,
    "gameName": gameName,
  };
  ref =
      db.collection("games").doc(gameId.toString()).collection("reviews").doc();
  ref.set(reviewData);
  ref = db.collection("users").doc(auth.email).collection("reviews").doc();
  ref.set(reviewData);
}

Future<void> addUser(String name, String email) async {
  final db = FirebaseFirestore.instance;
  var ref;

  final usersData = {
    "userName": name,
    "email": email,
    "about": "",
    "image": "",
    "creationTimestamp": FieldValue.serverTimestamp(),
  };

  ref = db.collection("users").doc(email);
  await ref.set(usersData);
}

Future<Users> getUserInfo(String email, FirebaseFirestore firestore) async {
  final db = firestore;
  return await db
      .collection("users")
      .where("email", isEqualTo: email)
      .get()
      .then(
    (querySnapshot) {
      return Users.fromJson(querySnapshot.docs.first.data());
    },
  );
}

Future<List<Review>> getGameReviews(int gameId) async {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;
  final authEmail = auth == null ? '' : auth.email;
  List<Review> reviews = [];

  await db
      .collection("games")
      .doc(gameId.toString())
      .collection("reviews")
      .where("userEmail", isNotEqualTo: authEmail)
      .get()
      .then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        if (docSnapshot.data()['userEmail'] != authEmail) {
          reviews.add(Review.fromJson(docSnapshot.data()));
        }
      }
    },
  );

  return reviews;
}

Future<Review?> getUserGameReview(String userEmail, int gameId) async {
  final db = FirebaseFirestore.instance;
  Review? test;

  return await db
      .collection("users")
      .doc(userEmail)
      .collection("reviews")
      .where("gameId", isEqualTo: gameId)
      .get()
      .then((querySnapshot) {
    test = querySnapshot.docs.isNotEmpty
        ? Review.fromJson(querySnapshot.docs[0].data())
        : null;
    return test;
  });
}

Future<List<Review>> getUserGameReviews(
    String userEmail, FirebaseFirestore firestore) async {
  final db = firestore;
  List<Review> reviews = [];

  await db
      .collection("users")
      .doc(userEmail)
      .collection("reviews")
      .get()
      .then((querySnapshot) {
    for (var docSnapshot in querySnapshot.docs) {
      reviews.add(Review.fromJson(docSnapshot.data()));
    }
  });

  return reviews;
}

Future<void> deleteReview (
    String userEmail, int gameId, FirebaseFirestore firebaseFirestore) async {
  final db = FirebaseFirestore.instance;

  final gameRef = db
      .collection('games')
      .doc(gameId.toString())
      .collection('reviews')
      .where('userEmail', isEqualTo: userEmail);

  await gameRef.get().then((querySnapshot) {
    for (var docSnapshot in querySnapshot.docs) {
      docSnapshot.reference.delete();
    }
  });

  final userRef = db
      .collection('users')
      .doc(userEmail)
      .collection('reviews')
      .where('gameId', isEqualTo: gameId);

  await userRef.get().then((querySnapshot) {
    for (var docSnapshot in querySnapshot.docs) {
      docSnapshot.reference.delete();
    }
  });
}
