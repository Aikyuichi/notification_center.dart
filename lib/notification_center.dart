library notification_center;

class NotificationCenter {
  final _observers = <String, List<Function>>{};

  static final NotificationCenter _instance = NotificationCenter.internal();

  factory NotificationCenter() => _instance;

  NotificationCenter.internal();

  void subscribe(String notificationId, Function callback) {
    if (!_observers.containsKey(notificationId)) {
      _observers[notificationId] = [];
    }
    _observers[notificationId]?.add(callback);
  }

  void unsubscribe(String notificationId, {Function? callback}) {
    if (callback != null) {
      if (_observers.containsKey(notificationId)) {
        _observers[notificationId]!.remove(callback);
      }
    } else {
      _observers.remove(notificationId);
    }
  }

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

// class NotificationData {
//   final dynamic value;
//
//   NotificationData(this.value);
// }
