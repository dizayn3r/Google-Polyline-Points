<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A flutter package that decodes geo-coordinates into google polyline for showing route on maps.

## Features

* Get route between two locations.

## Getting started

This package contains functions to decode google encoded polyline string which returns a list of co-ordinates indicating route between two geographical position

## Usage

To use this package, add google_polyline_points as a dependency in your pubspec.yaml file

### Import the package

```
import 'package:google_polyline_points/google_polyline_points.dart';
```

### First Method

Get the list of points from  geo-coordinates, this return an instance of PolylineResult which contains the status of the api, the errorMessage, and the list of decoded points.

```dart
PolylinePoints polylinePoints = PolylinePoints();
PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(googleAPiKey,
        _originLatitude, _originLongitude, _destLatitude, _destLongitude);
print(result.points);import 'package:google_polyline_points/google_polyline_points.dart';
```
