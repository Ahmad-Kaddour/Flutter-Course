import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _enteredPlaceName = '';
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _addPlace() {
    if (_formKey.currentState!.validate() &&
        _selectedImage != null &&
        _selectedLocation != null) {
      _formKey.currentState!.save();
      ref
          .read(placesProvider.notifier)
          .addPlace(
            Place(
              name: _enteredPlaceName,
              image: _selectedImage!,
              location: _selectedLocation!,
            ),
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new place')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(label: Text('Name')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                  onSaved: (value) => _enteredPlaceName = value ?? '',
                ),
                const SizedBox(height: 10),
                ImageInput(onPickImage: (file) => _selectedImage = file),
                const SizedBox(height: 10),
                LocationInput(onLocationSelected: (location) => _selectedLocation = location,),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  onPressed: _addPlace,
                  label: const Text('Add Place'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
