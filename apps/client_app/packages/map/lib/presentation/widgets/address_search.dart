import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:map/data/service/get_location_service.dart';
import 'package:map/domain/entity/suggestion.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider apiClient = PlaceApiProvider('');

  @override
  Widget buildResults(BuildContext context) => throw UnimplementedError();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: context.getText('clear'),
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: context.getText('back'),
      icon: const Icon(Icons.arrow_back),
      onPressed: () => context.navigator.pop(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query,
              Localizations.localeOf(context).languageCode,
            ),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text('Enter Your Address ...'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    return ListTile(
                      title: Text(data.description),
                      onTap: () => close(context, data),
                    );
                  },
                  itemCount: snapshot.data!.length,
                )
              : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
