import 'package:flutter_deriv_api/services/connection/api_manager/base_api.dart';
import 'package:flutter_deriv_api/services/dependency_injector/injector.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';

class ActiveSymbols {
  int? allowForwardStarting;
  String? displayName;
  int? exchangeIsOpen;
  int? isTradingSuspended;
  String? market;
  String? marketDisplayName;
  double? pip;
  String? submarket;
  String? submarketDisplayName;
  String? symbol;
  String? symbolType;

  ActiveSymbols(
      {allowForwardStarting,
        displayName,
        exchangeIsOpen,
        isTradingSuspended,
        market,
        marketDisplayName,
        pip,
        submarket,
        submarketDisplayName,
        symbol,
        symbolType});

  ActiveSymbols.fromJson(Map<String, dynamic> json) {
    allowForwardStarting = json['allow_forward_starting'];
    displayName = json['display_name'];
    exchangeIsOpen = json['exchange_is_open'];
    isTradingSuspended = json['is_trading_suspended'];
    market = json['market'];
    marketDisplayName = json['market_display_name'];
    pip = json['pip'];
    submarket = json['submarket'];
    submarketDisplayName = json['submarket_display_name'];
    symbol = json['symbol'];
    symbolType = json['symbol_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['allow_forward_starting'] = allowForwardStarting;
    data['display_name'] = displayName;
    data['exchange_is_open'] = exchangeIsOpen;
    data['is_trading_suspended'] = isTradingSuspended;
    data['market'] = market;
    data['market_display_name'] = marketDisplayName;
    data['pip'] = pip;
    data['submarket'] = submarket;
    data['submarket_display_name'] = submarketDisplayName;
    data['symbol'] = symbol;
    data['symbol_type'] = symbolType;
    return data;
  }

  static final BaseAPI _api = Injector.getInjector().get<BaseAPI>()!;

  static Future<List<ActiveSymbols>> fetchActiveSymbols(
      ActiveSymbolsRequest request,
      ) async {
    final ActiveSymbolsResponse response =
    await _api.call<ActiveSymbolsResponse>(
      request: request,
    );

    return response.activeSymbols!
        .map<ActiveSymbols>(
            (dynamic symbolEntry) => ActiveSymbols.fromJson(symbolEntry))
        .toList();
  }
}