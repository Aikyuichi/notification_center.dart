# Notification Center

[![Pub Version](https://img.shields.io/pub/v/notification_center)](https://pub.dev/packages/notification_center)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A lightweight notification dispatch mechanism for Flutter and Dart that enables easy broadcasting of information to registered observers with support for type safety, subscription lifecycle management (pause/resume/cancel), and cleanup callbacks.

## Features

- **Singleton Pattern**: Centralized notification management across your app.
- **Type-Safe Payloads**: Send and receive typed data (`<T>`) safely.
- **Subscription Management**: Pause, resume, or cancel individual subscriptions or groups.
- **Lifecycle Callbacks**: Listen to `onPause`, `onResume`, and `onCancel` events.
- **Zero Heavy Dependencies**: Pure Dart / Flutter implementation.

## Getting Started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  notification_center: ^1.1.1
```

Import the package in your Dart code:

```dart
import 'package:notification_center/notification_center.dart';
```

## Usage

Check out the complete sample project in the [example](https://github.com/Aikyuichi/notification_center.dart/tree/main/example) directory.

### 1. Add a Subscriber
```dart
NotificationCenter().subscribe('updateCounter', (int data) {
  setState(() {
    _counter += data;
  });
});
```
Or reference a method:
```dart
NotificationCenter().subscribe('updateCounter', _updateCounter);

void _updateCounter(data) {
  setState(() {
    _counter++;
  });
}
```

### 2. Post Notifications
```dart
NotificationCenter().notify('updateCounter');
```

### 3. Passing Data with Type Safety
```dart
NotificationCenter().subscribe<int>('updateCounter', (int data) {
  setState(() {
    _counter += data;
  });
});

// Post with data
NotificationCenter().notify('updateCounter', data: 10);
```

### 4. Pause, Resume, or Cancel Subscriptions
```dart
final subscription = NotificationCenter().subscribe(
  'updateCounter',
  _updateCounter,
  onPause: () => print('Paused'),
  onResume: () => print('Resumed'),
  onCancel: () => print('Cancelled'),
);

// Control subscription
subscription.pause();
print(subscription.isPaused); // true

subscription.resume();
print(subscription.isPaused); // false

subscription.cancel();
```

### 5. Remove Subscribers by ID
```dart
NotificationCenter().unsubscribe('updateCounter');
```

## API Reference Summary

| Method | Description |
| :--- | :--- |
| `subscribe<T>(id, callback, {onPause, onResume, onCancel})` | Registers an observer for `id` and returns a `NotificationSubscription`. |
| `notify(id, {data})` | Broadcasts a notification with optional data. |
| `unsubscribe(id)` | Cancels and removes all subscribers for `id`. |
| `pause(id)` / `resume(id)` | Pauses or resumes all subscribers for `id`. |
| `isPaused(id)` | Checks if all subscribers for `id` are paused. |

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support & Donations

If you find `notification_center` helpful and would like to support its ongoing development and maintenance, consider making a donation:

- **GitHub Sponsors**: [Sponsor @Aikyuichi on GitHub](https://github.com/sponsors/Aikyuichi)
- **Starknet (USDC / ETH / STRK)**: `0x07E42a15Ad7236Ec21CeF4e7d0c353310F76d3D430Fa0E59eb29027a1F7C3A4e`

Your support is greatly appreciated! ❤️
