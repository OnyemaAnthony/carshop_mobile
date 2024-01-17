import 'package:carshop_mobile/blocs/map/map_bloc.dart';
import 'package:carshop_mobile/blocs/map/map_events.dart';
import 'package:carshop_mobile/blocs/map/map_states.dart';
import 'package:carshop_mobile/screens/block_app_screen.dart';
import 'package:carshop_mobile/screens/swipe_post_screen.dart';
import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/shared_widgets/dayno_loading_indicator.dart';
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
            child: Stack(
              children: [
                MapWidget(
                    styleUri: state.mapboxUrl,
                    resourceOptions: ResourceOptions(
                      accessToken: ApiKeys.mapBoxAccessToken,
                    ),
                    onMapCreated: (mapbox) => mapBloc.mapboxMap = mapbox,
                    onTapListener: (coordinate) async {
                      if (mapBloc.mapboxMap == null) return;
                      if (state.lockMapTap) return;
                      mapBloc.add(FetchPostsEvent(location: coordinate));
                    }),
                if (state.lockMapTap) const DaynoLoadingIndicator(),
              ],
            ),
          );
        },
        listener: (BuildContext context, MapState state) {
          MapBloc mapBloc = BlocProvider.of<MapBloc>(context);
          if (state.mapMessage == MapMessage.failedToGetLocation) {
            UiUtilities.pushNavBar(context, const BlockAppScreen(), false);
          } else if (state.mapMessage == MapMessage.succeededToGetLocation) {
            mapBloc.add(GetMapFeedEvent());
          } else if (state.mapMessage == MapMessage.dataLoaded) {
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
