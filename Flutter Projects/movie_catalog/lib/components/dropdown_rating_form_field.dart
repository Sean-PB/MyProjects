import 'package:flutter/material.dart';

class DropdownRatingFormField extends StatefulWidget {
  final int maxRating;
  final String? Function(dynamic) validator;
  final void Function(dynamic) onSaved;
  final Widget hint;

  const DropdownRatingFormField(
      {Key? key,
      required this.maxRating,
      required this.validator,
      required this.onSaved,
      required this.hint,})
      : super(key: key);

  @override
  DropdownRatingFormFieldState createState() => DropdownRatingFormFieldState();
}

class DropdownRatingFormFieldState extends State<DropdownRatingFormField> {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
        hint: widget.hint,
        value: selectedValue,
        items: ratingMenuItems(maxRating: widget.maxRating),
        onChanged: (menuItem) {
          setState(() => selectedValue = menuItem);
        },
        decoration: const InputDecoration(
          labelText: 'Rating',
          border: OutlineInputBorder()
        ),
        validator: widget.validator,
        onSaved: widget.onSaved);
  }

  List<DropdownMenuItem<int>> ratingMenuItems({required int maxRating}) {
    return List<DropdownMenuItem<int>>.generate(maxRating, (i) {
      return DropdownMenuItem<int>(value: i, child: Text('$i'));
    });
  }
}
