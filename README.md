# Notification Center

[![Pub Version](https://img.shields.io/pub/v/notification_center)](https://pub.dev/packages/notification_center)

A notification dispatch mechanism that enables the broadcast of information to registered observers.

## Getting Started

notification_center is available through [pub.dev](https://pub.dev/packages/notification_center).

Add the dependency to your pubspec.yaml:

```yaml
dependencies:
  ...
  notification_center: ^1.0.0
```

## Usage example

Check the example folder

Add a subscribers
```dart
NotificationCenter().subscribe('updateCounter', (data) {
  setState(() {
    _counter += data;
  });
});
```
or
```dart
NotificationCenter().subscribe('updateCounter', _updateCounter);

...

void _updateCounter(data) {
  setState(() {
    _counter++;
  });
}
```
Remove subscribers
```dart
NotificationCenter().unsubscribe('updateCounter');
```
Post notification
```dart
NotificationCenter().notify('updateCounter');
```

Passing data

```dart
NotificationCenter().subscribe('updateCounter', (int data) {
  setState(() {
    _counter += data;
  });
});
```
```dart
NotificationCenter().notify('updateCounter', data: 10);
```

Pause/resume or cancel the subscription
```dart
final subscription = NotificationCenter().subscribe('updateCounter', (int data) {
  setState(() {
    _counter += data;
  });
});

//Do some work...

subscription.pause();
print(subscription.isPaused); // true

subscription.resume();
print(subscription.isPaused); // false

subscription.cancel();
```