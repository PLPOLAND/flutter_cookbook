import 'package:flutter/material.dart';
import '../models/tag.dart';

class TagsProvider with ChangeNotifier {
  List<Tag> _tags = [];

  List<Tag> get tags {
    return [..._tags];
  }

  /// Get the next available id for a tag
  int get _getNextId {
    int nextId = 0;
    for (int i = 0; i < _tags.length; i++) {
      if (_tags.where((tag) => tag.id == nextId).isEmpty) {
        break;
      } else {
        nextId++;
      }
    }
    return nextId;
  }

  /// Add a [tag] to the list of tags
  /// If the [tag] [id] is null, then set the [tag] [id] to the next available id
  void addTag(Tag tag) {
    tag.id ??= _getNextId;
    _tags.add(tag);
    notifyListeners();
  }

  void removeTag(Tag tag) {
    _tags.remove(tag);
    notifyListeners();
  }

  /// Remove the [tag] from the list of tags if the [tag] [id] matches the id passed in
  void removeTagById(int id) {
    _tags.removeWhere((tag) => tag.id == id);
    notifyListeners();
  }

  /// Find the index of the [tag] with the same [id] as the [tag] passed in, then replace the [tag]
  void updateTag(Tag tag) {
    final index = _tags.indexWhere((element) => element.id == tag.id);
    _tags[index] = tag;
    notifyListeners();
  }

  Tag getTagById(int id) {
    return _tags.firstWhere((tag) => tag.id == id);
  }

  void setTags(List<Tag> tags) {
    _tags = tags;
    notifyListeners();
  }

  void clearTags() {
    _tags = [];
    notifyListeners();
  }

  bool containsTag(Tag tag) {
    return _tags.contains(tag);
  }

  bool containsTagById(int id) {
    return _tags.any((tag) => tag.id == id);
  }

  int get tagsCount {
    return _tags.length;
  }

  bool get isEmpty {
    return _tags.isEmpty;
  }

  bool get isNotEmpty {
    return _tags.isNotEmpty;
  }

  @override
  String toString() {
    return _tags.toString();
  }
}
