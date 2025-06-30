import '../models/property.dart';

class MockProperties {
  static final List<Property> properties = [
    Property(
      id: '1',
      name: 'Sunset Villa',
      address: '123 Maple Street',
      city: 'Austin',
      state: 'TX',
      zipCode: '78701',
      type: PropertyType.singleFamily,
      status: PropertyStatus.occupied,
      purchasePrice: 350000,
      currentValue: 420000,
      monthlyRent: 2800,
      monthlyExpenses: 1200,
      bedrooms: 3,
      bathrooms: 2,
      squareFeet: 1800,
      purchaseDate: DateTime(2022, 3, 15),
      lastUpdated: DateTime.now(),
      imageUrl:
          'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=400',
      description:
          'Beautiful single-family home in a quiet neighborhood with great schools nearby.',
      amenities: ['Garage', 'Garden', 'Updated Kitchen', 'Hardwood Floors'],
      tenantName: 'John & Sarah Smith',
      leaseStart: DateTime(2023, 1, 1),
      leaseEnd: DateTime(2024, 12, 31),
    ),
    Property(
      id: '2',
      name: 'Downtown Loft',
      address: '456 Oak Avenue',
      city: 'Dallas',
      state: 'TX',
      zipCode: '75201',
      type: PropertyType.condo,
      status: PropertyStatus.vacant,
      purchasePrice: 280000,
      currentValue: 320000,
      monthlyRent: 2200,
      monthlyExpenses: 800,
      bedrooms: 2,
      bathrooms: 2,
      squareFeet: 1200,
      purchaseDate: DateTime(2023, 8, 20),
      lastUpdated: DateTime.now(),
      imageUrl:
          'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400',
      description:
          'Modern loft in the heart of downtown with city views and premium amenities.',
      amenities: ['City View', 'Gym Access', 'Rooftop Pool', 'Concierge'],
    ),
    Property(
      id: '3',
      name: 'Family Duplex',
      address: '789 Pine Road',
      city: 'Houston',
      state: 'TX',
      zipCode: '77001',
      type: PropertyType.multiFamily,
      status: PropertyStatus.occupied,
      purchasePrice: 450000,
      currentValue: 485000,
      monthlyRent: 3400,
      monthlyExpenses: 1800,
      bedrooms: 6,
      bathrooms: 4,
      squareFeet: 2800,
      purchaseDate: DateTime(2021, 11, 5),
      lastUpdated: DateTime.now(),
      imageUrl:
          'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=400',
      description:
          'Well-maintained duplex with two 3-bedroom units, perfect for rental income.',
      amenities: [
        'Two Units',
        'Separate Entrances',
        'Parking',
        'Laundry Hookups',
      ],
      tenantName: 'Multiple Tenants',
      leaseStart: DateTime(2023, 6, 1),
      leaseEnd: DateTime(2024, 5, 31),
    ),
    Property(
      id: '4',
      name: 'Lakeside Townhouse',
      address: '321 Elm Court',
      city: 'San Antonio',
      state: 'TX',
      zipCode: '78201',
      type: PropertyType.townhouse,
      status: PropertyStatus.maintenance,
      purchasePrice: 320000,
      currentValue: 360000,
      monthlyRent: 2500,
      monthlyExpenses: 1000,
      bedrooms: 3,
      bathrooms: 3,
      squareFeet: 1600,
      purchaseDate: DateTime(2022, 9, 12),
      lastUpdated: DateTime.now(),
      imageUrl:
          'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=400',
      description:
          'Charming townhouse near the lake with modern updates and great potential.',
      amenities: ['Lake Access', 'Patio', 'Fireplace', 'Attached Garage'],
    ),
    Property(
      id: '5',
      name: 'Urban Studio',
      address: '654 Broadway',
      city: 'Austin',
      state: 'TX',
      zipCode: '78702',
      type: PropertyType.apartment,
      status: PropertyStatus.occupied,
      purchasePrice: 180000,
      currentValue: 200000,
      monthlyRent: 1400,
      monthlyExpenses: 600,
      bedrooms: 1,
      bathrooms: 1,
      squareFeet: 650,
      purchaseDate: DateTime(2023, 2, 28),
      lastUpdated: DateTime.now(),
      imageUrl:
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400',
      description:
          'Compact studio apartment in trendy area, perfect for young professionals.',
      amenities: [
        'Modern Appliances',
        'High Ceilings',
        'Natural Light',
        'Walk Score 95',
      ],
      tenantName: 'Emily Johnson',
      leaseStart: DateTime(2023, 9, 1),
      leaseEnd: DateTime(2024, 8, 31),
    ),
    Property(
      id: '6',
      name: 'Retail Space',
      address: '987 Main Street',
      city: 'Dallas',
      state: 'TX',
      zipCode: '75202',
      type: PropertyType.commercial,
      status: PropertyStatus.occupied,
      purchasePrice: 650000,
      currentValue: 720000,
      monthlyRent: 4800,
      monthlyExpenses: 2200,
      bedrooms: 0,
      bathrooms: 2,
      squareFeet: 2400,
      purchaseDate: DateTime(2021, 7, 10),
      lastUpdated: DateTime.now(),
      imageUrl:
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400',
      description:
          'Prime retail location with high foot traffic and excellent visibility.',
      amenities: [
        'Street Parking',
        'Display Windows',
        'Storage Area',
        'Loading Dock',
      ],
      tenantName: 'Coffee & More LLC',
      leaseStart: DateTime(2023, 1, 1),
      leaseEnd: DateTime(2025, 12, 31),
    ),
  ];

  // Get portfolio summary
  static Map<String, dynamic> getPortfolioSummary() {
    final totalProperties = properties.length;
    final occupiedProperties = properties
        .where((p) => p.status == PropertyStatus.occupied)
        .length;
    final totalValue = properties.fold<double>(
      0,
      (sum, p) => sum + p.currentValue,
    );
    final totalInvestment = properties.fold<double>(
      0,
      (sum, p) => sum + p.purchasePrice,
    );
    final monthlyRent = properties.fold<double>(
      0,
      (sum, p) => sum + p.monthlyRent,
    );
    final monthlyExpenses = properties.fold<double>(
      0,
      (sum, p) => sum + p.monthlyExpenses,
    );
    final totalEquity = properties.fold<double>(0, (sum, p) => sum + p.equity);

    return {
      'totalProperties': totalProperties,
      'occupiedProperties': occupiedProperties,
      'occupancyRate': occupiedProperties / totalProperties * 100,
      'totalValue': totalValue,
      'totalInvestment': totalInvestment,
      'totalEquity': totalEquity,
      'monthlyRent': monthlyRent,
      'monthlyExpenses': monthlyExpenses,
      'monthlyCashFlow': monthlyRent - monthlyExpenses,
      'annualCashFlow': (monthlyRent - monthlyExpenses) * 12,
      'portfolioROI':
          ((monthlyRent - monthlyExpenses) * 12) / totalInvestment * 100,
    };
  }
}
