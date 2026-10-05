import 'package:flutter_test/flutter_test.dart';
import 'package:notification_center/notification_center.dart';

void main() {
  group('NotificationCenter Tests', () {
    test('subscribe and notify without data', () async {
      int callCount = 0;
      final subscription = NotificationCenter().subscribe<void>('test_event_1', (_) {
        callCount++;
      });

      NotificationCenter().notify('test_event_1');
      await pumpEventQueue();
      expect(callCount, 1);

      await subscription.cancel();
    });

    test('subscribe and notify with typed data', () async {
      int receivedValue = 0;
      final subscription = NotificationCenter().subscribe<int>('test_event_data', (data) {
        receivedValue = data;
      });

      NotificationCenter().notify('test_event_data', data: 42);
      await pumpEventQueue();
      expect(receivedValue, 42);

      await subscription.cancel();
    });

    test('multiple subscribers receive notification', () async {
      int count1 = 0;
      int count2 = 0;

      final sub1 = NotificationCenter().subscribe<String>('multi_event', (data) {
        count1++;
      });
      final sub2 = NotificationCenter().subscribe<String>('multi_event', (data) {
        count2++;
      });

      NotificationCenter().notify('multi_event', data: 'hello');
      await pumpEventQueue();
      expect(count1, 1);
      expect(count2, 1);

      await sub1.cancel();
      await sub2.cancel();
    });

    test('pause and resume individual subscription', () async {
      int callCount = 0;
      final subscription = NotificationCenter().subscribe<int>('pause_event', (data) {
        callCount += data;
      });

      NotificationCenter().notify('pause_event', data: 1);
      await pumpEventQueue();
      expect(callCount, 1);

      subscription.pause();
      expect(subscription.isPaused, isTrue);

      NotificationCenter().notify('pause_event', data: 10);
      await pumpEventQueue();
      expect(callCount, 1); // Should not change while paused

      subscription.resume();
      expect(subscription.isPaused, isFalse);

      NotificationCenter().notify('pause_event', data: 5);
      await pumpEventQueue();
      expect(callCount, 6);

      await subscription.cancel();
    });

    test('pause and resume via NotificationCenter', () async {
      int callCount = 0;
      final subscription = NotificationCenter().subscribe<int>('center_pause_event', (data) {
        callCount += data;
      });

      NotificationCenter().pause('center_pause_event');
      expect(NotificationCenter().isPaused('center_pause_event'), isTrue);

      NotificationCenter().notify('center_pause_event', data: 10);
      await pumpEventQueue();
      expect(callCount, 0);

      NotificationCenter().resume('center_pause_event');
      expect(NotificationCenter().isPaused('center_pause_event'), isFalse);

      NotificationCenter().notify('center_pause_event', data: 5);
      await pumpEventQueue();
      expect(callCount, 5);

      await subscription.cancel();
    });

    test('unsubscribe all subscribers for an id', () async {
      int count = 0;
      NotificationCenter().subscribe<void>('unsub_event', (_) {
        count++;
      });

      NotificationCenter().notify('unsub_event');
      await pumpEventQueue();
      expect(count, 1);

      await NotificationCenter().unsubscribe('unsub_event');

      NotificationCenter().notify('unsub_event');
      await pumpEventQueue();
      expect(count, 1); // Should not increment after unsubscribe
    });

    test('lifecycle callbacks (onPause, onResume, onCancel)', () async {
      bool pausedCalled = false;
      bool resumedCalled = false;
      bool canceledCalled = false;

      final subscription = NotificationCenter().subscribe<void>(
        'lifecycle_event',
        (_) {},
        onPause: () => pausedCalled = true,
        onResume: () => resumedCalled = true,
        onCancel: () => canceledCalled = true,
      );

      subscription.pause();
      expect(pausedCalled, isTrue);

      subscription.resume();
      expect(resumedCalled, isTrue);

      await subscription.cancel();
      expect(canceledCalled, isTrue);
    });
  });
}
