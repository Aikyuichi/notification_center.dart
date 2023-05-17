// Copyright (c) 2021 Aikyuichi <aikyu.sama@gmail.com>
// All rights reserved.
// Use of this source code is governed by a MIT license that can be found in the LICENSE file.

/// A simple notification center.
/// A notification dispatch mechanism that enables the broadcast of information to registered observers.
library notification_center;

/// A singleton. It takes care of registering observers, and posting notifications.
class NotificationCenter {
  final _observers = <String, List<Function>>{};

  static final NotificationCenter _instance = NotificationCenter.internal();

  factory NotificationCenter() => _instance;

  NotificationCenter.internal();

  /// Registers the observer in the center.
  void subscribe(String notificationId, Function callback) {
    if (!_observers.containsKey(notificationId)) {
      _observers[notificationId] = [];
    }
    _observers[notificationId]?.add(callback);
  }

  /// Unregisters the observers in the center.
  void unsubscribe(String notificationId, {Function? callback}) {
    if (callback != null) {
      if (_observers.containsKey(notificationId)) {
        _observers[notificationId]!.remove(callback);
      }
    } else {
      _observers.remove(notificationId);
    }
  }

  /// Posts a notification, calling all associated observers.
  void notify(String notificationId, {dynamic data}) {
    if (_observers.containsKey(notificationId)) {
      final observer = _observers[notificationId]!;
      if (data != null) {
        for (var callback in observer) {
          callback(data);
        }
      } else {
        for (var callback in observer) {
          callback();
        }
      }
    }
  }
}
