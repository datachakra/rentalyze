import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/property.dart';
import '../data/mock_properties.dart';

// Property list provider
final propertyListProvider = StateNotifierProvider<PropertyListNotifier, List<Property>>((ref) {
  return PropertyListNotifier();
});

// Property list notifier
class PropertyListNotifier extends StateNotifier<List<Property>> {
  PropertyListNotifier() : super(MockProperties.properties);

  void addProperty(Property property) {
    state = [...state, property];
  }

  void updateProperty(Property updatedProperty) {
    state = [
      for (final property in state)
        if (property.id == updatedProperty.id) updatedProperty else property,
    ];
  }

  void deleteProperty(String propertyId) {
    state = state.where((property) => property.id != propertyId).toList();
  }

  List<Property> getPropertiesByStatus(PropertyStatus status) {
    return state.where((property) => property.status == status).toList();
  }

  List<Property> getPropertiesByType(PropertyType type) {
    return state.where((property) => property.type == type).toList();
  }
}

// Selected property provider
final selectedPropertyProvider = StateProvider<Property?>((ref) => null);

// Portfolio summary provider
final portfolioSummaryProvider = Provider<Map<String, dynamic>>((ref) {
  final properties = ref.watch(propertyListProvider);
  
  if (properties.isEmpty) {
    return {
      'totalProperties': 0,
      'occupiedProperties': 0,
      'occupancyRate': 0.0,
      'totalValue': 0.0,
      'totalInvestment': 0.0,
      'totalEquity': 0.0,
      'monthlyRent': 0.0,
      'monthlyExpenses': 0.0,
      'monthlyCashFlow': 0.0,
      'annualCashFlow': 0.0,
      'portfolioROI': 0.0,
    };
  }
  
  final totalProperties = properties.length;
  final occupiedProperties = properties.where((p) => p.status == PropertyStatus.occupied).length;
  final totalValue = properties.fold<double>(0, (sum, p) => sum + p.currentValue);
  final totalInvestment = properties.fold<double>(0, (sum, p) => sum + p.purchasePrice);
  final monthlyRent = properties.fold<double>(0, (sum, p) => sum + p.monthlyRent);
  final monthlyExpenses = properties.fold<double>(0, (sum, p) => sum + p.monthlyExpenses);
  final totalEquity = properties.fold<double>(0, (sum, p) => sum + p.equity);
  
  return {
    'totalProperties': totalProperties,
    'occupiedProperties': occupiedProperties,
    'occupancyRate': totalProperties > 0 ? occupiedProperties / totalProperties * 100 : 0.0,
    'totalValue': totalValue,
    'totalInvestment': totalInvestment,
    'totalEquity': totalEquity,
    'monthlyRent': monthlyRent,
    'monthlyExpenses': monthlyExpenses,
    'monthlyCashFlow': monthlyRent - monthlyExpenses,
    'annualCashFlow': (monthlyRent - monthlyExpenses) * 12,
    'portfolioROI': totalInvestment > 0 ? ((monthlyRent - monthlyExpenses) * 12) / totalInvestment * 100 : 0.0,
  };
});

// Property filter provider
final propertyFilterProvider = StateProvider<PropertyFilter>((ref) => PropertyFilter());

class PropertyFilter {
  final PropertyStatus? status;
  final PropertyType? type;
  final String? searchQuery;

  PropertyFilter({
    this.status,
    this.type,
    this.searchQuery,
  });

  PropertyFilter copyWith({
    PropertyStatus? status,
    PropertyType? type,
    String? searchQuery,
  }) {
    return PropertyFilter(
      status: status ?? this.status,
      type: type ?? this.type,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

// Filtered properties provider
final filteredPropertiesProvider = Provider<List<Property>>((ref) {
  final properties = ref.watch(propertyListProvider);
  final filter = ref.watch(propertyFilterProvider);

  var filtered = properties;

  if (filter.status != null) {
    filtered = filtered.where((p) => p.status == filter.status).toList();
  }

  if (filter.type != null) {
    filtered = filtered.where((p) => p.type == filter.type).toList();
  }

  if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
    final query = filter.searchQuery!.toLowerCase();
    filtered = filtered.where((p) =>
        p.name.toLowerCase().contains(query) ||
        p.address.toLowerCase().contains(query) ||
        p.city.toLowerCase().contains(query)).toList();
  }

  return filtered;
});