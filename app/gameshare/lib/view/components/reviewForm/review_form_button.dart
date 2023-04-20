import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewFormButton extends StatelessWidget {
  const ReviewFormButton({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade400,
            fixedSize: const Size(140, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final db = FirebaseFirestore.instance;
            db.collection("games").doc("1234").set({"rating": 3});
          }
        },
        child: const Text(
          'Submit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
