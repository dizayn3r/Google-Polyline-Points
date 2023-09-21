import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_points/google_polyline_points.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  double originLatitude = 28.5511514, originLongitude = 76.8518491;
  double destLatitude = 28.6486506, destLongitude = 77.305566;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "Your API Key";

  @override
  void initState() {
    super.initState();

    /// origin marker
    addMarker(
      id: "origin",
      position: LatLng(originLatitude, originLongitude),
      descriptor: BitmapDescriptor.defaultMarker,
    );

    /// destination marker
    addMarker(
      id: "destination",
      position: LatLng(destLatitude, destLongitude),
      descriptor: BitmapDescriptor.defaultMarkerWithHue(90),
    );
    getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text("MapScreen"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(originLatitude, originLongitude),
          zoom: 15,
        ),
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) async {
          mapController = controller;
        },
        markers: Set<Marker>.of(markers.values),
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }

  addMarker({
    required LatLng position,
    required String id,
    required BitmapDescriptor descriptor,
  }) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
    );
    markers[markerId] = marker;
  }

  addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      LatLngCoordinate(originLatitude, originLongitude),
      LatLngCoordinate(destLatitude, destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    addPolyLine();
  }
}
