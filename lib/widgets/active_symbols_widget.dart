import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_cubit.dart';
import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_state.dart';
import 'package:deriv_test_app/model/active_symbols.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

class ActiveSymbolsWidget extends StatefulWidget {
  const ActiveSymbolsWidget({Key? key}) : super(key: key);

  @override
  _ActiveSymbolsWidgetState createState() => _ActiveSymbolsWidgetState();
}

class _ActiveSymbolsWidgetState extends State<ActiveSymbolsWidget> {

   late ActiveSymbolsCubit activeSymbolsCubit;
  @override
  void initState() {
    super.initState();
    activeSymbolsCubit = BlocManager.instance.fetch('ActiveSymbolsCubit');
    activeSymbolsCubit.getActiveSymbols();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveSymbolsCubit, ActiveSymbolsState>(
      bloc: activeSymbolsCubit,
      builder: (context, activeSymbolState) {
        if(activeSymbolState is ActiveSymbolsLoading) {
          return const Text('Loading Active Symbols...');
        }
        if(activeSymbolState is ActiveSymbolsError){
          return Text('${activeSymbolState.message}');
        }

        if(activeSymbolState is ActiveSymbolsLoaded){
          var activeSymbols = activeSymbolState.activeSymbols;
          return DropdownButtonFormField(
            decoration:  const InputDecoration(icon: Icon(Icons.language)), //, color: Colors.white10
            value: activeSymbols?[0],
            items: activeSymbols?.map<DropdownMenuItem<ActiveSymbols>>((ActiveSymbols activeSymbols) {

              return  DropdownMenuItem<ActiveSymbols>(
                value: activeSymbols,
                child: Text(activeSymbols.displayName ?? '', style: const TextStyle(color: Color.fromRGBO(58, 66, 46, .9))),
              );
            })
                .toList(),

            onChanged: (ActiveSymbols? activeSymbol){
              activeSymbolsCubit.onChange(Change(currentState: activeSymbolState, nextState: ActiveSymbolsLoaded(activeSymbols: activeSymbols, selectedSymbol: activeSymbol)));
            },
          );
        }
       return Container();
      }
    );
  }
}
