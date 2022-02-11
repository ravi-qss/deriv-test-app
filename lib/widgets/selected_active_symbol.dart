import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_cubit.dart';
import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

class SelectedActiveSymbolWidget extends StatefulWidget {
  const SelectedActiveSymbolWidget({Key? key}) : super(key: key);

  @override
  _SelectedActiveSymbolWidgetState createState() => _SelectedActiveSymbolWidgetState();
}

class _SelectedActiveSymbolWidgetState extends State<SelectedActiveSymbolWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveSymbolsCubit, ActiveSymbolsState>(
      bloc: BlocManager.instance.fetch('ActiveSymbolsCubit'),
        builder: (context, activeSymbolState) {
          if(activeSymbolState is ActiveSymbolsLoaded){
            return Text('${activeSymbolState.selectedSymbol?.displayName }\n ${activeSymbolState.selectedSymbol?.marketDisplayName }');
          }
        return Container();
      }
    );
  }
}
