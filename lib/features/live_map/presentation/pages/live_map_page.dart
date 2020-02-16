import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vt_live_map/features/live_map/data/models/live_map_request_model.dart';
import 'package:vt_live_map/features/live_map/domain/entities/live_map.dart';
import 'package:vt_live_map/features/live_map/domain/entities/vehicle.dart';
import 'package:vt_live_map/features/live_map/presentation/bloc/live_map_bloc.dart';
import 'package:vt_live_map/injection_container.dart';

class LiveMapPage extends StatefulWidget {
  @override
  LiveMapPageState createState() => LiveMapPageState();
}

class LiveMapPageState extends State<LiveMapPage> {
  LiveMapBloc _liveMapBloc;

  GoogleMapController _map;
  LatLngBounds _mapBounds;
  LatLng _initialView = const LatLng(57.7089, 11.9746); // Gothenburg
  Set<Marker> _vehicles = Set();

  Timer _timer;

  @override
  void initState() {
    super.initState();

    _liveMapBloc = sl<LiveMapBloc>();

    requestLocationPermission();
  }

  @override
  void dispose() {
    _timer?.cancel();

    _liveMapBloc?.close();

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
        //_map.moveCamera(CameraUpdate.newLatLng(currentLatLng));
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    _map = controller;
    await _map.getVisibleRegion().then((bounds) => _mapBounds = bounds);

    updateVehicles();
    _timer = Timer.periodic(new Duration(seconds: 3), (timer) {
      updateVehicles();
    });
  }

  void _onCameraIdle() async {
    if (_map != null) {
      await _map.getVisibleRegion().then((bounds) => _mapBounds = bounds);

      updateVehicles();
    }
  }

  void updateVehicles() async {
    _liveMapBloc.add(GetLiveMapEvent(
      LiveMapRequestModel(
        minX: _mapBounds.southwest.longitude,
        maxX: _mapBounds.northeast.longitude,
        minY: _mapBounds.southwest.latitude,
        maxY: _mapBounds.northeast.latitude,
        onlyRealtime: true,
      ),
    ));
  }

  void _updateMap(final LiveMap res) async {
    Map<String, Set<Marker>> markers = await getMarkers(res);
    setState(() {
      _vehicles.clear();
      _vehicles.addAll(markers['vehicles']);
    });
  }

  Future<Map<String, Set<Marker>>> getMarkers(final LiveMap res) async {
    final Set<Marker> vehicles = {};

    for (var i = 0; i < res.vehicles.length; i++) {
      final Vehicle vehicle = res.vehicles[i];
      final vehicleIcon = await vehicle.getIcon();
      vehicles.add(Marker(
          icon: vehicleIcon,
          markerId: MarkerId(vehicle.gid),
          position: LatLng(vehicle.y, vehicle.x),
          infoWindow: InfoWindow(
            title: vehicle.getName(),
            snippet: vehicle.getDelayString(),
          ),
          onTap: () => print(vehicle.props)));
    }
    final Map<String, Set<Marker>> map = Map();
    map['vehicles'] = vehicles;
    return map;
  }

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LiveMapBloc>(),
      child: BlocBuilder(
        bloc: _liveMapBloc,
        builder: (
          final BuildContext context,
          final LiveMapState state,
        ) {
          if (state is Loaded) {
            _updateMap(state.liveMap);
          }
          return Scaffold(
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
              mapToolbarEnabled: false,
            ),
          );
        },
      ),
    );
  }
}
