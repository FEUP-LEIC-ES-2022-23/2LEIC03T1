import 'package:flutter/material.dart';

class RatingFormField extends StatelessWidget {
  int rating = 0;
  final FormFieldValidator<int>? validator;

  RatingFormField({
    Key? key,
    required this.validator,
  });

  Widget getIcon(int index, int rating) {
    Icon icon;

    if (index >= rating) {
      icon = const Icon(
        Icons.videogame_asset_outlined,
        color: Colors.green, // TODO: Use themeData
        size: 50,
      );
    } else {
      icon = const Icon(
        Icons.videogame_asset,
        color: Colors.green, // TODO: Use themeData
        size: 50,
      );
    }

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
        autovalidateMode: AutovalidateMode.disabled,
        initialValue: rating,
        validator: validator,
        builder: (formState) {
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                for (int i = 0; i < 5; i++)
                  InkResponse(
                    onTap: () {
                      rating = i + 1;
                      formState.didChange(rating);
                    },
                    child: getIcon(i, rating),
                  )
              ]),
              if (formState.hasError)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formState.errorText!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
            ],
          );
        });
  }
}

/*
class RatingFormField extends FormField<int> {
  RatingFormField({
    Key? key,
    FormFieldSetter<int>? onSaved,
    FormFieldValidator<int>? validator,
    int rating = 0,
    AutovalidateMode autovalidate = AutovalidateMode.disabled,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: rating,
            autovalidateMode: autovalidate,
            builder: (FormFieldState<int> state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      //state.didChange(state.value - 1);
                    },
                  ),
                  Text(state.value.toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      //state.didChange(state.value + 1);
                    },
                  ),
                ],
              );
            });
}*/
