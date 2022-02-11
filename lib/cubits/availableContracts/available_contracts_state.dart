import 'package:deriv_test_app/api/contracts_for/contracts_for_symbol.dart';

abstract class AvailableContractsState {
  AvailableContractsState();
}

class AvailableContractsLoading extends AvailableContractsState {
  @override
  String toString() => 'AvailableContractsLoading...';
}

class AvailableContractsError extends AvailableContractsState {
  AvailableContractsError(this.message);

  final String? message;

  @override
  String toString() => 'AvailableContractsError';
}

class AvailableContractsLoaded extends AvailableContractsState {
  AvailableContractsLoaded({
    this.contracts,
  });

  final ContractsForSymbol? contracts;

  @override
  String toString() =>
      'AvailableContractsLoaded ${contracts!.availableContracts!.length} contracts';
}
