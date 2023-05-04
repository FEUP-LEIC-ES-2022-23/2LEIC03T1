import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/lOd.dart';
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
    "likesAndDislikes": List<LoD>.empty(),
  };

  ref = db.collection("games").doc(gameId.toString()).collection("reviews").doc();
  ref.set(reviewData);
  ref = db.collection("users").doc(auth.email).collection("reviews").doc();
  ref.set(reviewData);
}

void addLikeOrDislike(int gameId, String userEmail, int likeOrDislike) async {
  try {
    final db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance.currentUser;
    final likeData = {
      "userEmail": auth!.email,
      "likeOrDislike": likeOrDislike,
    };
    await db
        .collection("games")
        .doc(gameId.toString())
        .collection("reviews")
        .doc(userEmail)
        .collection("likesAndDislikes")
        .doc()
        .set(likeData, SetOptions(merge: true));
  } catch (e) {
    print('Erro ao adicionar like ou dislike: $e');
  }
}


void removeLikeOrDislike(int gameId, String userEmail, int likeOrDislike) async {
  try {
    final db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance.currentUser;
    final likeData = {
      "userEmail": auth!.email,
      "likeOrDislike": likeOrDislike,
    };
    final ref = db
        .collection("games")
        .doc(gameId.toString())
        .collection("reviews")
        .doc(userEmail)
        .collection("likesAndDislikes")
        .where("userEmail", isEqualTo: auth.email)
        .where("likeOrDislike", isEqualTo: likeOrDislike);
    final snapshot = await ref.get();
    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.first.id;
      await db
          .collection("games")
          .doc(gameId.toString())
          .collection("reviews")
          .doc(userEmail)
          .collection("likesAndDislikes")
          .doc(docId)
          .delete();
    }
  } catch (e) {
    print('Erro ao remover like ou dislike: $e');
  }
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

  getLikesAndDislikes(userEmail, gameId);
  test!.likesAndDislikes = await getLikesAndDislikes(userEmail, gameId);

  return test;

}

Future<List<LoD>> getLikesAndDislikes(String userEmail, int gameId) async {
  final db = FirebaseFirestore.instance;
  List<LoD> likesAndDislikes = [];

  await db
      .collection("games")
      .doc(gameId.toString())
      .collection("reviews")
      .doc(userEmail)
      .collection("likesAndDislikes")
      .get()
      .then((querySnapshot) {
    likesAndDislikes = querySnapshot.docs != null &&
        querySnapshot.docs.isNotEmpty
        ? querySnapshot.docs[0].data()['likesAndDislikes']
        : [];
  });

  return likesAndDislikes;
}
