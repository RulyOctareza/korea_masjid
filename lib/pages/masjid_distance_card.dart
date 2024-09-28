import 'package:flutter/material.dart';
import 'package:masjidkorea/models/masjid_model.dart';
import 'package:masjidkorea/widgets/space_card.dart';

class MasjidDistanceCard extends StatelessWidget {
  final MasjidModel masjid;
  final double distance;

  const MasjidDistanceCard(
      {required this.masjid, required this.distance, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: SpaceCard(masjid),
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${distance.toStringAsFixed(2)} km',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
