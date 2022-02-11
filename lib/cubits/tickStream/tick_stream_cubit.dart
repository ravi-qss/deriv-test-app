import 'package:deriv_test_app/api/active_symbols/active_symbols.dart';
import 'package:deriv_test_app/cubits/tickStream/ticks_stream_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/forget/forget_all.dart';
import 'package:flutter_deriv_api/api/common/tick/exceptions/tick_exception.dart';
import 'package:flutter_deriv_api/api/common/tick/tick.dart';
import 'package:flutter_deriv_api/basic_api/generated/ticks_send.dart';

class TickStreamCubit extends Cubit<TicksStreamState> {
  TickStreamCubit(TicksStreamState initialState) : super(initialState);

  void getTicksForSymbol(ActiveSymbols? selectedSymbol) async {
    emit(TicksLoading());
    await _unsubscribeTick();

    _subscribeTick(selectedSymbol!)
        .handleError((dynamic error) => error is TickException
            ? emit(TicksError(error.message))
            : emit(TicksError(error.toString())))
        .listen((Tick? tick) => emit(TicksLoaded(tick)));
  }

  Stream<Tick?> _subscribeTick(ActiveSymbols selectedSymbol) =>
      Tick.subscribeTick(
        TicksRequest(ticks: selectedSymbol.symbol),
      );

  Future<ForgetAll> _unsubscribeTick() => Tick.unsubscribeAllTicks();

  @override
  Future<void> close() async {
    await _unsubscribeTick();

    await super.close();
  }
}
