enum PropertyType {
  singleFamily,
  multiFamily,
  condo,
  townhouse,
  apartment,
  commercial,
}

enum PropertyStatus {
  vacant,
  occupied,
  maintenance,
  forSale,
}

class Property {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final PropertyType type;
  final PropertyStatus status;
  final double purchasePrice;
  final double currentValue;
  final double monthlyRent;
  final double monthlyExpenses;
  final int bedrooms;
  final int bathrooms;
  final double squareFeet;
  final DateTime purchaseDate;
  final DateTime? lastUpdated;
  final String? imageUrl;
  final String? description;
  final List<String> amenities;
  final String? tenantName;
  final DateTime? leaseStart;
  final DateTime? leaseEnd;

  Property({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.type,
    required this.status,
    required this.purchasePrice,
    required this.currentValue,
    required this.monthlyRent,
    required this.monthlyExpenses,
    required this.bedrooms,
    required this.bathrooms,
    required this.squareFeet,
    required this.purchaseDate,
    this.lastUpdated,
    this.imageUrl,
    this.description,
    this.amenities = const [],
    this.tenantName,
    this.leaseStart,
    this.leaseEnd,
  });

  // Calculate ROI
  double get monthlyROI => (monthlyRent - monthlyExpenses) / purchasePrice * 100;
  
  // Calculate annual ROI
  double get annualROI => monthlyROI * 12;
  
  // Calculate monthly cash flow
  double get monthlyCashFlow => monthlyRent - monthlyExpenses;
  
  // Calculate annual cash flow
  double get annualCashFlow => monthlyCashFlow * 12;
  
  // Calculate equity
  double get equity => currentValue - purchasePrice;
  
  // Get property type display name
  String get typeDisplayName {
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
  
  // Get status display name
  String get statusDisplayName {
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
  
  // Get full address
  String get fullAddress => '$address, $city, $state $zipCode';
}