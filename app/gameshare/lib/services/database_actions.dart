import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/lOd.dart';
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

  for (int i = 0; i < reviews.length; i++) {
    reviews[i].likesAndDislikes = await getLikesAndDislikes(reviews[i].userEmail, reviews[i].gameId);
  }



  return reviews;
}

Future<Review?> getUserGameReview(String userEmail, int gameId) async {
  final db = FirebaseFirestore.instance;
  Review? test;

  /*return*/ await db
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
  if (test == null) return null;
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
      if (querySnapshot.docs != null && querySnapshot.docs.isNotEmpty) {
        for (var docSnapshot in querySnapshot.docs) {
          likesAndDislikes.add(LoD.fromJson(docSnapshot.data()));
        }
      }

      else {
        likesAndDislikes = [];
      }

  });

  return likesAndDislikes;
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

Future<void> deleteReview(
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

Future<String> updateUser(
  String? email, {
  String? name,
  String? about,
}) async {
  final users_ref = FirebaseFirestore.instance.collection("users");

  final data = {"userName": name, "about": about};

  final user = await users_ref.doc(email).get();

  if (!user.exists) {
    return "User does not exist";
  }

  final currUserEmail = FirebaseAuth.instance.currentUser!.email;

  final same = await users_ref.where("userName", isEqualTo: name)
                              .where("email", isNotEqualTo: currUserEmail).get();

  if (same.docs.isNotEmpty) {
    return "Username already exists";
  }

  try {
    await users_ref.doc(email).update(data);
  } catch (e) {
    return "Error updating user";
  }

  return "User updated successfully";
}
