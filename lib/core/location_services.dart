// ignore_for_file: use_build_context_synchronously

import 'package:employees_attendance/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationServices {
  Location location = Location();
  late LocationData _locationData;

  Future<Map<String, double?>?> initAndGetLocation(BuildContext context) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        Utils.showSnackBar('Please Enable Location Service', context,
            color: Colors.blue);
        return null;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted != PermissionStatus.granted) {
      Utils.showSnackBar('Please Allow Location Access', context,
          color: Colors.blue);
      return null;
    }
    _locationData = await location.getLocation();
    return {
      "latitude": _locationData.latitude,
      "longitude": _locationData.longitude,
    };
  }
}