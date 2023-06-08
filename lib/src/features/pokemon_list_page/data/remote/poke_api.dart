import 'package:graphql_flutter/graphql_flutter.dart';

class PokeAPI {
  late final GraphQLClient _client;
  PokeAPI() {
    final HttpLink httpLink = HttpLink(
      'https://beta.pokeapi.co/graphql/v1beta',
    );

    _client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  }

  Future<QueryResult<Object?>> makeQuery(
    String query,
    Map<String, dynamic> variables,
  ) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables,
    );
    return await _client.query(options);
  }
}
