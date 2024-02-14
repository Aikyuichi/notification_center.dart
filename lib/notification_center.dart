// Copyright (c) 2024 Aikyuichi <aikyu.sama@gmail.com>
// All rights reserved.
// Use of this source code is governed by a MIT license that can be found in the LICENSE file.

/// A simple notification center.
/// A notification dispatch mechanism that enables the broadcast of information to registered observers.
library notification_center;

import 'dart:async';
import 'src/notification_subscriber.dart';

export 'src/notification_subscriber.dart' show NotificationSubscription;

/// A singleton. It takes care of subscribe observers, and post notifications.
class NotificationCenter {
  final _notifications = <String, List<NotificationSubscriber>>{};

  static final NotificationCenter _instance = NotificationCenter.internal();

  factory NotificationCenter() => _instance;

  NotificationCenter.internal();

  /// Adds to the center a subscriber for [notificationId].
  ///
  /// The returned [NotificationSubscription] can be used to pause/resume or cancel the subscription.
  NotificationSubscription subscribe<T>(
      String notificationId, void Function(T) callback) {
    if (!_notifications.containsKey(notificationId)) {
      _notifications[notificationId] = [];
    }
    final subscriber = NotificationSubscriber<T>(callback);
    subscriber.onCancel = () {
      _notifications[notificationId]?.remove(subscriber);
    };
    _notifications[notificationId]?.add(subscriber);
    return subscriber;
  }

  /// Remove from the center the subscribers of [notificationId].
  Future<void> unsubscribe(String notificationId) async {
    if (_notifications.containsKey(notificationId)) {
      final subscribers = _notifications[notificationId]!;
      for (var subscriber in subscribers) {
        subscriber.onCancel = null;
        await subscriber.cancel();
      }
      _notifications.remove(notificationId);
    }
  }

  /// Pause all the subscribers of [notificationId]
  void pause(String notificationId) {
    if (_notifications.containsKey(notificationId)) {
      final subscribers = _notifications[notificationId]!;
      for (var subscriber in subscribers) {
        subscriber.pause();
      }
    }
  }

  /// Resumes all the subscribers of [notificationId] after a pause.
  void resume(String notificationId) {
    if (_notifications.containsKey(notificationId)) {
      final subscribers = _notifications[notificationId]!;
      for (var subscriber in subscribers) {
        subscriber.resume();
      }
    }
  }

  /// Whether all the subscribers of [notificationId] are currently paused.
  bool isPaused(String notificationId) {
    if (_notifications.containsKey(notificationId)) {
      final subscribers = _notifications[notificationId]!;
      return subscribers
          .map((e) => e.isPaused)
          .reduce((value, element) => value && element);
    }
    return false;
  }

  /// Posts a given notification.
  void notify<T>(String notificationId, {T? data}) {
    if (_notifications.containsKey(notificationId)) {
      final subscribers = _notifications[notificationId]!;
      for (var subscriber in subscribers) {
        subscriber.add(data);
      }
    }
  }
}
