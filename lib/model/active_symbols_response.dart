import '../api/active_symbols/active_symbols.dart';

// ignore_for_file: public_member_api_docs
class ActiveSymbolsResponse {
  ActiveSymbolsResponse.fromJson(Map<String, dynamic> json) {
    if (json['active_symbols'] != null) {
      activeSymbols = <ActiveSymbols>[];
      json['active_symbols'].forEach((Map<String, dynamic> v) {
        activeSymbols!.add(ActiveSymbols.fromJson(v));
      });
    }
    echoReq =
        json['echo_req'] != null ? EchoReq.fromJson(json['echo_req']) : null;
    msgType = json['msg_type'];
  }

  List<ActiveSymbols>? activeSymbols;
  EchoReq? echoReq;

  String? msgType;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (activeSymbols != null) {
      data['active_symbols'] =
          activeSymbols!.map((ActiveSymbols v) => v.toJson()).toList();
    }
    if (echoReq != null) {
      data['echo_req'] = echoReq!.toJson();
    }
    data['msg_type'] = msgType;
    return data;
  }
}

class EchoReq {
  EchoReq.fromJson(Map<String, dynamic> json) {
    activeSymbols = json['active_symbols'];
    productType = json['product_type'];
  }

  String? activeSymbols;

  String? productType;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active_symbols'] = activeSymbols;
    data['product_type'] = productType;
    return data;
  }
}
