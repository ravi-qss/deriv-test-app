import 'package:deriv_test_app/api/active_symbols/active_symbols.dart';
import 'package:deriv_test_app/api/contracts_for/contracts_for_symbol.dart';
import 'package:deriv_test_app/cubits/availableContracts/available_contracts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';

class AvailableContractsCubit extends Cubit<AvailableContractsState> {
  AvailableContractsCubit(AvailableContractsState initialState)
      : super(initialState);

  void getAvailableContracts(ActiveSymbols? selectedSymbol) async {
    emit(AvailableContractsLoading());
    var result = await _fetchAvailableContracts(selectedSymbol);
    try {
      emit(AvailableContractsLoaded(contracts: result));
    } on Exception catch (e) {
      debugPrint(' $AvailableContractsCubit getActiveSymbols() error $e');
      emit(AvailableContractsError(e.toString()));
    }
  }

  Future<ContractsForSymbol> _fetchAvailableContracts(
    ActiveSymbols? selectedSymbol,
  ) async =>
      ContractsForSymbol.fetchContractsForSymbol(
        ContractsForRequest(contractsFor: selectedSymbol?.symbol),
      );
}
