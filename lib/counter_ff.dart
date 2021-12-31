import 'package:flutter/material.dart';

class CounterFormField extends FormField<int> {
  InputDecoration decoration;

  CounterFormField({
    Key? key,
    this.decoration = const InputDecoration(),
    FormFieldSetter<int>? onSaved,
    FormFieldValidator<int>? validator,
    int initialValue = 0,
    bool autovalidate = false
  }) : super(
      key: key,
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      autovalidateMode: autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      builder: (FormFieldState<int> state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                state.didChange(state.value! - 1);
              },
            ),
            Text(
                state.value.toString()
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                state.didChange(state.value! + 1);
              },
            ),
          ],
        );
      }
  );
}