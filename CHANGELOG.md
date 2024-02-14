## 1.0.1
* Fix issue when unsubscribing ([#2](https://github.com/Aikyuichi/notification_center.dart/issues/2))
## 1.0.0
* It's possible to pause / resume subscriptions.
#### Breaking changes
* Subscribed callback must conform to type void Function(T).
* Unsubscribe method no longer accepts the optional parameter "callback". Use subscription.cancel() instead.
## 0.0.3
* documentation.
## 0.0.2
* include example.
## 0.0.1
* Initial release.