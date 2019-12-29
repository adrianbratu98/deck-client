import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PublicNotifier<T> extends ValueNotifier<T> {
  PublicNotifier(T value) : super(value);

  notifyListeners() => super.notifyListeners();
}