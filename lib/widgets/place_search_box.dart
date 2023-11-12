import 'dart:convert';

import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class PlaceSearchBox extends StatelessWidget {
  final Coordination currLocation;
  late final String generatedUUID;
  final Function(dynamic) onSuggestionsSelected;
  final TextEditingController textController = TextEditingController();
  final String? label;
  final String? hint;

  PlaceSearchBox(
      {super.key,
      required this.currLocation,
      required this.onSuggestionsSelected,
      this.label,
      this.hint}) {
    generatedUUID = const Uuid().v4();
  }

  Future<Iterable<dynamic>> getSuggestions(String search) async {
    var log = Logger();
    if (search.isEmpty) return {};
    try {
      var url = Uri.https('api.mapbox.com', '/search/searchbox/v1/suggest', {
        "q": search,
        "language": "en",
        "limit": "6",
        "proximity": "${currLocation.lng},${currLocation.lat}",
        "country": "DE",
        "session_token": generatedUUID,
        "access_token":
            "pk.eyJ1IjoiaGthMTQiLCJhIjoiY2xvdzBydjF5MHpkdjJqcTBrbHU5NDZwMCJ9.yXnbi5q-VCJUGBkjW1h2bA"
      });
      //bas64 to string
      var response = await http.get(url);
      var body = jsonDecode(response.body);
      return body["suggestions"] as Iterable<dynamic>;
    } catch (e) {
      log.e(e);
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
          autofocus: true,
          controller: textController,
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(fontStyle: FontStyle.italic),
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hint,
              labelText: label,
              prefixIcon: const Icon(Icons.search))),
      suggestionsCallback: (pattern) async {
        return await getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Icon(Icons.location_on),
          title: Text(suggestion["name"]),
          subtitle: Text(suggestion["full_address"] ?? ""),
        );
      },
      onSuggestionSelected: (suggestion) {
        Logger()..i(suggestion);
        textController.text = suggestion["full_address"] ?? suggestion["name"];
        onSuggestionsSelected(suggestion);
      },
    );
  }

// "https://api.mapbox.com/search/searchbox/v1/suggest?q=Michigan%20Stadium?language=en&limit=1&session_token=[GENERATED-UUID]&proximity=-83.748708,42.265837&country=US&access_token=pk.eyJ1IjoiaGthMTQiLCJhIjoiY2xodDEyMGU2MDFjdTNqcGJvbzM2aWs5eiJ9.w0JOpd7FH5Na4d9_8BuVMA"
}
