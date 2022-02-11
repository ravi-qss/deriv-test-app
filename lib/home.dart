import 'package:deriv_test_app/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/services/connection/api_manager/connection_information.dart';
import 'package:flutter_deriv_api/state/connection/connection_cubit.dart'
    as api_connection;

/// Sample App main widget
class HomeApp extends StatefulWidget {
  /// Home page constructor
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  late api_connection.ConnectionCubit _connectionCubit;

  @override
  void initState() {
    super.initState();
    _connectionCubit = api_connection.ConnectionCubit(
      ConnectionInformation(
        appId: '31125',
        brand: 'binary',
        endpoint: 'frontend.binaryws.com',
      ),
    );
  }

  @override
  void dispose() {
    _connectionCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<api_connection.ConnectionCubit>.value(
            value: _connectionCubit,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Deriv App Sample'),
          ),
          body: BlocBuilder<api_connection.ConnectionCubit,
              api_connection.ConnectionState>(
            builder: (
              BuildContext context,
              api_connection.ConnectionState state,
            ) {
              if (state is api_connection.ConnectionConnectedState) {
                return DashboardPage();
              } else if (state is api_connection.ConnectionInitialState ||
                  state is api_connection.ConnectionConnectingState) {
                return _buildCenterText('Connecting...');
              } else if (state is api_connection.ConnectionErrorState) {
                return _buildCenterText('Connection Error\n${state.error}');
              } else if (state is api_connection.ConnectionDisconnectedState) {
                return _buildCenterText(
                  'Connection is down, trying to reconnect...',
                );
              }

              return Container();
            },
          ),
        ),
      );

  Widget _buildCenterText(String text) => Center(
        child: Text(text),
      );
}
