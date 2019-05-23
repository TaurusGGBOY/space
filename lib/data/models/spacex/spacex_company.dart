import 'dart:convert';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../util/url.dart';
import '../models.dart';

/// SPACEX-AS-A-COMPAMY MODEL
/// General information about SpaceX's company data.
/// Used in the 'Company' tab, under the SpaceX screen.
class SpacexCompanyModel extends QueryModel {
  Company _company;

  @override
  Future loadData() async {
    // Get items by http call
    final companyResponse = await http.get(Url.spacexCompany);
    response = await http.get(Url.spacexAchievements);

    // Clear old data
    clearItems();

    // Added parsed item
    snapshot = json.decode(response.body);
    items.addAll(
      snapshot.map((achievement) => Achievement.fromJson(achievement)).toList(),
    );

    _company = Company.fromJson(json.decode(companyResponse.body));

    // Add photos & shuffle them
    if (photos.isEmpty) {
      photos.addAll(Url.spacexCompanyScreen);
      photos.shuffle();
    }

    // Finished loading data
    setLoading(false);
  }

  Company get company => _company;
}

class Company {
  final String fullName, name, founder, ceo, cto, coo, city, state, details;
  final List<String> links;
  final num founded, employees, valuation;

  Company({
    this.fullName,
    this.name,
    this.founder,
    this.ceo,
    this.cto,
    this.coo,
    this.city,
    this.state,
    this.links,
    this.details,
    this.founded,
    this.employees,
    this.valuation,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      fullName: 'Space Exploration Technologies Corporation',
      name: json['name'],
      founder: json['founder'],
      ceo: json['ceo'],
      cto: json['cto'],
      coo: json['coo'],
      city: json['headquarters']['city'],
      state: json['headquarters']['state'],
      links: [
        json['links']['website'],
        json['links']['twitter'],
        json['links']['flickr'],
      ],
      details: json['summary'],
      founded: json['founded'],
      employees: json['employees'],
      valuation: json['valuation'],
    );
  }

  String getFounderDate(context) => FlutterI18n.translate(
        context,
        'spacex.company.founded',
        {'founded': founded.toString(), 'founder': founder},
      );

  String get getValuation =>
      NumberFormat.currency(symbol: '\$', decimalDigits: 0).format(valuation);

  String get getLocation => '$city, $state';

  String get getEmployees => NumberFormat.decimalPattern().format(employees);

  List<String> getMenu(context) => <String>[
        FlutterI18n.translate(context, 'spacex.company.menu.website'),
        FlutterI18n.translate(context, 'spacex.company.menu.twitter'),
        FlutterI18n.translate(context, 'spacex.company.menu.flickr')
      ];

  int getMenuIndex(context, url) => getMenu(context).indexOf(url);

  String getUrl(context, name) => links[getMenuIndex(context, name)];
}

/// SPACEX'S ACHIEVMENT MODEL
/// Auxiliary model to storage specific SpaceX's achievments.
class Achievement {
  final String name, details, url;
  final DateTime date;

  Achievement({
    this.name,
    this.details,
    this.url,
    this.date,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      name: json['title'],
      details: json['details'],
      url: json['links']['article'],
      date: DateTime.parse(json['event_date_utc']).toLocal(),
    );
  }

  String get getDate => DateFormat.yMMMMd().format(date);
}
