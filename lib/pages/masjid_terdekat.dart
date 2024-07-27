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
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return;
    }

    _permissionGranted = true;
    _locationServiceEnabled = true;

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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

    return masjids.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (!_locationServiceEnabled || !_permissionGranted) {
      return const Center(
        child: Text('Location services are disabled or permission denied.'),
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
        }).toList(),
      ],
    );
  }
}
