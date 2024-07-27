import 'dart:math' as math;

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 - math.cos((lat2 - lat1) * p) / 2 +
      math.cos(lat1 * p) * math.cos(lat2 * p) *
          (1 - math.cos((lon2 - lon1) * p)) / 2;
  return 12742 * math.asin(math.sqrt(a));
}
