import 'package:flutter_deriv_api/api/common/tick/tick.dart';

/// Tick Stream State class
abstract class TicksStreamState {
  /// Tick Stream State constructor
  TicksStreamState();
}

/// Tick Stream Loading State
class TicksLoading extends TicksStreamState {
  @override
  String toString() => 'TicksLoading...';
}

/// Tick Stream Error State
class TicksError extends TicksStreamState {
  /// Tick Stream Constructor with Error Message
  TicksError(this.message);

  /// Tick Stream Error Message
  final String? message;

  @override
  String toString() => 'TicksError';
}

/// Tick Stream Loaded State
class TicksLoaded extends TicksStreamState {
  /// Tick Loaded Constructor with Tick
  TicksLoaded(this.tick);

  /// Tick value
  final Tick? tick;

  @override
  String toString() => 'Tick $tick loaded';
}
