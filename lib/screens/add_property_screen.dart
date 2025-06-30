import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/property.dart';
import '../providers/property_providers.dart';

class AddPropertyScreen extends ConsumerStatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  ConsumerState<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends ConsumerState<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _currentValueController = TextEditingController();
  final _monthlyRentController = TextEditingController();
  final _monthlyExpensesController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bathroomsController = TextEditingController();
  final _squareFeetController = TextEditingController();
  final _descriptionController = TextEditingController();

  PropertyType _selectedType = PropertyType.singleFamily;
  PropertyStatus _selectedStatus = PropertyStatus.vacant;
  DateTime _purchaseDate = DateTime.now();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _purchasePriceController.dispose();
    _currentValueController.dispose();
    _monthlyRentController.dispose();
    _monthlyExpensesController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _squareFeetController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Property'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _saveProperty,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information
              _sectionTitle('Basic Information'),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Property Name *',
                  hintText: 'e.g., Sunset Villa',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a property name';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Street Address *',
                  hintText: 'e.g., 123 Maple Street',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        labelText: 'City *',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _stateController,
                      decoration: const InputDecoration(
                        labelText: 'State *',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _zipController,
                      decoration: const InputDecoration(
                        labelText: 'ZIP *',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Property Details
              _sectionTitle('Property Details'),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<PropertyType>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'Property Type'),
                items: PropertyType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(_getTypeDisplayName(type)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ),
              
              const SizedBox(height: 16),
              
              DropdownButtonFormField<PropertyStatus>(
                value: _selectedStatus,
                decoration: const InputDecoration(labelText: 'Status'),
                items: PropertyStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(_getStatusDisplayName(status)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedStatus = value);
                  }
                },
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _bedroomsController,
                      decoration: const InputDecoration(labelText: 'Bedrooms'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _bathroomsController,
                      decoration: const InputDecoration(labelText: 'Bathrooms'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _squareFeetController,
                      decoration: const InputDecoration(labelText: 'Sq Ft'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Financial Information
              _sectionTitle('Financial Information'),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _purchasePriceController,
                decoration: const InputDecoration(
                  labelText: 'Purchase Price *',
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter purchase price';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _currentValueController,
                decoration: const InputDecoration(
                  labelText: 'Current Value',
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.number,
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _monthlyRentController,
                      decoration: const InputDecoration(
                        labelText: 'Monthly Rent',
                        prefixText: '\$',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _monthlyExpensesController,
                      decoration: const InputDecoration(
                        labelText: 'Monthly Expenses',
                        prefixText: '\$',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              InkWell(
                onTap: () => _selectPurchaseDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Purchase Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(_formatDate(_purchaseDate)),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Description
              _sectionTitle('Description'),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'Add any additional details about the property...',
                ),
                maxLines: 3,
              ),
              
              const SizedBox(height: 32),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saveProperty,
                  child: const Text('Add Property'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _getTypeDisplayName(PropertyType type) {
    switch (type) {
      case PropertyType.singleFamily:
        return 'Single Family';
      case PropertyType.multiFamily:
        return 'Multi Family';
      case PropertyType.condo:
        return 'Condo';
      case PropertyType.townhouse:
        return 'Townhouse';
      case PropertyType.apartment:
        return 'Apartment';
      case PropertyType.commercial:
        return 'Commercial';
    }
  }

  String _getStatusDisplayName(PropertyStatus status) {
    switch (status) {
      case PropertyStatus.vacant:
        return 'Vacant';
      case PropertyStatus.occupied:
        return 'Occupied';
      case PropertyStatus.maintenance:
        return 'Maintenance';
      case PropertyStatus.forSale:
        return 'For Sale';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  Future<void> _selectPurchaseDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _purchaseDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _purchaseDate) {
      setState(() => _purchaseDate = picked);
    }
  }

  void _saveProperty() {
    if (_formKey.currentState!.validate()) {
      final property = Property(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        address: _addressController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipController.text,
        type: _selectedType,
        status: _selectedStatus,
        purchasePrice: double.tryParse(_purchasePriceController.text) ?? 0,
        currentValue: double.tryParse(_currentValueController.text) ?? 
                     double.tryParse(_purchasePriceController.text) ?? 0,
        monthlyRent: double.tryParse(_monthlyRentController.text) ?? 0,
        monthlyExpenses: double.tryParse(_monthlyExpensesController.text) ?? 0,
        bedrooms: int.tryParse(_bedroomsController.text) ?? 0,
        bathrooms: int.tryParse(_bathroomsController.text) ?? 0,
        squareFeet: double.tryParse(_squareFeetController.text) ?? 0,
        purchaseDate: _purchaseDate,
        lastUpdated: DateTime.now(),
        description: _descriptionController.text.isNotEmpty 
                    ? _descriptionController.text 
                    : null,
      );

      ref.read(propertyListProvider.notifier).addProperty(property);
      
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${property.name} added successfully!')),
      );
    }
  }
}