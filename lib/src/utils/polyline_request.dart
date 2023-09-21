import 'package:google_polyline_points/src/lat_lng_coordinates.dart';

import 'enum/travel_mode.dart';
import 'polyline_waypoint.dart';

class PolylineRequest {
  final LatLngCoordinate origin;
  final LatLngCoordinate destination;
  final TravelMode mode;
  final String apiKey;
  final List<PolylineWayPoint> wayPoints;
  final bool avoidHighways;
  final bool avoidTolls;
  final bool avoidFerries;
  final bool optimizeWaypoints;

  /// Specifies one or more preferred modes of transit. This parameter may only
  /// be specified for transit directions.
  /// The parameter supports the following arguments:
  /// bus
  /// rail
  /// subway
  /// train
  /// tram
  final String? transitMode;

  /// If set to true, specifies that the Directions service may provide more
  /// than one route alternative in the response. Note that providing route
  /// alternatives may increase the response time from the server.
  /// This is only available for requests without intermediate waypoints.
  /// For more information, see the guide to waypoints.
  /// https://developers.google.com/maps/documentation/directions/get-directions#Waypoints
  final bool alternatives;

  /// Specifies the desired time of arrival for transit directions, in seconds
  /// since midnight, January 1, 1970 UTC. You can specify either this
  /// or [departureTime], but not both. Note that it must be specified as an integer.
  final int? arrivalTime;

  /// Specifies the desired time of departure. You can specify the time as
  /// an integer in seconds since midnight,
  final int? departureTime;

  PolylineRequest({
    required this.apiKey,
    required this.origin,
    required this.destination,
    required this.mode,
    required this.wayPoints,
    required this.avoidHighways,
    required this.avoidTolls,
    required this.avoidFerries,
    required this.optimizeWaypoints,
    required this.alternatives,
    this.arrivalTime,
    this.departureTime,
    this.transitMode,
  });

  void validateKey(String key) {
    if (key.isEmpty) {
      throw ArgumentError("API Key cannot empty");
    }
  }

  Uri toUri() {
    validateKey(apiKey);
    var params = removeNulls({
      "origin": "${origin.latitude},${origin.longitude}",
      "destination": "${destination.latitude},${destination.longitude}",
      "mode": mode.name,
      "avoidHighways": "$avoidHighways",
      "avoidFerries": "$avoidFerries",
      "avoidTolls": "$avoidTolls",
      "alternatives": "$alternatives",
      "key": apiKey,
      "arrival_time": arrivalTime,
      "departure_time": departureTime,
      "transit_mode": transitMode
    });
    if (wayPoints.isNotEmpty) {
      List wayPointsArray = [];
      for (var point in wayPoints) {
        wayPointsArray.add(point.location);
      }
      String wayPointsString = wayPointsArray.join('|');
      if (optimizeWaypoints) {
        wayPointsString = 'optimize:true|$wayPointsString';
      }
      params.addAll({"waypoints": wayPointsString});
    }
    return Uri.https("maps.googleapis.com", "maps/api/directions/json", params);
  }

  Map<String, dynamic> removeNulls(Map<String, dynamic> map) {
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
