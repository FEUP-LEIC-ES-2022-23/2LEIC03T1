import 'package:flutter/material.dart';
import 'package:gameshare/view/components/rating_form_field.dart';
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

            RatingFormField(validator: (value) {
              if (value == 0) {
                return 'Please select a rating';
              }
              return null;
            }),

            const addVerticalSpace(size: 10),

            const LeftCenteredTitle(
              text: 'Write a comment',
              textSize: 20,
            ),

            const addVerticalSpace(size: 10),


            TextFormField(
              maxLines: 8,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green.shade400, width: 2.0),
                ),
                errorBorder: const OutlineInputBorder(),
                border: const OutlineInputBorder(),
                hintText: 'Review',
                fillColor: Colors.black),
                validator: (value) {
                  if (value!.length > 1000) {
                    return "Your review can't have more than 1000 characters";
                  }
                },
            ),

            const addVerticalSpace(size: 10),

            ReviewFormButton(formKey: _formKey)
          ],
        ),
      ),
    );
  }
}

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
          )
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
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

