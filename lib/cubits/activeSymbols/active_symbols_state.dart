import 'package:deriv_test_app/api/active_symbols/active_symbols.dart';

abstract class ActiveSymbolsState {
  ActiveSymbolsState();
}

class ActiveSymbolsLoading extends ActiveSymbolsState {
  @override
  String toString() => 'ActiveSymbolsLoading...';
}

class ActiveSymbolsError extends ActiveSymbolsState {
  ActiveSymbolsError(this.message);

  final String? message;

  @override
  String toString() => 'ActiveSymbolsError';
}

class ActiveSymbolsLoaded extends ActiveSymbolsState {
  ActiveSymbolsLoaded({
    this.activeSymbols,
    ActiveSymbols? selectedSymbol,
  }) : _selectedSymbol = selectedSymbol ?? activeSymbols?.first;

  final List<ActiveSymbols>? activeSymbols;

  final ActiveSymbols? _selectedSymbol;

  ActiveSymbols? get selectedSymbol => _selectedSymbol;

  @override
  String toString() => 'ActiveSymbolsLoaded ${activeSymbols!.length} symbols';
}
