import 'package:flutter/material.dart';
import 'package:masjidkorea/models/masjid_model.dart';
import 'package:masjidkorea/theme.dart';
import 'package:masjidkorea/widgets/facility_item.dart';

class MainFacilities extends StatefulWidget {
  final MasjidModel
      masjid; // Assuming you have a Masjid class defined elsewhere

  const MainFacilities({super.key, required this.masjid});

  @override
  _MainFacilitiesState createState() => _MainFacilitiesState();
}

class _MainFacilitiesState extends State<MainFacilities> {
  @override
  Widget build(BuildContext context) {
    const double edge = 16.0; // Define the edge padding value

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: edge),
            child: Text(
              'Main Facilities',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: edge,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FacilityItem(
                  name: 'kitchen',
                  imageUrl: 'assets/icon_kitchen.png',
                  status: widget.masjid.kitchen,
                ),
                FacilityItem(
                  name: 'bedroom',
                  imageUrl: 'assets/icon_bedroom.png',
                  status: widget.masjid.bedroom,
                ),
                FacilityItem(
                  name: 'Lemari',
                  imageUrl: 'assets/icon_cupboard.png',
                  status: widget.masjid.lemari,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
