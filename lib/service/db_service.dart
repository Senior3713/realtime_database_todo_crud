import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

sealed class DbService {
  static final _db = FirebaseDatabase.instance.ref().child(baseName);
  static const baseName = "Todos";
  static const titleKey = "title";
  static const descriptionKey = "description";

  static void addTodo(String title, String description) {
    try {
      final Map<String, String> newTodo = {
        titleKey: title,
        descriptionKey: description,
      };
      _db.push().set(newTodo);
      debugPrint("Success");
    } catch(e) {
      debugPrint("Error: $e");
    }
  }

  static void deleteTodo(String key) {
    try {
      _db.child(key).remove();
      debugPrint("Success");
    } catch(e) {
      debugPrint("Error: $e");
    }
  }

  static void updateTodo(String key, String title, String description) {
    try {
      final Map<String, Object> newTodo = {
        titleKey: title,
        descriptionKey: description,
      };
      _db.child(key).update(newTodo);
    } catch(e) {
      debugPrint("Error: $e");
    }
  }
}
