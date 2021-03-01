import 'package:wakelock/wakelock.dart' as lib;

abstract class WakeLock {
  void turnOn();

  void turnOff();

  Future<bool> isOn();
}

class WakeLockImpl implements WakeLock {
  @override
  void turnOn() => lib.Wakelock.enable();

  @override
  void turnOff() => lib.Wakelock.disable();

  @override
  Future<bool> isOn() async => await lib.Wakelock.enabled;
}
