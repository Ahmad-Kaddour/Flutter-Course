import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  void _openPlaceDetails(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => PlaceDetailsScreen(place: place)),
    );
  }

  @override
  Widget build(BuildContext context) {
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

    return content;
  }
}
