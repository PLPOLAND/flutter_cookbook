/// `Tag` is a class that represents a tag
class Tag extends Comparable<Tag> {
  /// The [id] of the tag or null if it is not in the database
  int? _id;

  /// The [name] of the tag
  String _name;

  /// The [id] of the tag
  int? get id => this._id;

  /// The [name] of the tag
  String get name => this._name;
  set name(String value) => this._name = value;

  /// Creates a new tag with the [name], the [id] is set to null
  Tag(String name) : _name = name;

  /// Creates a new tag with the [id] and [name]
  Tag.id({required int id, required String name})
      : _id = id,
        _name = name;

  /// Creates a Map from the tag fields
  Map<String, Object?> toMap() {
    return {
      'id': id ?? -1,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Tag{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tag && other.name == name;
  }

  @override
  int compareTo(Tag other) {
    return name.compareTo(other.name);
  }

  @override
  int get hashCode {
    return super.hashCode;
  }
}
