A notification dispatch mechanism that enables the broadcast of information to registered observers.

## Getting Started

notification_center is available through [pub.dev](https://pub.dev/packages/notification_center).

Add the dependency to your pubspec.yaml:

```yaml
dependencies:
  ...
  notification_center: ^0.0.2
```

## Usage example

Check the example folder

Subscribe observer
```dart
NotificationCenter().subscribe('updateCounter', () {
  setState(() {
    _counter++;
  });
});
```
or
```dart
NotificationCenter().subscribe('updateCounter', _updateCounter);

...

void _updateCounter() {
  setState(() {
    _counter++;
  });
}
```
Unsubscribe observer
```dart
NotificationCenter().unsubscribe('updateCounter');
```
Post notification
```dart
NotificationCenter().notify('updateCounter');
```

Passing data

```dart
NotificationCenter().subscribe('updateCounter', (int value) {
  setState(() {
    _counter = value;
  });
});
```
```dart
NotificationCenter().notify('updateCounter', data: 10);
```