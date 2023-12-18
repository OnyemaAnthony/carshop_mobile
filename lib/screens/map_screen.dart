import 'package:carshop_mobile/blocs/map/map_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_events.dart';
import 'package:carshop_mobile/blocs/map/map_states.dart';
import 'package:carshop_mobile/screens/block_app_screen.dart';
import 'package:carshop_mobile/screens/post_swipe_screen.dart';
import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBloc()..add(GetCurrentLocationEvent()),
      child: BlocConsumer<MapBloc, MapState>(
        builder: (context, state) {
          MapBloc mapBloc = BlocProvider.of<MapBloc>(context);
          return SafeArea(
            child: MapWidget(
                styleUri: MapboxStyles.MAPBOX_STREETS,
                resourceOptions: ResourceOptions(
                  accessToken: ApiKeys.mapBoxAccessToken,
                ),
                onMapCreated: (mapbox) => mapBloc.mapboxMap = mapbox,
                onTapListener: (coordinate) async {
                  if (mapBloc.mapboxMap == null) return;

                  mapBloc.add(FetchPostsEvent(location: coordinate));
                }),
          );
        },
        listener: (BuildContext context, MapState state) {
          if (state is GetUserLocationError) {
            UiUtilities.pushNavBar(context, const BlockAppScreen(), false);
          } else if (state is GetUserLocationSuccess) {
            context.read<MapBloc>().add(GetMapFeedEvent());
          } else if (state is DataReady) {
            UiUtilities.pushNavBar(
                context,
                PostSwipeScreen(
                  posts: state.posts ?? [],
                  deliveryPosts: state.deliveryPosts ?? [],
                ),
                false);
          }
        },
      ),
    );
  }
}
