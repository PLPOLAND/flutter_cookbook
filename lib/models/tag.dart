/// `Tag` is a class that represents a tag
class Tag {
  int? _id;
  String _name;

  /// The [id] of the tag
  int? get id => this._id;
  set id(int? value) => this._id = value;

  /// The [name] of the tag
  String get name => this._name;
  set name(String value) => this._name = value;

  Tag(String name) : _name = name;
  Tag.id({required int id, required String name})
      : _id = id,
        _name = name;

  Map<String, Object?> toMap() {
    return {
      'id': id ?? -1,
      'name': name,
    };
  }
}
