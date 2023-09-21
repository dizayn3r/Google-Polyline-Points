/// A pair of latitude and longitude coordinates, stored as degrees.
class LatLngCoordinate {
  /// Creates a geographical location specified in degrees [latitude] and [longitude].
  const LatLngCoordinate(this.latitude, this.longitude);

  /// The latitude in degrees.
  final double latitude;

  /// The longitude in degrees
  final double longitude;

  @override
  String toString() {
    return "lat: $latitude / longitude: $longitude";
  }
}
