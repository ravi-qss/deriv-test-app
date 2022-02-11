import 'package:flutter_deriv_api/api/contract/exceptions/contract_exception.dart';
import 'package:flutter_deriv_api/api/models/base_exception_model.dart';

/// ContractsForSymbol Exception class
class ContractsForSymbolException extends ContractException {
  /// ContractsForSymbol Exception Constructor with named parameters
  ContractsForSymbolException({
    BaseExceptionModel? baseExceptionModel,
  }) : super(baseExceptionModel: baseExceptionModel);
}
