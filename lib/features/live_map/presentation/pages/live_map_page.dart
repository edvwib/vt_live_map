import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vt_live_map/core/app_drawer/presentation/app_drawer.dart';
import 'package:vt_live_map/core/helpers/navigation.dart';
import 'package:vt_live_map/core/lang/lang.dart';
import 'package:vt_live_map/features/live_map/data/models/live_map_request_model.dart';
import 'package:vt_live_map/features/live_map/domain/entities/live_map.dart';
import 'package:vt_live_map/features/live_map/domain/entities/vehicle.dart';
import 'package:vt_live_map/features/live_map/domain/enum/prod_class.dart';
import 'package:vt_live_map/features/live_map/presentation/bloc/live_map_bloc.dart';
import 'package:vt_live_map/features/live_map/presentation/widgets/multi_select_chip.dart';
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
  Map<MarkerId, Marker> _vehicles = Map();

  Timer _timer;

  // filters
  List<ProdClass> filterVehicleTypes = ProdClass.values.toList();
  List<ProdClass> selectedFilterVehicleTypes = [];

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
    controller.setMapStyle(
        await rootBundle.loadString('assets/google_maps_styles/night.json'));
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
    _liveMapBloc.add(
      GetLiveMapEvent(
        LiveMapRequestModel(
          minX: _mapBounds.southwest.longitude,
          maxX: _mapBounds.northeast.longitude,
          minY: _mapBounds.southwest.latitude,
          maxY: _mapBounds.northeast.latitude,
          onlyRealtime: true,
        ),
        vehicleTypeFilter: this.selectedFilterVehicleTypes,
      ),
    );
  }

  void _updateMap(final LiveMap res) async {
    res.vehicles.forEach((final Vehicle vehicle) async {
      final BitmapDescriptor vehicleIcon = await vehicle.getIcon();
      final MarkerId markerId = MarkerId(vehicle.gid);

      _vehicles.update(markerId, (final Marker marker) {
        final Marker updatedMarker = marker.copyWith(
          positionParam: LatLng(vehicle.y, vehicle.x),
        );
        return updatedMarker;
      }, ifAbsent: () {
        return Marker(
          markerId: markerId,
          icon: vehicleIcon,
          position: LatLng(vehicle.y, vehicle.x),
          anchor: Offset(0.5, 0.5),
          // rotation: vehicle.direction,
          infoWindow: InfoWindow(
            title: vehicle.getName(),
            snippet: vehicle.getDelayString(),
          ),
          onTap: () => print(vehicle.props),
        );
      });
    });
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
          return WillPopScope(
            onWillPop: () => confirmCloseApplication(context),
            child: Scaffold(
              appBar: AppBar(
                title: Text(translate(Lang.APP_VIEW_LIVE_MAP)),
              ),
              drawer: AppDrawer(),
              body: Container(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialView,
                    zoom: 15.0,
                  ),
                  onMapCreated: _onMapCreated,
                  onCameraIdle: _onCameraIdle,
                  markers: Set<Marker>.of(_vehicles.values),
                  myLocationEnabled: true,
                  mapToolbarEnabled: false,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: ThemeData.light().accentColor,
                child: Icon(Icons.directions_bus),
                onPressed: _showVehicleFilterSelections,
              ),
            ),
          );
        },
      ),
    );
  }

  void _showVehicleFilterSelections() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        child: MultiSelectChip(
          filterVehicleTypes,
          selectedFilterVehicleTypes,
          onChanged: (final List<ProdClass> filters) => this.setState(() {
            selectedFilterVehicleTypes = filters;
          }),
        ),
      ),
    );
  }
}
