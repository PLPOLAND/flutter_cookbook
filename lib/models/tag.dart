/// `Tag` is a class that represents a tag
class Tag extends Comparable<Tag> {
  int? _id;
  String _name;

  /// The [id] of the tag
  int? get id => this._id;

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
    return this.name.compareTo(other.name);
  }

  @override
  int get hashCode => super.hashCode;
}
