## 1.1.0
* New callbacks in *subscribe* function.
  * onPause
  * onResume
  * onCancel
* The sample project was updated.
## 1.0.2
* Fix a concurrency issue when unsubscribing ([#3](https://github.com/Aikyuichi/notification_center.dart/issues/3)).
## 1.0.1
* Fix issue when unsubscribing ([#2](https://github.com/Aikyuichi/notification_center.dart/issues/2)).
## 1.0.0
* It's possible to pause/resume subscriptions.
#### Breaking changes
* Subscribed *callback* must conform to type void Function(T).
* *unsubscribe* function no longer accepts the optional parameter *callback*. Use *subscription.cancel()* instead.
## 0.0.3
* Documentation.
## 0.0.2
* Include example.
## 0.0.1
* Initial release.