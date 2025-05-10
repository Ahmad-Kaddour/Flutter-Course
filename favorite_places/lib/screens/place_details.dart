import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    final bottomSafePadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: Center(
        child: Stack(
          children: [
            Image.file(
              place.image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.symmetric(horizontal: 24, vertical: 16) +
                    EdgeInsets.only(bottom: bottomSafePadding),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black54],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Text(
                  place.location.toString(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
