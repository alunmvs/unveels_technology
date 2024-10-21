
/*
 *


 *
 * /
 */

import 'package:equatable/equatable.dart';

import '../../../models/address/add_address_request.dart';

abstract class AddressBookScreenEvent extends Equatable {
  const AddressBookScreenEvent();

  @override
  List<Object> get props => [];
}

class AddressBookScreenDataFetchEvent extends AddressBookScreenEvent {
  const AddressBookScreenDataFetchEvent(this.forDashboard);

  final int forDashboard;

  @override
  List<Object> get props => [forDashboard];
}

class DeleteAddressEvent extends AddressBookScreenEvent{
  const DeleteAddressEvent(this.addressId);
  final String addressId;
}

class AddAddressEvent extends AddressBookScreenEvent {
  final AddAddressRequest addAddressRequest;
  final String addressId;

  const AddAddressEvent(this.addressId,this.addAddressRequest);

  @override
  List<Object> get props => [];
}

class LoadingAddressEvent extends AddressBookScreenEvent{}

