import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjidkorea/cubit/masjid_cubit.dart';
import 'package:masjidkorea/models/masjid_model.dart';
import 'package:masjidkorea/theme.dart';
import 'package:masjidkorea/widgets/space_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<MasjidModel> _filteredMasjids = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    // Filter daftar masjid berdasarkan teks pencarian
    final masjids = context.read<MasjidCubit>().state is MasjidSuccess
        ? (context.read<MasjidCubit>().state as MasjidSuccess).masjids
        : <MasjidModel>[];
    setState(() {
      _filteredMasjids = masjids
          .where((masjid) => masjid.name
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Cari Masjid...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
        ),
      ),
    );
  }

  Widget daftarMasjid(List<MasjidModel> masjids) {
    List<MasjidModel> displayMasjids =
        _searchController.text.isEmpty ? masjids : _filteredMasjids;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: edge, top: edge),
          child: Text(
            'Daftar Masjid di Korea Selatan',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                ),
          ),
        ),
        const SizedBox(height: 5),
        searchBox(),
        const SizedBox(height: 16),
        Column(
          children: displayMasjids.map((MasjidModel masjid) {
            return Column(
              children: [
                SpaceCard(masjid),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<MasjidCubit, MasjidState>(
          builder: (context, state) {
            if (state is MasjidSuccess) {
              // Inisialisasi daftar masjid terfilter dengan semua masjid saat pertama kali berhasil memuat data
              if (_filteredMasjids.isEmpty) {
                _filteredMasjids = state.masjids;
              }
              return ListView(
                children: [
                  daftarMasjid(state.masjids),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
