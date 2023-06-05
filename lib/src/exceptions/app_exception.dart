import 'package:graphql_flutter/graphql_flutter.dart';

sealed class AppException {
  AppException(this.code, this.message);
  final String code;
  final String message;
}

class PokemonTypeColorNotFoundException extends AppException {
  PokemonTypeColorNotFoundException()
      : super(
          'pokemon-type-color-not-found',
          'Color not found',
        );
}

class CouldNotQueryDataException extends AppException {
  CouldNotQueryDataException(this.data)
      : super(
          'could-not-query-data',
          'Could not query data',
        );
  final OperationException? data;
}
