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
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.surfaceGray200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row: Property Type, Status, and ROI
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceGray100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getPropertyIcon(property.type),
                            size: 12,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            property.typeDisplayName,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(property.status),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        property.statusDisplayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: property.annualROI >= 0
                            ? AppTheme.successGreen.withValues(alpha: 0.1)
                            : AppTheme.errorRed.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            property.annualROI >= 0
                                ? Icons.trending_up
                                : Icons.trending_down,
                            size: 10,
                            color: property.annualROI >= 0
                                ? AppTheme.successGreen
                                : AppTheme.errorRed,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${property.annualROI.toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: property.annualROI >= 0
                                  ? AppTheme.successGreen
                                  : AppTheme.errorRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Property Name and Price Row
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            property.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textPrimary,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 12,
                                color: AppTheme.textMuted,
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  property.fullAddress,
                                  style: const TextStyle(
                                    fontSize: 11,
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
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${_formatNumber(property.monthlyRent)}/mo',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.successGreen,
                              ),
                        ),
                        Text(
                          '\$${_formatNumber(property.currentValue)}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Features and Financial Metrics Row
                Row(
                  children: [
                    // Property Features
                    Expanded(
                      child: Row(
                        children: [
                          _CompactFeature(
                            icon: Icons.bed_outlined,
                            value: '${property.bedrooms}',
                          ),
                          const SizedBox(width: 8),
                          _CompactFeature(
                            icon: Icons.bathtub_outlined,
                            value: '${property.bathrooms}',
                          ),
                          const SizedBox(width: 8),
                          _CompactFeature(
                            icon: Icons.square_foot,
                            value: _formatNumber(property.squareFeet),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Financial Metrics
                    Row(
                      children: [
                        _CompactMetric(
                          label: 'Cash Flow',
                          value: '\$${_formatNumber(property.monthlyCashFlow)}',
                          isPositive: property.monthlyCashFlow >= 0,
                        ),
                        const SizedBox(width: 12),
                        _CompactMetric(
                          label: 'Equity',
                          value: '\$${_formatNumber(property.equity)}',
                          isPositive: property.equity >= 0,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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

class _CompactFeature extends StatelessWidget {
  final IconData icon;
  final String value;

  const _CompactFeature({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppTheme.textSecondary),
        const SizedBox(width: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _CompactMetric extends StatelessWidget {
  final String label;
  final String value;
  final bool isPositive;

  const _CompactMetric({
    required this.label,
    required this.value,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            color: AppTheme.textTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isPositive ? AppTheme.successGreen : AppTheme.errorRed,
          ),
        ),
      ],
    );
  }
}
