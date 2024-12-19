import 'package:flutter/material.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

getCurrentLocation() {
  return CurrentLocationLayer(
    // followOnLocationUpdate: FollowOnLocationUpdate.always,
    alignDirectionOnUpdate: AlignOnUpdate.never,
    style: const LocationMarkerStyle(
      marker: DefaultLocationMarker(
        child: Icon(
          Icons.navigation,
          color: Colors.white,
          size: 15.0,
        ),
      ),
      markerSize: Size(20.0, 20.0),
      markerDirection: MarkerDirection.heading,
    ),
  );
}
