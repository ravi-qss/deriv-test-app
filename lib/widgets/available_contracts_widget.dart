import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_cubit.dart';
import 'package:deriv_test_app/cubits/activeSymbols/active_symbols_state.dart';
import 'package:deriv_test_app/cubits/availableContracts/available_contracts_cubit.dart';
import 'package:deriv_test_app/cubits/availableContracts/available_contracts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

/// AvailableContracts Widget Class
class AvailableContractsWidget extends StatefulWidget {
  /// AvailableContracts Widget Constructor
  const AvailableContractsWidget({Key? key}) : super(key: key);

  @override
  _AvailableContractsWidgetState createState() =>
      _AvailableContractsWidgetState();
}

class _AvailableContractsWidgetState extends State<AvailableContractsWidget> {
  late AvailableContractsCubit availableContractsCubit;

  @override
  void initState() {
    super.initState();
    final ActiveSymbolsCubit activeSymbolCubit =
        BlocManager.instance.fetch('ActiveSymbolsCubit');
    availableContractsCubit =
        BlocManager.instance.fetch('AvailableContractsCubit');
    activeSymbolCubit.stream.listen((ActiveSymbolsState state) {
      if (state is ActiveSymbolsLoaded) {
        if (state.selectedSymbol != null) {
          availableContractsCubit.getAvailableContracts(state.selectedSymbol);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AvailableContractsCubit, AvailableContractsState>(
          bloc: availableContractsCubit,
          builder:
              (BuildContext context, AvailableContractsState contractsState) {
            if (contractsState is AvailableContractsLoading) {
              return const Center(
                child: Text('Loading Available Contracts...'),
              );
            } else if (contractsState is AvailableContractsError) {
              return Text(contractsState.message ?? 'An error occurred');
            } else if (contractsState is AvailableContractsLoaded) {
              return ListView(
                children: <Widget>[
                  const Text(
                    'Available Contracts',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...List<Widget>.generate(
                      contractsState.contracts?.availableContracts?.length ?? 0,
                      (int index) => Column(
                            children: <Widget>[
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Expanded(
                                          child: Text('Category:'),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                              '${contractsState.contracts?.availableContracts?[index]?.contractCategory}'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Expanded(
                                          child: Text('Name:'),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                              '${contractsState.contracts?.availableContracts?[index]?.exchangeName}'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Expanded(
                                          child: Text('Market:'),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                              '${contractsState.contracts?.availableContracts?[index]?.market}'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Expanded(
                                          child: Text('Sub-Market:'),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                              '${contractsState.contracts?.availableContracts?[index]?.submarket}'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          )).toList()
                ],
              );
            }
            return Container();
          });
}
