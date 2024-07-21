import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masjidkorea/models/masjid_model.dart';

class MasjidService {
  final CollectionReference _masjidReference =
      FirebaseFirestore.instance.collection('masjids');

  Future<List<MasjidModel>> fetchMasjids() async {
    try {
      QuerySnapshot result = await _masjidReference.get();

      List<MasjidModel> masjids = result.docs.map(
        (e) {
          return MasjidModel.fromJson(e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      return masjids;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MasjidModel>> fetchMasjidsByCommunity(String community) async {
    try {
      QuerySnapshot result =
          await _masjidReference.where('comunity', isEqualTo: community).get();

      List<MasjidModel> masjids = result.docs.map(
        (e) {
          return MasjidModel.fromJson(e.id, e.data() as Map<String, dynamic>);
        },
      ).toList();

      return masjids;
    } catch (e) {
      rethrow;
    }
  }
}
