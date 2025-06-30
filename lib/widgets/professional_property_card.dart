import 'package:flutter/material.dart';
import '../models/property.dart';
import '../theme/app_theme.dart';

class ProfessionalPropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback? onTap;

  const ProfessionalPropertyCard({
    required this.property,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.surfaceGray200),
        boxShadow: AppShadows.softShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceGray100,
                    image: property.imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(property.imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Stack(
                    children: [
                      if (property.imageUrl == null)
                        Center(
                          child: Icon(
                            _getPropertyIcon(property.type),
                            size: 48,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      // Status Badge
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(property.status),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            property.statusDisplayName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      // Property Type Badge
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            property.typeDisplayName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Property Details
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Property Name and Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                property.name,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.textPrimary,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                    color: AppTheme.textMuted,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      property.fullAddress,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: AppTheme.textSecondary,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${_formatNumber(property.monthlyRent)}/mo',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.successGreen,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${_formatNumber(property.currentValue)}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Property Features
                    Row(
                      children: [
                        _FeatureChip(
                          icon: Icons.bed_outlined,
                          value: '${property.bedrooms}',
                          label: 'bed',
                        ),
                        const SizedBox(width: 8),
                        _FeatureChip(
                          icon: Icons.bathtub_outlined,
                          value: '${property.bathrooms}',
                          label: 'bath',
                        ),
                        const SizedBox(width: 8),
                        _FeatureChip(
                          icon: Icons.square_foot,
                          value: _formatNumber(property.squareFeet),
                          label: 'sq ft',
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: property.monthlyCashFlow >= 0
                                ? AppTheme.successGreen.withValues(alpha: 0.1)
                                : AppTheme.errorRed.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                property.monthlyCashFlow >= 0
                                    ? Icons.trending_up
                                    : Icons.trending_down,
                                size: 14,
                                color: property.monthlyCashFlow >= 0
                                    ? AppTheme.successGreen
                                    : AppTheme.errorRed,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${property.annualROI.toStringAsFixed(1)}% ROI',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: property.monthlyCashFlow >= 0
                                      ? AppTheme.successGreen
                                      : AppTheme.errorRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Financial Metrics
                    Row(
                      children: [
                        Expanded(
                          child: _FinancialMetric(
                            label: 'Cash Flow',
                            value: '\$${_formatNumber(property.monthlyCashFlow)}',
                            isPositive: property.monthlyCashFlow >= 0,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _FinancialMetric(
                            label: 'Equity',
                            value: '\$${_formatNumber(property.equity)}',
                            isPositive: property.equity >= 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(PropertyStatus status) {
    return StatusColors.getStatusColor(status.name);
  }

  IconData _getPropertyIcon(PropertyType type) {
    switch (type) {
      case PropertyType.singleFamily:
        return Icons.home_outlined;
      case PropertyType.multiFamily:
        return Icons.apartment_outlined;
      case PropertyType.condo:
        return Icons.business_outlined;
      case PropertyType.townhouse:
        return Icons.villa_outlined;
      case PropertyType.apartment:
        return Icons.location_city_outlined;
      case PropertyType.commercial:
        return Icons.store_mall_directory_outlined;
    }
  }

  String _formatNumber(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)}K';
    } else {
      return number.toStringAsFixed(0);
    }
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _FeatureChip({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.textSecondary),
          const SizedBox(width: 4),
          Text(
            '$value $label',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FinancialMetric extends StatelessWidget {
  final String label;
  final String value;
  final bool isPositive;

  const _FinancialMetric({
    required this.label,
    required this.value,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textTertiary,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isPositive ? AppTheme.successGreen : AppTheme.errorRed,
              ),
        ),
      ],
    );
  }
}