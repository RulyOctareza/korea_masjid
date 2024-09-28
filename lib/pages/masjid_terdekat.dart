// ignore: avoid_web_libraries_in_flutter
// ignore_for_file: avoid_print

import 'dart:html' as html;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:masjidkorea/models/distance_calc.dart';
import 'package:masjidkorea/models/masjid_model.dart';
import 'package:masjidkorea/pages/masjid_distance_card.dart';

class MasjidTerdekat extends StatefulWidget {
  final List<MasjidModel> masjids;

  const MasjidTerdekat({required this.masjids, super.key});

  @override
  _MasjidTerdekatState createState() => _MasjidTerdekatState();
}

class _MasjidTerdekatState extends State<MasjidTerdekat> {
  Position? _currentPosition;
  bool _locationServiceEnabled = false;
  bool _permissionGranted = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    if (kIsWeb) {
      await _getLocationWeb();
    } else {
      await _getLocationNative();
    }
  }

  Future<void> _getLocationWeb() async {
    try {
      await html.window.navigator.geolocation
          .getCurrentPosition()
          .then((position) {
        setState(() {
          _currentPosition = Position(
            latitude: position.coords!.latitude!.toDouble(),
            longitude: position.coords!.longitude!.toDouble(),
            timestamp: DateTime.now(),
            accuracy: position.coords!.accuracy?.toDouble() ?? 0.0,
            altitude: position.coords!.altitude?.toDouble() ?? 0.0,
            heading: position.coords!.heading?.toDouble() ?? 0.0,
            speed: position.coords!.speed?.toDouble() ?? 0.0,
            speedAccuracy: 0.0,
            altitudeAccuracy: 0,
            headingAccuracy: 0,
          );
          _permissionGranted = true;
          _locationServiceEnabled = true;
        });
      });
    } catch (e) {
      print('Error getting location on web: $e');
      setState(() {
        _permissionGranted = false;
        _locationServiceEnabled = false;
      });
    }
  }

  Future<void> _getLocationNative() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      setState(() {
        _locationServiceEnabled = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied.');
        setState(() {
          _permissionGranted = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      setState(() {
        _permissionGranted = false;
      });
      return;
    }

    setState(() {
      _permissionGranted = true;
      _locationServiceEnabled = true;
    });

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('Location data: ${position.latitude}, ${position.longitude}');
    setState(() {
      _currentPosition = position;
    });
  }

  List<MasjidModel> _sortMasjidsByDistance(List<MasjidModel> masjids) {
    if (_currentPosition == null) {
      return [];
    }

    masjids.sort((a, b) {
      double distanceA = calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        a.latitude,
        a.longitude,
      );
      double distanceB = calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        b.latitude,
        b.longitude,
      );
      return distanceA.compareTo(distanceB);
    });

    return masjids.take(10).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (!_locationServiceEnabled || !_permissionGranted) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Layanan lokasi tidak aktif atau izin ditolak.'),
            ElevatedButton(
              onPressed: _getLocation,
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      );
    }

    if (_currentPosition == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    List<MasjidModel> nearbyMasjids = _sortMasjidsByDistance(widget.masjids);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Masjid - Masjid terdekat dengan anda',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        ...nearbyMasjids.map((masjid) {
          double distance = calculateDistance(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            masjid.latitude,
            masjid.longitude,
          );

          return MasjidDistanceCard(masjid: masjid, distance: distance);
        }),
      ],
    );
  }
}
