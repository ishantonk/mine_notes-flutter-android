import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mine_notes/cubits/cubits.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;
  NetworkCubit() : super(NetworkInitial());

  // Check if the device is connected to the internet
  checkConnection() {
    emit(NetworkLoading());
    _subscription = _connectivity.onConnectivityChanged.listen(
      (result) {
        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          emit(NetworkConnected());
        } else if (result == ConnectivityResult.none) {
          emit(NetworkDisconnected());
        } else {
          emit(NetworkError());
        }
      },
    );
  }

  // Get the snackbar according to the state.
  SnackBar getSnackbar(BuildContext context, NetworkState state) {
    if (state is NetworkLoading) {
      return const SnackBar(
        content: Text('Checking internet connection...'),
        backgroundColor: Colors.blue,
        clipBehavior: Clip.antiAlias,
        dismissDirection: DismissDirection.none,
        duration: Duration(seconds: 3),
      );
    } else if (state is NetworkConnected) {
      return const SnackBar(
        content: Text('Connected to internet.'),
        backgroundColor: Colors.green,
        clipBehavior: Clip.antiAlias,
        dismissDirection: DismissDirection.none,
        duration: Duration(seconds: 3),
      );
    } else if (state is NetworkDisconnected) {
      return const SnackBar(
        content: Text('No internet connection'),
        backgroundColor: Colors.red,
        clipBehavior: Clip.antiAlias,
        dismissDirection: DismissDirection.none,
        duration: Duration(seconds: 3),
      );
    } else if (state is NetworkError) {
      return const SnackBar(
        content: Text('Error'),
        backgroundColor: Colors.red,
        clipBehavior: Clip.antiAlias,
        dismissDirection: DismissDirection.none,
        duration: Duration(seconds: 3),
      );
    }
    throw Exception('Unknown state');
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
