import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  void _addNewPlace(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const NewPlaceScreen()));
  }

  void _openPlaceDetails(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => PlaceDetailsScreen(place: place)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    Widget content = Center(
      child: Text(
        'No places added yet',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );

    if (places.isNotEmpty) {
      content = Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: places.length,
          itemBuilder:
              (itemContext, index) => ListTile(
                leading: CircleAvatar(
                  radius: 26,
                  backgroundImage: FileImage(places[index].image),
                ),
                title: Text(
                  places[index].name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  places[index].location.toString(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onTap: () => _openPlaceDetails(context, places[index]),
              ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () => _addNewPlace(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
