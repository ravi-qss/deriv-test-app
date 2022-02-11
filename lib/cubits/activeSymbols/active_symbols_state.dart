import 'package:deriv_test_app/api/active_symbols/active_symbols.dart';

/// Active Symbol State
abstract class ActiveSymbolsState {
  /// State Constructor
  ActiveSymbolsState();
}

/// Initialization
class ActiveSymbolsLoading extends ActiveSymbolsState {
  @override
  String toString() => 'ActiveSymbolsLoading...';
}

/// Error State returned with message
class ActiveSymbolsError extends ActiveSymbolsState {
  /// Error message passed
  ActiveSymbolsError(this.message);

  /// Error message
  final String? message;

  @override
  String toString() => 'ActiveSymbolsError';
}

/// Active Symbols loaded
class ActiveSymbolsLoaded extends ActiveSymbolsState {
  /// Active symbols loaded with selected symbol
  ActiveSymbolsLoaded({
    this.activeSymbols,
    ActiveSymbols? selectedSymbol,
  }) : _selectedSymbol = selectedSymbol ?? activeSymbols?.first;

  /// Active symbols list
  final List<ActiveSymbols>? activeSymbols;

  /// Active symbols selected
  final ActiveSymbols? _selectedSymbol;

  /// Active symbols getter
  ActiveSymbols? get selectedSymbol => _selectedSymbol;

  @override
  String toString() => 'ActiveSymbolsLoaded ${activeSymbols!.length} symbols';
}
