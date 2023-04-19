import 'package:flutter/material.dart';
import 'package:gameshare/services/review_form_validators.dart';
import 'package:gameshare/view/components/reviewForm/rating_form_field.dart';
import 'package:gameshare/view/components/reviewForm/review_form_button.dart';
import 'package:gameshare/view/components/utils/add_vertical_space.dart';
import 'package:gameshare/view/components/utils/left_centered_title.dart';

class ReviewForm extends StatefulWidget {
  const ReviewForm({super.key});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
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

            RatingFormField(validator: validateRating),

            const addVerticalSpace(size: 10),

            const LeftCenteredTitle(
              text: 'Write a comment',
              textSize: 20,
            ),

            const addVerticalSpace(size: 10),

            TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.green.shade400, width: 2.0),
                  ),
                  border: const OutlineInputBorder(),
                  hintText: 'Review',
                  fillColor: Colors.black),
              validator: validateReviewText,
            ),

            const addVerticalSpace(size: 10),
            
            ReviewFormButton(formKey: _formKey)
          ],
        ),
      ),
    );
  }
}
