import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connectivity_service.dart';
import 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final ConnectivityService _service;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityCubit(this._service)
      : super(
          const ConnectivityState(
            results: [ConnectivityResult.wifi],
          ),
        ) {
    _initialize();
  }

  Future<void> _initialize() async {
    final initial = await Connectivity().checkConnectivity();

    emit(
      ConnectivityState(
        results: initial,
      ),
    );

    _subscription =
        _service.onConnectivityChanged.listen((results) {
      emit(
        ConnectivityState(
          results: results,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}