import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Ingredient extends Equatable with ChangeNotifier {
  int? _id;
  String _name;

  int? get id => this._id;
  set id(int? value) => _id = value;

  String get name => _name;
  set name(String value) => _name = value;

  Ingredient(String name) : _name = name;
  Ingredient.id({required int id, required String name})
      : _id = id,
        _name = name;

  Map<String, Object?> toMap() {
    return {
      'id': id ?? -1,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id];
}
