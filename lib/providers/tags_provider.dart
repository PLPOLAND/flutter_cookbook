import 'package:flutter/material.dart';
import 'package:cookbook/dart/exceptions/info_exception.dart';
import 'package:cookbook/helpers/db_helper.dart';
import '../models/tag.dart';

class TagsProvider with ChangeNotifier {
  List<Tag> _tags = [];

  List<Tag> get tags {
    return [..._tags];
  }

  TagsProvider() {
    fetchAndSetTags();
  }

  void fetchAndSetTags() async {
    _tags = await DBHelper.getTags();
    notifyListeners();
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
  Future<Tag> addTag(Tag tag) async {
    if (!tags.contains(tag)) {
      if (tag.id == null) {
        var newTag = Tag.id(
          id: _getNextId,
          name: tag.name,
        );
        _tags.add(newTag);
        DBHelper.insertTag(newTag);
        notifyListeners();
        return newTag;
      } else {
        _tags.add(tag);
        DBHelper.insertTag(tag);
        notifyListeners();
        return tag;
      }
    } else {
      throw InfoException('Tag already exists');
    }
  }

  void removeTag(Tag tag) {
    _tags.remove(tag);
    DBHelper.deleteTag(tag);
    notifyListeners();
  }

  /// Remove the [tag] from the list of tags if the [tag] [id] matches the id passed in
  void removeTagById(int id) {
    DBHelper.deleteTag(tags.where((element) => element.id == id).first);
    _tags.removeWhere((tag) => tag.id == id);
    notifyListeners();
  }

  /// Find the index of the [tag] with the same [id] as the [tag] passed in, then replace the [tag]
  Future<Tag> updateTag(Tag tag) async {
    final index = _tags.indexWhere((element) => element.id == tag.id);
    _tags[index] = tag;
    DBHelper.updateTag(tag);
    notifyListeners();
    return tag;
  }

  Tag getTagByID(int id) {
    return _tags.firstWhere((tag) => tag.id == id);
  }

  Future<void> clearTags() async {
    for (var tag in _tags) {
      DBHelper.deleteTag(tag);
    }
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
