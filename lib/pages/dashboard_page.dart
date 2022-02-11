import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_cubit.dart';
import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_state.dart';
import 'package:deriv_test_app/api/active_symbols/active_symbols.dart';
import 'package:deriv_test_app/cubits/availableContracts/available_contracts_cubit.dart';
import 'package:deriv_test_app/cubits/availableContracts/available_contracts_state.dart';
import 'package:deriv_test_app/widgets/active_symbols_widget.dart';
import 'package:deriv_test_app/widgets/available_contracts_widgetl.dart';
import 'package:deriv_test_app/widgets/selected_active_symbol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    super.initState();
    BlocManager.instance.register(ActiveSymbolsCubit(ActiveSymbolsLoading()), key: 'ActiveSymbolsCubit');
    BlocManager.instance.register(AvailableContractsCubit(AvailableContractsLoading()), key: 'AvailableContractsLoading');
  }
  @override
  Widget build(BuildContext context) {
    return Column(
       children: const [
         ActiveSymbolsWidget(),
         SelectedActiveSymbolWidget(),
         AvailableContractsWidget(),
       ],
    );
  }
}
