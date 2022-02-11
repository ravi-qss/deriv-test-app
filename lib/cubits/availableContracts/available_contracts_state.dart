import 'package:deriv_test_app/api/contracts_for/contracts_for_symbol.dart';

/// AvailableContractsState Class
abstract class AvailableContractsState {
  /// AvailableContractsState Empty Constructor
  AvailableContractsState();
}

/// AvailableContracts Loading State
class AvailableContractsLoading extends AvailableContractsState {
  @override
  String toString() => 'AvailableContractsLoading...';
}

/// AvailableContracts Error State
class AvailableContractsError extends AvailableContractsState {
  /// AvailableContracts Error Constructor with Message
  AvailableContractsError(this.message);

  /// AvailableContracts Error Message
  final String? message;

  @override
  String toString() => 'AvailableContractsError';
}

/// AvailableContracts Loaded State
class AvailableContractsLoaded extends AvailableContractsState {
  /// AvailableContracts Constructor with Contracts
  AvailableContractsLoaded({
    this.contracts,
  });

  /// AvailableContracts value
  final ContractsForSymbol? contracts;

  @override
  String toString() =>
      'AvailableContractsLoaded ${contracts!.availableContracts!.length} '
      'contracts';
}
