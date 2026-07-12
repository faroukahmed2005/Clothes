part of 'address_cubit.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<AddressModel> addresses;

  AddressLoaded(this.addresses);
}

class AddressFailure extends AddressState {
  final String msg;

  AddressFailure(this.msg);
}