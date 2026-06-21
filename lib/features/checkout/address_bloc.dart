import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../core/services/local_storage_service.dart';

class Address extends Equatable {
  final String title;
  final String fullName;
  final String phone;
  final String street;
  final String city;
  final String state;
  final String zip;

  const Address({
    required this.title,
    required this.fullName,
    required this.phone,
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'fullName': fullName,
    'phone': phone,
    'street': street,
    'city': city,
    'state': state,
    'zip': zip,
  };

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    title: json['title'],
    fullName: json['fullName'],
    phone: json['phone'],
    street: json['street'],
    city: json['city'],
    state: json['state'],
    zip: json['zip'],
  );

  @override
  List<Object?> get props => [title, fullName, phone, street, city, state, zip];
}

class AddressState extends Equatable {
  final List<Address> addresses;
  final int selectedIndex;

  const AddressState({this.addresses = const [], this.selectedIndex = 0});

  @override
  List<Object?> get props => [addresses, selectedIndex];
}

abstract class AddressEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAddresses extends AddressEvent {}
class AddAddress extends AddressEvent {
  final Address address;
  AddAddress(this.address);
  @override
  List<Object?> get props => [address];
}
class SelectAddress extends AddressEvent {
  final int index;
  SelectAddress(this.index);
  @override
  List<Object?> get props => [index];
}

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(const AddressState()) {
    on<LoadAddresses>((event, emit) {
      final jsonStr = LocalStorageService.getString('addresses');
      if (jsonStr != null) {
        final List<dynamic> decoded = json.decode(jsonStr);
        final addresses = decoded.map((a) => Address.fromJson(a)).toList();
        emit(AddressState(addresses: addresses, selectedIndex: 0));
      } else {
        // Initial mock address
        const initial = Address(
          title: 'Home',
          fullName: 'John Doe',
          phone: '+1 234 567 890',
          street: '123 Tech Lane',
          city: 'Silicon Valley',
          state: 'CA',
          zip: '94025',
        );
        emit(const AddressState(addresses: [initial], selectedIndex: 0));
      }
    });

    on<AddAddress>((event, emit) {
      final updated = List<Address>.from(state.addresses)..add(event.address);
      emit(AddressState(addresses: updated, selectedIndex: state.selectedIndex));
      _save(updated);
    });

    on<SelectAddress>((event, emit) {
      emit(AddressState(addresses: state.addresses, selectedIndex: event.index));
    });
  }

  void _save(List<Address> addresses) {
    LocalStorageService.setString('addresses', json.encode(addresses.map((a) => a.toJson()).toList()));
  }
}
