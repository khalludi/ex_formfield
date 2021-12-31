import 'package:flutter/material.dart';

class MyReorderableField<T> extends StatelessWidget {

  MyReorderableField({
    Key? key,
    required this.onChanged,
    required this.values,
    required this.controllers,
  }) : super( key: key );

  ValueChanged<List> onChanged;
  List<String> values;
  List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ReorderableListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          children: <Widget>[
            for (int index = 0; index < values.length; index++)
              Focus(
                key: Key('item ${index}'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controllers[index],
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: 'Step ${index+1}'
                        ),
                        textInputAction: TextInputAction.next,
                        // ↓ Handle focus change on Next / Done soft keyboard keys
                        onEditingComplete: () {
                          print('Name editing complete');
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      child: const Icon(Icons.delete),
                      onPressed: () {
                        values.removeAt(index);
                        controllers.removeAt(index);
                        onChanged(values);
                      },
                    ),
                    const SizedBox(width: 40,)
                  ],
                ),
                canRequestFocus: false,
                // ↓ Focus widget handler e.g. user taps elsewhere
                onFocusChange: (hasFocus) {
                  if (!hasFocus)  {
                    values[index] = controllers[index].text;
                    onChanged(values);
                  }
                },
              ),
          ],
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final String item = values.removeAt(oldIndex);
            values.insert(newIndex, item);
            onChanged(values);
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.green)
              )
            )
          ),
          onPressed: () {
            values.add('');
            controllers.add(TextEditingController());
            onChanged(values);
          },
          child: Text('Add Step')
        )
      ],
    );
  }
}