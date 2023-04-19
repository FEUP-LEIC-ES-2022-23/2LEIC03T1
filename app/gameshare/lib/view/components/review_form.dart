import 'package:flutter/material.dart';
import 'package:gameshare/view/components/rating_form_field.dart';

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
              textSize: 30,
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const LeftCenteredTitle(
              text: 'Rate the game',
              textSize: 20,
            ),
            RatingFormField(validator: (value) {
              if (value == 0) {
                return 'Please select a rating';
              }
              return null;
            }),
            const LeftCenteredTitle(
              text: 'Write a comment',
              textSize: 20,
            ),
            TextFormField(
              maxLines: 8,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Review',
                  fillColor: Colors.black),
              validator: (value) {
                if (value!.length > 1000) {
                  return "Your review can't have more than 1000 characters";
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}

class LeftCenteredTitle extends StatelessWidget {
  const LeftCenteredTitle({
    super.key,
    required this.text,
    required this.textSize,
  });

  final double textSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
