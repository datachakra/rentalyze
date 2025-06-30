import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/property.dart';
import '../providers/property_providers.dart';

class PropertyDetailsScreen extends ConsumerWidget {
  final Property property;

  const PropertyDetailsScreen({required this.property, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(property.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => _showEditDialog(context, ref),
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Property',
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete Property'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteDialog(context, ref);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
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
                      size: 80,
                      color: Colors.grey[500],
                    )
                  : null,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              property.name,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              property.fullAddress,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(property.status).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          property.statusDisplayName,
                          style: TextStyle(
                            color: _getStatusColor(property.status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Financial Overview Cards
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _FinancialCard(
                        title: 'Monthly Rent',
                        value: '\$${property.monthlyRent.toStringAsFixed(0)}',
                        icon: Icons.attach_money,
                        color: Colors.green,
                      ),
                      _FinancialCard(
                        title: 'Monthly Expenses',
                        value: '\$${property.monthlyExpenses.toStringAsFixed(0)}',
                        icon: Icons.trending_down,
                        color: Colors.red,
                      ),
                      _FinancialCard(
                        title: 'Cash Flow',
                        value: '\$${property.monthlyCashFlow.toStringAsFixed(0)}',
                        icon: Icons.account_balance_wallet,
                        color: property.monthlyCashFlow >= 0 ? Colors.green : Colors.red,
                      ),
                      _FinancialCard(
                        title: 'ROI',
                        value: '${property.annualROI.toStringAsFixed(1)}%',
                        icon: Icons.trending_up,
                        color: Colors.blue,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Property Details
                  _sectionTitle('Property Details'),
                  const SizedBox(height: 16),
                  _detailRow('Type', property.typeDisplayName),
                  _detailRow('Bedrooms', '${property.bedrooms}'),
                  _detailRow('Bathrooms', '${property.bathrooms}'),
                  _detailRow('Square Feet', '${property.squareFeet.toStringAsFixed(0)} sq ft'),
                  _detailRow('Purchase Price', '\$${property.purchasePrice.toStringAsFixed(0)}'),
                  _detailRow('Current Value', '\$${property.currentValue.toStringAsFixed(0)}'),
                  _detailRow('Purchase Date', _formatDate(property.purchaseDate)),

                  const SizedBox(height: 24),

                  // Tenant Information (if occupied)
                  if (property.status == PropertyStatus.occupied && property.tenantName != null) ...[
                    _sectionTitle('Tenant Information'),
                    const SizedBox(height: 16),
                    _detailRow('Tenant', property.tenantName!),
                    if (property.leaseStart != null)
                      _detailRow('Lease Start', _formatDate(property.leaseStart!)),
                    if (property.leaseEnd != null)
                      _detailRow('Lease End', _formatDate(property.leaseEnd!)),
                    const SizedBox(height: 24),
                  ],

                  // Amenities
                  if (property.amenities.isNotEmpty) ...[
                    _sectionTitle('Amenities'),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: property.amenities.map((amenity) => Chip(
                        label: Text(amenity),
                        backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      )).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Description
                  if (property.description != null) ...[
                    _sectionTitle('Description'),
                    const SizedBox(height: 16),
                    Text(
                      property.description!,
                      style: TextStyle(
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Investment Analysis
                  _sectionTitle('Investment Analysis'),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _analysisRow('Total Investment', '\$${property.purchasePrice.toStringAsFixed(0)}'),
                          _analysisRow('Current Value', '\$${property.currentValue.toStringAsFixed(0)}'),
                          _analysisRow('Equity Gain', '\$${property.equity.toStringAsFixed(0)}'),
                          const Divider(),
                          _analysisRow('Monthly Income', '\$${property.monthlyRent.toStringAsFixed(0)}'),
                          _analysisRow('Monthly Expenses', '\$${property.monthlyExpenses.toStringAsFixed(0)}'),
                          _analysisRow('Monthly Cash Flow', '\$${property.monthlyCashFlow.toStringAsFixed(0)}'),
                          const Divider(),
                          _analysisRow('Annual Cash Flow', '\$${property.annualCashFlow.toStringAsFixed(0)}'),
                          _analysisRow('Annual ROI', '${property.annualROI.toStringAsFixed(2)}%'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _analysisRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
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

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Property'),
        content: const Text('Property editing feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Property'),
        content: Text('Are you sure you want to delete ${property.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(propertyListProvider.notifier).deleteProperty(property.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to list
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${property.name} deleted')),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _FinancialCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _FinancialCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}