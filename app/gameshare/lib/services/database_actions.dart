import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/review.dart';
import '../model/user.dart';

void addReview(int rating, String reviewText, int gameId) {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance.currentUser;
  var ref;
  var data;

  final reviewData = {
    "rating": rating,
    "text": reviewText,
    "gameId": gameId,
    "userEmail": auth!.email,
  };
  ref =
      db.collection("games").doc(gameId.toString()).collection("reviews").doc();
  ref.set(reviewData);
  ref = db.collection("users").doc(auth.email).collection("reviews").doc();
  ref.set(reviewData);
}

void addUser(String name, String email) {
  final db = FirebaseFirestore.instance;
  var ref;

  final usersData = {
    "userName": name,
    "email": email,
    "about": "",
    "image": "",
  };

  ref = db.collection("users").doc(email);
  ref.set(usersData);
}

Future<Users> getUserInfo(String email) async {
  final db = FirebaseFirestore.instance;
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
  final authEmail = auth ?? '';
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

  await db
      .collection("users")
      .doc(userEmail)
      .collection("reviews")
      .where("gameId", isEqualTo: gameId)
      .get()
      .then((querySnapshot) {
    test = querySnapshot.docs.isNotEmpty
        ? Review.fromJson(querySnapshot.docs[0].data())
        : null;
  });

  return test;
}

Future<List<Review>> getUserGameReviews(String userEmail) async {
  final db = FirebaseFirestore.instance;
  List<Review> reviews=[];

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


