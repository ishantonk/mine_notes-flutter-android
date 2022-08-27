part of 'network_cubit.dart';

@immutable
abstract class NetworkState {}

class NetworkInitial extends NetworkState {}

class NetworkConnected extends NetworkState {}

class NetworkDisconnected extends NetworkState {}

class NetworkLoading extends NetworkState {}

class NetworkError extends NetworkState {}
