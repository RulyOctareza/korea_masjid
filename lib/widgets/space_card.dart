import 'package:flutter/material.dart';
import 'package:masjidkorea/models/masjid_model.dart';
import 'package:masjidkorea/pages/detail_page.dart';

import '../theme.dart';

class SpaceCard extends StatelessWidget {
  final MasjidModel masjid;

  const SpaceCard(this.masjid, {super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan apakah tema saat ini adalah gelap atau terang
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(masjid),
          ),
        );
      },
      child: Container(
        // margin:
        //     EdgeInsets.symmetric(vertical: 2), // Mengurangi jarak antar card
        padding: EdgeInsets.symmetric(
            horizontal: edge,
            vertical: 8), // Mengurangi padding agar lebih ringkas
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.grey[800]
              : Colors.white, // Warna card abu-abu jika mode gelap
          borderRadius:
              BorderRadius.circular(15), // Card dengan rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  masjid.imageUrl,
                  fit: BoxFit
                      .cover, // Menggunakan BoxFit.cover agar gambar memenuhi box
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    masjid.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? Colors.white
                              : Colors
                                  .black, // Ubah warna teks jadi putih jika mode gelap
                        ),
                    maxLines: 1, // Batasi teks hanya 1 baris
                    overflow: TextOverflow
                        .ellipsis, // Tambahkan elipsis jika teks terlalu panjang
                  ),
                  const SizedBox(height: 4),
                  Text(
                    masjid.city,
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      color: isDarkMode
                          ? Colors.grey[400]
                          : Colors
                              .grey, // Ubah warna teks abu-abu jika mode gelap
                    ),
                    maxLines: 1, // Batasi teks hanya 1 baris
                    overflow: TextOverflow
                        .ellipsis, // Tambahkan elipsis jika teks terlalu panjang
                  ),
                  const SizedBox(height: 10),
                  Text(
                    masjid.location, // Tambahkan deskripsi jika ada
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                      color: isDarkMode
                          ? Colors.grey[400]
                          : Colors.grey, // Ubah warna deskripsi jika mode gelap
                    ),
                    maxLines: 2, // Batasi deskripsi maksimal 2 baris
                    overflow: TextOverflow
                        .ellipsis, // Tambahkan elipsis jika teks terlalu panjang
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
