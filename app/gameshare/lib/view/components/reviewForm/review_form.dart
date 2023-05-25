import 'package:flutter/material.dart';
import 'package:gameshare/services/database_actions.dart';
import 'package:gameshare/services/review_form_validators.dart';
import 'package:gameshare/view/components/reviewForm/rating_form_field.dart';
import 'package:gameshare/view/components/utils/add_vertical_space.dart';
import 'package:gameshare/view/components/utils/left_centered_title.dart';

import '../../../model/game.dart';

class ReviewForm extends StatefulWidget {
  final Game game;
  final Function() notifyParent;

  const ReviewForm({super.key, required this.game, required this.notifyParent});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  String reviewText = '';
  RatingFormField ratingFormField = RatingFormField(validator: validateRating);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const LeftCenteredTitle(
              text: 'Submit a review',
              textSize: 28,
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const addVerticalSpace(size: 10),
            const LeftCenteredTitle(
              text: 'Rate the game',
              textSize: 20,
            ),
            const addVerticalSpace(size: 10),
            ratingFormField,
            const addVerticalSpace(size: 10),
            const LeftCenteredTitle(
              text: 'Write a comment',
              textSize: 20,
            ),
            const addVerticalSpace(size: 10),
            TextFormField(
              maxLines: 8,
              onSaved: (String? value) {
                reviewText = value!;
              },
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Write your review...',
                  fillColor: Colors.black),
              validator: validateReviewText,
            ),
            const addVerticalSpace(size: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: const Size(140, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    addReview(
                        ratingFormField.rating, reviewText, widget.game.gameId,widget.game.name);
                    widget.notifyParent();

                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
