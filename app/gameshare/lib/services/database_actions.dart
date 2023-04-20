import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/review.dart';

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

List<Review> getGameReviews(int gameId) {
  final db = FirebaseFirestore.instance;
  List<Review> reviews = [];

  db.collection("games").doc(gameId.toString()).collection("reviews").get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        reviews.add(Review.fromJson(docSnapshot.data()));
      }
    },
  );

  return reviews;
}
