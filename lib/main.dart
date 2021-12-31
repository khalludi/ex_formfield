import 'package:flutter/material.dart';

import 'counter.dart';
import 'counter_ff.dart';
import 'multiselection_ff.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _formKey = GlobalKey<FormState>();

  String _name = '';
  int _age = 0;
  List _ingredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: this._formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Please fill in your name and age'),
                TextFormField(
                  autovalidateMode: AutovalidateMode.disabled,
                  onSaved: (value) => _name = value!,
                  validator: (value) {
                    if (value!.length < 3) {
                      return
                        'a minimum of 3 characters is required';
                    }
                  },
                ),
                CounterFormField(
                  autovalidate: false,
                  validator: (value) {
                    if (value! < 0) {
                      return 'Negative values not supported';
                    }
                  },
                  onSaved: (value) => this._age = value!,
                ),
                MyMultiSelectionFormField(
                  decoration: const InputDecoration(
                    labelText: 'Ingredients',
                  ),
                  validator: (ingredients) => (ingredients?.length ?? 0) < 3
                      ? 'Please select at least 3 interests'
                      : null,
                  onSaved: (ingredients) {
                    _ingredients = ingredients!;
                  },
                ),
                RaisedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _formKey.currentState!.save();
                      });
                    }
                  },
                ),
                const SizedBox(height: 50.0),
                Text(
                    '${this._name} is ${this._age} years old'
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _ingredients.length,
                  itemBuilder: (context, index) {
                    return Text('${_ingredients[index]}, ');
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}