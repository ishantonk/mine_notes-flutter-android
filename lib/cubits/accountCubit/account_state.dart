part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountError extends AccountState {
  final Map<String, String> error;
  AccountError(this.error);
}

class AccountSuccess extends AccountState {
  final User? user;
  AccountSuccess(this.user);
}

class AccountLogout extends AccountState {}

class AccountChangeProfile extends AccountState {
  final File profileImage;
  AccountChangeProfile(this.profileImage);
}
