import 'package:flutter_deriv_api/api/contract/exceptions/contract_exception.dart';
import 'package:flutter_deriv_api/api/models/base_exception_model.dart';

class ContractsForSymbolException extends ContractException {
  ContractsForSymbolException({
    BaseExceptionModel? baseExceptionModel,
  }) : super(baseExceptionModel: baseExceptionModel);
}
