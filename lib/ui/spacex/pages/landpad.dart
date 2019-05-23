import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:latlong/latlong.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../data/models/spacex/landpad.dart';
import '../../../util/colors.dart';
import '../../../util/menu.dart';
import '../../../util/url.dart';
import '../../general/loading_indicator.dart';
import '../../general/row_item.dart';
import '../../general/separator.dart';

/// LANDPAD PAGE VIEW
/// This view displays information about a specific landpad,
/// where rockets now land.
class LandpadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LandpadModel>(
      builder: (context, child, model) => Scaffold(
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                actions: <Widget>[
                  PopupMenuButton<String>(
                    itemBuilder: (_) => Menu.wikipedia
                        .map((string) => PopupMenuItem(
                              value: string,
                              child: Text(
                                FlutterI18n.translate(context, string),
                              ),
                            ))
                        .toList(),
                    onSelected: (_) async =>
                        await FlutterWebBrowser.openWebPage(
                          url: model.landpad.url,
                          androidToolbarColor: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(model.id),
                  background: model.isLoading
                      ? LoadingIndicator()
                      : FlutterMap(
                          options: MapOptions(
                            center: LatLng(
                              model.landpad.coordinates[0],
                              model.landpad.coordinates[1],
                            ),
                            zoom: 6.0,
                            minZoom: 5.0,
                            maxZoom: 10.0,
                          ),
                          layers: <LayerOptions>[
                            TileLayerOptions(
                              urlTemplate: Url.mapView,
                              subdomains: ['a', 'b', 'c', 'd'],
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            MarkerLayerOptions(markers: [
                              Marker(
                                width: 45.0,
                                height: 45.0,
                                point: LatLng(
                                  model.landpad.coordinates[0],
                                  model.landpad.coordinates[1],
                                ),
                                builder: (_) => const Icon(
                                      Icons.location_on,
                                      color: locationPin,
                                      size: 45.0,
                                    ),
                              )
                            ])
                          ],
                        ),
                ),
              ),
              model.isLoading
                  ? SliverFillRemaining(child: LoadingIndicator())
                  : SliverToBoxAdapter(child: _buildBody())
            ]),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<LandpadModel>(
      builder: (context, child, model) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              Text(
                model.landpad.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.status',
                ),
                model.landpad.getStatus,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.location',
                ),
                model.landpad.location,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.state',
                ),
                model.landpad.state,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.coordinates',
                ),
                model.landpad.getCoordinates,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.landing_type',
                ),
                model.landpad.type,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.pad.landings_successful',
                ),
                model.landpad.getSuccessfulLandings,
              ),
              Separator.divider(),
              Text(
                model.landpad.details,
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: Theme.of(context).textTheme.caption.color),
              ),
            ]),
          ),
    );
  }
}
