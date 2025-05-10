import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dpPath = await sql.getDatabasesPath();
  final dp = await sql.openDatabase(
    path.join(dpPath, 'places.dp'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, name TEXT, image TEXT, lat REAL, lng REAL)',
      );
    },
    version: 1,
  );
  return dp;
}

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  Future<void> loadPlaces() async {
    final dp = await _getDatabase();
    final data = await dp.query('user_places');
    state =
        data
            .map(
              (row) => Place(
                id: row['id'] as String,
                name: row['name'] as String,
                image: File(row['image'] as String),
                location: PlaceLocation(
                  latitude: row['lat'] as double,
                  longitude: row['lng'] as double,
                ),
              ),
            )
            .toList();
  }

  void addPlace({
    required String name,
    required File image,
    required PlaceLocation location,
  }) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = Place(name: name, image: copiedImage, location: location);

    final dp = await _getDatabase();
    dp.insert('user_places', {
      'id': newPlace.id,
      'name': newPlace.name,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
    });

    state = [newPlace, ...state];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
  (ref) => PlacesNotifier(),
);
