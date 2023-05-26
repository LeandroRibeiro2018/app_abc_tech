import 'dart:core';

import 'package:geolocator/geolocator.dart';

abstract class GeolocationServiceInterface {
  // ignore: unused_element
  Future<bool> _enableGeolocation();
  // ignore: unused_element
  Future<void> _requestPermissions();
  bool isPermissionEnable();
  Future<Position> getPosition();
  Future<bool> start();
}

class GeolocationService implements GeolocationServiceInterface {
  bool _serviceEnable = false;
  late LocationPermission _permission;

  @override
  Future<bool> _enableGeolocation() async {
    _serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnable) {
      return Future.error("Location services are disable");
    }
    return Future.sync(() => true);
  }

  @override
  Future<void> _requestPermissions() async {
    _permission = await Geolocator.checkPermission();
    if (!isPermissionEnable()) {
      return Future.error("Location permission is denied");
    }
    return Future.sync(() => null);
  }

  @override
  Future<Position> getPosition() async {
    return Geolocator.getCurrentPosition();
  }

  @override
  bool isPermissionEnable() {
    if (_permission == LocationPermission.denied ||
        _permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> start() async {
    bool enabled = await _enableGeolocation();
    if (enabled) {
      await _requestPermissions();
      return Future.sync(() => isPermissionEnable());
    }
    return Future.sync(() => false);
  }
}
