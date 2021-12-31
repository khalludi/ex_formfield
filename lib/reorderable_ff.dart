import 'package:ex_formfield/reorderable_field.dart';
import 'package:flutter/material.dart';

import 'multiselection_field.dart';

class MyReorderableFormField<T> extends FormField<List<T>> {

  final InputDecoration decoration;

  MyReorderableFormField({
    Key? key,
    this.decoration = const InputDecoration(),
    FormFieldSetter<List>? onSaved,
    FormFieldValidator<List>? validator,
  }) : super(key: key,
      onSaved: onSaved,
      validator: validator,
      builder: (FormFieldState<List> field) {
        final InputDecoration effectiveDecoration =
        decoration.applyDefaults(
          Theme.of(field.context).inputDecorationTheme,
        );
        return InputDecorator(
          decoration: effectiveDecoration.copyWith(errorText: field.errorText),
          isEmpty: field.value?.isEmpty ?? true,
          child: MyReorderableField(
            values: field.value?.map((e) => e.toString()).toList() ?? [],
            onChanged: field.didChange,
            controllers: field.value?.map((e) => TextEditingController(text: e)).toList() ?? [],
          ),
        );
      }
  );
}