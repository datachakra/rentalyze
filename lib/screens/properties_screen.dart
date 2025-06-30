import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/property.dart';
import '../providers/property_providers.dart';
import 'property_details_screen.dart';
import 'add_property_screen.dart';

class PropertiesScreen extends ConsumerStatefulWidget {
  const PropertiesScreen({super.key});

  @override
  ConsumerState<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends ConsumerState<PropertiesScreen> {
  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(filteredPropertiesProvider);
    final filter = ref.watch(propertyFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => _showFilterDialog(context),
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter Properties',
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPropertyScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add Property',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search properties...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: filter.searchQuery?.isNotEmpty == true
                        ? IconButton(
                            onPressed: () {
                              ref.read(propertyFilterProvider.notifier).state =
                                  filter.copyWith(searchQuery: '');
                            },
                            icon: const Icon(Icons.clear),
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    ref.read(propertyFilterProvider.notifier).state = filter
                        .copyWith(searchQuery: value);
                  },
                ),
                const SizedBox(height: 8),
                // Active filters display
                if (filter.status != null || filter.type != null)
                  Wrap(
                    spacing: 8,
                    children: [
                      if (filter.status != null)
                        Chip(
                          label: Text(filter.status!.name),
                          onDeleted: () {
                            ref.read(propertyFilterProvider.notifier).state =
                                filter.copyWith(status: null);
                          },
                        ),
                      if (filter.type != null)
                        Chip(
                          label: Text(filter.type!.name),
                          onDeleted: () {
                            ref.read(propertyFilterProvider.notifier).state =
                                filter.copyWith(type: null);
                          },
                        ),
                    ],
                  ),
              ],
            ),
          ),

          // Properties List
          Expanded(
            child: properties.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_work_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No properties found',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add your first property to get started',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddPropertyScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Property'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      final property = properties[index];
                      return PropertyCard(property: property);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const FilterDialog());
  }
}

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({required this.property, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetailsScreen(property: property),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                image: property.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(property.imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: property.imageUrl == null ? Colors.grey[300] : null,
              ),
              child: property.imageUrl == null
                  ? Icon(
                      _getPropertyIcon(property.type),
                      size: 60,
                      color: Colors.grey[500],
                    )
                  : null,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property name and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property.name,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            property.status,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          property.statusDisplayName,
                          style: TextStyle(
                            color: _getStatusColor(property.status),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Address
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.fullAddress,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Property details
                  Row(
                    children: [
                      Icon(Icons.home, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        property.typeDisplayName,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.bed, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${property.bedrooms}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.bathtub, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${property.bathrooms}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Financial info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Monthly Rent',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '\$${property.monthlyRent.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Cash Flow',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '\$${property.monthlyCashFlow.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: property.monthlyCashFlow >= 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(PropertyStatus status) {
    switch (status) {
      case PropertyStatus.occupied:
        return Colors.green;
      case PropertyStatus.vacant:
        return Colors.orange;
      case PropertyStatus.maintenance:
        return Colors.red;
      case PropertyStatus.forSale:
        return Colors.blue;
    }
  }

  IconData _getPropertyIcon(PropertyType type) {
    switch (type) {
      case PropertyType.singleFamily:
        return Icons.home;
      case PropertyType.multiFamily:
        return Icons.apartment;
      case PropertyType.condo:
        return Icons.business;
      case PropertyType.townhouse:
        return Icons.villa;
      case PropertyType.apartment:
        return Icons.location_city;
      case PropertyType.commercial:
        return Icons.store;
    }
  }
}

class FilterDialog extends ConsumerWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(propertyFilterProvider);

    return AlertDialog(
      title: const Text('Filter Properties'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Status'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: filter.status == null,
                onSelected: (selected) {
                  if (selected) {
                    ref.read(propertyFilterProvider.notifier).state = filter
                        .copyWith(status: null);
                  }
                },
              ),
              ...PropertyStatus.values.map(
                (status) => ChoiceChip(
                  label: Text(status.name),
                  selected: filter.status == status,
                  onSelected: (selected) {
                    ref.read(propertyFilterProvider.notifier).state = filter
                        .copyWith(status: selected ? status : null);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Type'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: filter.type == null,
                onSelected: (selected) {
                  if (selected) {
                    ref.read(propertyFilterProvider.notifier).state = filter
                        .copyWith(type: null);
                  }
                },
              ),
              ...PropertyType.values.map(
                (type) => ChoiceChip(
                  label: Text(_getTypeDisplayName(type)),
                  selected: filter.type == type,
                  onSelected: (selected) {
                    ref.read(propertyFilterProvider.notifier).state = filter
                        .copyWith(type: selected ? type : null);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(propertyFilterProvider.notifier).state = PropertyFilter();
            Navigator.pop(context);
          },
          child: const Text('Clear All'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Apply'),
        ),
      ],
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
}
