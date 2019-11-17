import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vt_live_map/vt/vehicles/liveMapResponse.dart';
import 'package:vt_live_map/vt/vehicles/vehicle.dart';

import '../VTClient.dart';

class VTLiveMap extends StatefulWidget {
  @override
  VTLiveMapState createState() => VTLiveMapState();
}

class VTLiveMapState extends State<VTLiveMap> {
  VTClient _vtClient = VTClient();
  GoogleMapController map;
  LatLngBounds _mapBounds;
  LatLng _initialView = const LatLng(57.7089, 11.9746); // Gothenburg
  Set<Marker> _vehicles = Set();

  Timer _timer;

  @override
  void initState() {
    super.initState();

    requestLocationPermission();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  void requestLocationPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.locationWhenInUse]);

    if (permissions.containsKey(PermissionGroup.locationWhenInUse)) {
      if (permissions[PermissionGroup.locationWhenInUse] ==
          PermissionStatus.granted) {
        final LatLng currentLatLng = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((v) => LatLng(v.latitude, v.longitude));
        //map.moveCamera(CameraUpdate.newLatLng(currentLatLng));
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    map = controller;
    await map.getVisibleRegion().then((bounds) => _mapBounds = bounds);

    updateVehicles();
    _timer = Timer.periodic(new Duration(seconds: 3), (timer) {
      updateVehicles();
    });
  }

  void _onCameraIdle() async {
    if (map != null)
      await map.getVisibleRegion().then((bounds) => _mapBounds = bounds);

    updateVehicles();
  }

  void updateVehicles() async {
    _vtClient.liveMap(_mapBounds, true).then((res) async {
      Map<String, Set<Marker>> markers = await getMarkers(res);
      setState(() {
        _vehicles.clear();
        _vehicles.addAll(markers['vehicles']);
      });
    });
  }

  Future<Map<String, Set<Marker>>> getMarkers(LiveMapResponse res) async {
    final Set<Marker> vehicles = {};

    for (var i = 0; i < res.vehicles.length; i++) {
      Vehicle vehicle = res.vehicles[i];
      final vehicleIcon = await vehicle.getIcon();
      vehicles.add(Marker(
          icon: vehicleIcon,
          markerId: MarkerId(vehicle.gid),
          position: LatLng(vehicle.y, vehicle.x),
          infoWindow: InfoWindow(
            title: vehicle.name,
            snippet: vehicle.delayString,
          ),
          onTap: () => print(vehicle.name)));
    }
    Map<String, Set<Marker>> map = Map();
    map['vehicles'] = vehicles;
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VT Live Map',
      theme: ThemeData(
        primaryColor: Colors.white,
        canvasColor: Colors.transparent,
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Live Map'),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _initialView,
            zoom: 15.0,
          ),
          onMapCreated: _onMapCreated,
          onCameraIdle: _onCameraIdle,
          markers: _vehicles,
          myLocationEnabled: true,
        ),
      ),
    );
  }
}
