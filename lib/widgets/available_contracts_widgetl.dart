import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_cubit.dart';
import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_state.dart';
import 'package:deriv_test_app/cubits/availableContracts/available_contracts_cubit.dart';
import 'package:deriv_test_app/cubits/availableContracts/available_contracts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

class AvailableContractsWidget extends StatefulWidget {
  const AvailableContractsWidget({Key? key}) : super(key: key);

  @override
  _AvailableContractsWidgetState createState() => _AvailableContractsWidgetState();
}

class _AvailableContractsWidgetState extends State<AvailableContractsWidget> {
  @override
  void initState() {
    super.initState();
    var activeSymbolCubit = BlocManager.instance.fetch('ActiveSymbolsCubit');
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailableContractsCubit, AvailableContractsState>(
      bloc: BlocManager.instance.fetch('AvailableContractsLoading'),
        builder: (context, contractsState) {
          if(contractsState is AvailableContractsLoaded){
            return ListView(
              children: [
                ...List.generate(contractsState.contracts?.availableContracts?.length ?? 0, (index) => Text('${contractsState.contracts?.availableContracts?[index]?.exchangeName}')).toList()
              ],
            );
          }
        return Container();
      }
    );
  }
}
