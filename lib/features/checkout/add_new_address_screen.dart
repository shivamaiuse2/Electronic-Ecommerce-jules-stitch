import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../shared/widgets/electro_text_field.dart';
import '../../shared/widgets/electro_button.dart';
import 'address_bloc.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _titleController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.containerMargin),
        child: Column(
          children: [
            ElectroTextField(hintText: 'Address Title (e.g. Home, Office)', controller: _titleController),
            const SizedBox(height: 16),
            ElectroTextField(hintText: 'Full Name', controller: _nameController),
            const SizedBox(height: 16),
            ElectroTextField(hintText: 'Phone Number', keyboardType: TextInputType.phone, controller: _phoneController),
            const SizedBox(height: 16),
            ElectroTextField(hintText: 'Street Address', controller: _streetController),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: ElectroTextField(hintText: 'City', controller: _cityController)),
                const SizedBox(width: 16),
                Expanded(child: ElectroTextField(hintText: 'State', controller: _stateController)),
              ],
            ),
            const SizedBox(height: 16),
            ElectroTextField(hintText: 'Zip Code', keyboardType: TextInputType.number, controller: _zipController),
            const SizedBox(height: 32),
            ElectroButton(
              text: 'Save Address',
              onPressed: () {
                final address = Address(
                  title: _titleController.text,
                  fullName: _nameController.text,
                  phone: _phoneController.text,
                  street: _streetController.text,
                  city: _cityController.text,
                  state: _stateController.text,
                  zip: _zipController.text,
                );
                context.read<AddressBloc>().add(AddAddress(address));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
