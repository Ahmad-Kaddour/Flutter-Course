import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;

  PlaceLocation({required this.latitude, required this.longitude});

  @override
  String toString() {
    return 'Latitude: ${latitude.toStringAsFixed(2)}, Longitude: ${longitude.toStringAsFixed(2)}.';
  }
}

class Place {
  final String id;
  final String name;
  final File image;
  final PlaceLocation location;

  Place({required this.name, required this.image, required this.location})
    : id = uuid.v4();
}
