import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

class ConnectivityState extends Equatable {
  final List<ConnectivityResult> results;

  const ConnectivityState({
    required this.results,
  });

  bool get isConnected =>
      !results.contains(ConnectivityResult.none);

  @override
  List<Object?> get props => [results];
}