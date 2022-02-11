import 'package:deriv_test_app/api/active_symbols/active_symbols.dart';
import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';

class ActiveSymbolsCubit extends Cubit<ActiveSymbolsState> {
  ActiveSymbolsCubit(ActiveSymbolsState initialState) : super(initialState);

  void getActiveSymbols() async {
    var result = await _fetchActiveSymbols();
    try {
      emit(ActiveSymbolsLoaded(activeSymbols: result));
    } on Exception catch (e) {
      debugPrint(' $ActiveSymbolsCubit getActiveSymbols() error $e');
      emit(ActiveSymbolsError(e.toString()));
    }
  }

  Future<List<ActiveSymbols>> _fetchActiveSymbols() async =>
      ActiveSymbols.fetchActiveSymbols(const ActiveSymbolsRequest(
        activeSymbols: 'brief',
        productType: 'basic',
      ));

  void updateSelectedSymbol(
          {required List<ActiveSymbols>? activeSymbols,
          required ActiveSymbols? selectedSymbol}) =>
      emit(ActiveSymbolsLoaded(
          activeSymbols: activeSymbols, selectedSymbol: selectedSymbol));
}
