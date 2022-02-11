import 'package:flutter_deriv_api/api/common/tick/tick.dart';

abstract class TicksStreamState {
  TicksStreamState();
}

class TicksLoading extends TicksStreamState {
  @override
  String toString() => 'TicksLoading...';
}

class TicksError extends TicksStreamState {
  TicksError(this.message);

  final String? message;

  @override
  String toString() => 'TicksError';
}

class TicksLoaded extends TicksStreamState {
  TicksLoaded(this.tick);

  final Tick? tick;

  @override
  String toString() => 'Tick $tick loaded';
}
