import 'package:deriv_test_app/api/active_symbols/active_symbols.dart';
import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_cubit.dart';
import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

/// Active Symbols Widget class
class ActiveSymbolsWidget extends StatefulWidget {
  /// Active Symbols Widget constructor
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
  Widget build(BuildContext context) => BlocBuilder<ActiveSymbolsCubit,
          ActiveSymbolsState>(
      bloc: activeSymbolsCubit,
      builder: (BuildContext context, ActiveSymbolsState activeSymbolState) {
        if (activeSymbolState is ActiveSymbolsLoading) {
          return const Text('Loading Active Symbols...');
        } else if (activeSymbolState is ActiveSymbolsError) {
          return Text('${activeSymbolState.message}');
        } else if (activeSymbolState is ActiveSymbolsLoaded) {
          final List<ActiveSymbols>? activeSymbols =
              activeSymbolState.activeSymbols;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Active Symbols',
                style: TextStyle(fontSize: 24),
              ),
              DropdownButtonFormField<ActiveSymbols>(
                value: activeSymbols?[0],
                items: activeSymbols
                    ?.map<DropdownMenuItem<ActiveSymbols>>(
                        (ActiveSymbols activeSymbols) =>
                            DropdownMenuItem<ActiveSymbols>(
                              value: activeSymbols,
                              child: Text(activeSymbols.displayName ?? '',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(58, 66, 46, .9))),
                            ))
                    .toList(),
                onChanged: (ActiveSymbols? activeSymbol) {
                  activeSymbolsCubit.updateSelectedSymbol(
                      activeSymbols: activeSymbols,
                      selectedSymbol: activeSymbol);
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        }
        return Container();
      });
}
