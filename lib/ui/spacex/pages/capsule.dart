import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../data/models/spacex/details_capsule.dart';
import '../../../data/models/spacex/mission_item.dart';
import '../../general/cache_image.dart';
import '../../general/loading_indicator.dart';
import '../../general/row_item.dart';
import '../../general/separator.dart';

/// CAPSULE PAGE VIEW
/// This view displays information about a specific capsule,
/// used in a NASA mission.
class CapsulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => Scaffold(
            body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(FlutterI18n.translate(
                    context,
                    'spacex.dialog.vehicle.title_capsule',
                    {'serial': model.id},
                  )),
                  background: model.isLoading
                      ? LoadingIndicator()
                      : Swiper(
                          itemCount: model.getPhotosCount,
                          itemBuilder: (_, index) => CacheImage(
                                model.getPhoto(index),
                              ),
                          autoplay: true,
                          autoplayDelay: 6000,
                          duration: 750,
                          onTap: (index) async =>
                              await FlutterWebBrowser.openWebPage(
                                url: model.getPhoto(index),
                                androidToolbarColor:
                                    Theme.of(context).primaryColor,
                              ),
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
    return ScopedModelDescendant<CapsuleModel>(
      builder: (context, child, model) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.model',
                ),
                model.capsule.name,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.status',
                ),
                model.capsule.getStatus,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.first_launched',
                ),
                model.capsule.getFirstLaunched(context),
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.launches',
                ),
                model.capsule.getLaunches,
              ),
              Separator.spacer(),
              RowItem.textRow(
                context,
                FlutterI18n.translate(
                  context,
                  'spacex.dialog.vehicle.splashings',
                ),
                model.capsule.getSplashings,
              ),
              Separator.divider(),
              model.capsule.hasMissions
                  ? Column(children: <Widget>[
                      Column(
                        children: model.capsule.missions
                            .map((mission) => _getMission(
                                  context,
                                  model.capsule.missions,
                                  mission,
                                ))
                            .toList(),
                      ),
                      Separator.divider(),
                    ])
                  : Separator.none(),
              Text(
                model.capsule.getDetails(context),
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

  Column _getMission(BuildContext context, List missions, MissionItem mission) {
    return Column(children: <Widget>[
      RowItem.textRow(
        context,
        FlutterI18n.translate(
          context,
          'spacex.dialog.vehicle.mission',
          {'number': mission.id.toString()},
        ),
        mission.name,
      ),
      mission != missions.last ? Separator.spacer() : Separator.none(),
    ]);
  }
}
