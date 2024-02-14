// Copyright (c) 2024 Aikyuichi <aikyu.sama@gmail.com>
// All rights reserved.
// Use of this source code is governed by a MIT license that can be found in the LICENSE file.

import 'dart:async';

abstract class NotificationSubscription {
  /// Whether the [NotificationSubscription] is currently paused.
  bool get isPaused;

  /// Pause this subscription. Notifications post by the center are ignore.
  void pause();

  /// Resumes after a pause.
  void resume();

  /// Cancels this subscription.
  Future<dynamic> cancel();
}

class NotificationSubscriber<T> implements NotificationSubscription {
  final StreamController<T> _controller = StreamController();
  late final StreamSubscription<T> _subscription;
  FutureOr<void> Function()? onCancel;

  @override
  bool get isPaused => _subscription.isPaused;

  NotificationSubscriber(void Function(T) callback) {
    _subscription = _controller.stream.listen(callback);
    _controller.onCancel = () {
      this.onCancel?.call();
    };
  }

  void add(dynamic data) {
    if (!_controller.isClosed && !_controller.isPaused) {
      _controller.add(data);
    }
  }

  @override
  void pause() {
    if (!_subscription.isPaused) {
      _subscription.pause();
    }
  }

  @override
  void resume() {
    _subscription.resume();
  }

  @override
  Future<dynamic> cancel() async {
    await _subscription.cancel();
    return await _controller.close();
  }
}
