import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:google_polyline_points/google_polyline_points.dart';

void main() async {
  await dotenv.load();
  test('get list of coordinates from two geographical positions', () async {
    final polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      dotenv.env['GOOGLE_MAP_KEY']!,
      const LatLngCoordinate(6.5212402, 3.3679965),
      const LatLngCoordinate(6.595680, 3.337030),
      travelMode: TravelMode.driving,
    );
    debugPrint(result.duration);
    assert(result.points.isNotEmpty == true);
  });

  test('get list of coordinates from an encoded String', () {
    log("Writing a test is very easy");
    final polylinePoints = PolylinePoints();
    List<LatLngCoordinate> points =
        polylinePoints.decodePolyline("_p~iF~ps|U_ulLnnqC_mqNvxq`@");
    log("Answer ---- ");
    debugPrint(points.toString());
    assert(points.isNotEmpty);
  });
}
