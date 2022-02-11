import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_cubit.dart';
import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_state.dart';
import 'package:deriv_test_app/cubits/tickStream/tick_stream_cubit.dart';
import 'package:deriv_test_app/cubits/tickStream/ticks_stream_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

class SelectedActiveSymbolWidget extends StatefulWidget {
  const SelectedActiveSymbolWidget({Key? key}) : super(key: key);

  @override
  _SelectedActiveSymbolWidgetState createState() =>
      _SelectedActiveSymbolWidgetState();
}

class _SelectedActiveSymbolWidgetState
    extends State<SelectedActiveSymbolWidget> {
  late TickStreamCubit tickStreamCubit;
  late ActiveSymbolsCubit activeSymbolCubit;

  double? _lastAskTickValue = 0;
  double? _lastBidTickValue = 0;
  IconData askTickDirection = Icons.arrow_drop_up;

  @override
  void initState() {
    super.initState();
    activeSymbolCubit = BlocManager.instance.fetch('ActiveSymbolsCubit');
    tickStreamCubit = BlocManager.instance.fetch('TickStreamCubit');
    activeSymbolCubit.stream.listen((state) {
      if (state is ActiveSymbolsLoaded) {
        if (state.selectedSymbol != null) {
          tickStreamCubit.getTicksForSymbol(state.selectedSymbol);
        }
      }
    });
  }

  @override
  void dispose() {
    tickStreamCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ActiveSymbolsCubit, ActiveSymbolsState>(
            bloc: activeSymbolCubit,
            builder: (context, activeSymbolState) {
              if (activeSymbolState is ActiveSymbolsLoading) {
                return const Text('Loading Active Symbols...');
              } else if (activeSymbolState is ActiveSymbolsError) {
                return Text('${activeSymbolState.message}');
              } else if (activeSymbolState is ActiveSymbolsLoaded) {
                return Row(
                  children: [
                    const Expanded(flex: 1, child: Text('Symbol Name')),
                    Expanded(
                        flex: 2,
                        child: Text(
                            '${activeSymbolState.selectedSymbol?.displayName}')),
                  ],
                );
              }
              return Container();
            }),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<TickStreamCubit, TicksStreamState>(
            bloc: tickStreamCubit,
            builder: (context, tickState) {
              if (tickState is TicksLoading) {
                return const CircularProgressIndicator();
              } else if (tickState is TicksError) {
                return Text(tickState.message ?? 'An error occurred');
              } else if (tickState is TicksLoaded) {
                final Color askTickColor =
                    tickState.tick!.ask! > _lastAskTickValue!
                        ? Colors.green
                        : Colors.red;

                final IconData askTickDirection =
                    tickState.tick!.bid! > _lastBidTickValue!
                        ? Icons.arrow_upward
                        : Icons.arrow_downward;

                _lastAskTickValue = tickState.tick!.ask;
                _lastBidTickValue = tickState.tick!.bid;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text('Price'),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${tickState.tick?.ask}',
                                style: TextStyle(color: askTickColor),
                              ),
                              Icon(
                                askTickDirection,
                                color: askTickColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Container();
            }),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
