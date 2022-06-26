import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_media/logger.dart';

abstract class Service {
  bool isInitial = false;
  CompositeSubscription _unSubscribers = CompositeSubscription();

  String get name => runtimeType.toString();

  @protected
  @mustCallSuper
  void initialize() {
    logger.d("$runtimeType initialized");
  }

  @protected
  @mustCallSuper
  void watch(StreamSubscription subscription) {
    if (!_unSubscribers.isDisposed) {
      _unSubscribers.add(subscription);
    }
  }

  @nonVirtual
  @mustCallSuper
  void setUp() {
    if (!isInitial) {
      initialize();
      _unSubscribers = CompositeSubscription();
      isInitial = true;
    }
  }

  @protected
  @mustCallSuper
  void teardown() {
    _unSubscribers.dispose();
    isInitial = false;
    logger.d("$runtimeType teardown");
  }
}
