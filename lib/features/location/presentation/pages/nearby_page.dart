import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vt_live_map/core/lang/lang.dart';
import 'package:vt_live_map/features/location/data/models/nearby_stops_request_model.dart';
import 'package:vt_live_map/features/location/domain/entities/nearby_stops.dart';
import 'package:vt_live_map/features/location/domain/entities/stop.dart';
import 'package:vt_live_map/features/location/presentation/bloc/nearby_bloc.dart';
import 'package:vt_live_map/injection_container.dart';

class NearbyPage extends StatefulWidget {
  @override
  NearbyPageState createState() => NearbyPageState();
}

class NearbyPageState extends State<NearbyPage> {
  NearbyBloc _nearbyBloc;

  NearbyStops _nearbyStops;
  List<Stop> _stops = [];

  @override
  void initState() {
    super.initState();

    _nearbyBloc = sl<NearbyBloc>();

    requestLocationPermission();
  }

  @override
  void dispose() {
    _nearbyBloc?.close();

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

        _nearbyBloc.add(
          GetNearbyStopsEvent(
            NearbyStopsRequestModel(
              latitude: currentLatLng.latitude,
              longitude: currentLatLng.longitude,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NearbyBloc>(),
      child: BlocBuilder(
        bloc: _nearbyBloc,
        builder: (
          final BuildContext context,
          final NearbyState state,
        ) {
          if (state is LoadedNearbyStops) {
            _nearbyStops = state.nearbyStops;
            _stops = state.nearbyStops.stops;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(translate(Lang.APP_DRAWER_NEARBY)),
            ),
            body: ListView.builder(
                itemCount: _stops.length,
                itemBuilder: (final BuildContext context, final int index) {
                  return ListTile(
                    title: Text(_stops[index].name),
                    subtitle: Text(
                        _stops[index].track == null ? '' : _stops[index].track),
                  );
                }),
          );
        },
      ),
    );
  }
}
