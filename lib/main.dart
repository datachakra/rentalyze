import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'providers/property_providers.dart';
import 'screens/property_details_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/professional_sidebar.dart';
import 'widgets/professional_app_bar.dart';
import 'widgets/professional_metric_card.dart';
import 'widgets/professional_property_card.dart';

// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Auth state provider
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: RentalyzeApp()));
}

class RentalyzeApp extends ConsumerWidget {
  const RentalyzeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Rentalyze - Professional Real Estate Portfolio Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Skip auth for demo - go directly to property management app
      home: const ProfessionalHomeScreen(),
    );
  }
}

// Auth wrapper to handle authentication state
class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const ProfessionalHomeScreen();
        }
        return const LandingScreen();
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stackTrace) => const LandingScreen(),
    );
  }
}

// Authentication Service
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If the user cancels the sign-in process
      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential result = await _auth.signInWithCredential(
        credential,
      );
      return result.user;
    } catch (e) {
      // Log error for debugging
      debugPrint('Google sign in error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rentalyze'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            icon: const Icon(Icons.login),
            label: const Text('Login'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.home_work_rounded,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome to Rentalyze',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your complete real estate portfolio management solution',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        FilledButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.login),
                          label: const Text('Get Started'),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton.icon(
                          onPressed: () {
                            // Show demo/learn more
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Demo coming soon!'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('View Demo'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Features Section
            Text(
              'Features Coming Soon',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _FeatureCard(
                  title: 'Property Management',
                  icon: Icons.home_rounded,
                  description: 'Add and manage your rental properties',
                ),
                _FeatureCard(
                  title: 'Financial Tracking',
                  icon: Icons.attach_money_rounded,
                  description: 'Track income, expenses, and ROI',
                ),
                _FeatureCard(
                  title: 'Tenant Management',
                  icon: Icons.people_rounded,
                  description: 'Manage tenant information and leases',
                ),
                _FeatureCard(
                  title: 'Analytics & Reports',
                  icon: Icons.analytics_rounded,
                  description: 'Generate detailed financial reports',
                ),
                _FeatureCard(
                  title: 'Document Storage',
                  icon: Icons.folder_rounded,
                  description: 'Store and organize important documents',
                ),
                _FeatureCard(
                  title: 'Maintenance Tracking',
                  icon: Icons.build_rounded,
                  description: 'Schedule and track property maintenance',
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Status Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.construction,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Development Status',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _StatusItem(
                      title: 'Phase 1: Project Setup',
                      status: 'Complete',
                      isComplete: true,
                    ),
                    _StatusItem(
                      title: 'Phase 2: Authentication System',
                      status: 'In Progress',
                      isComplete: false,
                    ),
                    _StatusItem(
                      title: 'Phase 3: Property Management',
                      status: 'Planned',
                      isComplete: false,
                    ),
                    _StatusItem(
                      title: 'Phase 4: Financial Tracking',
                      status: 'Planned',
                      isComplete: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Real Login Screen with Firebase Auth
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final user = await authService.signInWithGoogle();

      if (user != null && mounted) {
        // Auth wrapper will handle navigation automatically
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.home_work_rounded,
              size: 80,
              color: Color(0xFF6366F1),
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome Back',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to access your real estate portfolio',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isLoading ? null : _signInWithGoogle,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.g_mobiledata),
                label: Text(
                  _isLoading ? 'Signing in...' : 'Continue with Google',
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email login coming soon!')),
                  );
                },
                icon: const Icon(Icons.email),
                label: const Text('Continue with Email'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registration coming soon!')),
                );
              },
              child: const Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}

// Professional main screen with sidebar navigation
class ProfessionalHomeScreen extends ConsumerStatefulWidget {
  const ProfessionalHomeScreen({super.key});

  @override
  ConsumerState<ProfessionalHomeScreen> createState() => _ProfessionalHomeScreenState();
}

class _ProfessionalHomeScreenState extends ConsumerState<ProfessionalHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ProfessionalDashboard(),
    const ProfessionalPropertiesScreen(),
    const ProfessionalAnalyticsScreen(),
    const ProfessionalFinancialScreen(),
    const ProfessionalCalculatorScreen(),
    const ProfessionalReportsScreen(),
    const ProfessionalSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceGray50,
      body: Row(
        children: [
          ProfessionalSidebar(
            currentIndex: _currentIndex,
            onItemSelected: (index) => setState(() => _currentIndex = index),
          ),
          Expanded(
            child: _screens[_currentIndex],
          ),
        ],
      ),
    );
  }
}

// Professional Dashboard with modern design
class ProfessionalDashboard extends ConsumerWidget {
  const ProfessionalDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(portfolioSummaryProvider);
    final properties = ref.watch(propertyListProvider);

    return Column(
      children: [
        ProfessionalAppBar(
          title: 'Portfolio Dashboard',
          subtitle: 'Overview of your real estate investments',
          actions: [
            ProfessionalActionButton(
              label: 'Add Property',
              icon: Icons.add,
              onPressed: () {
                // Navigate to add property screen
              },
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Key Metrics Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.1,
                  children: [
                    ProfessionalMetricCard(
                      title: 'Total Properties',
                      value: '${summary['totalProperties']}',
                      icon: Icons.home_work_outlined,
                      color: AppTheme.primaryBlue,
                      trend: '+2.5%',
                      isPositive: true,
                    ),
                    ProfessionalMetricCard(
                      title: 'Portfolio Value',
                      value: '\$${_formatCurrency(summary['totalValue'])}',
                      icon: Icons.trending_up_outlined,
                      color: AppTheme.successGreen,
                      trend: '+8.2%',
                      isPositive: true,
                    ),
                    ProfessionalMetricCard(
                      title: 'Monthly Income',
                      value: '\$${_formatCurrency(summary['monthlyCashFlow'])}',
                      icon: Icons.account_balance_wallet_outlined,
                      color: AppTheme.secondaryBlue,
                      trend: '+12.4%',
                      isPositive: true,
                    ),
                    ProfessionalMetricCard(
                      title: 'Occupancy Rate',
                      value: '${summary['occupancyRate'].toStringAsFixed(1)}%',
                      icon: Icons.people_outline,
                      color: AppTheme.warningOrange,
                      trend: '+3.1%',
                      isPositive: true,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Performance Overview Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Performance Chart Section
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceWhite,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppTheme.surfaceGray200),
                          boxShadow: AppShadows.softShadow,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Portfolio Performance',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.textPrimary,
                                      ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.successGreen.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'ROI: ${summary['portfolioROI'].toStringAsFixed(1)}%',
                                    style: const TextStyle(
                                      color: AppTheme.successGreen,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Placeholder for chart - in real app would be a chart widget
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceGray50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  'Performance Chart\n(Chart widget would go here)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppTheme.textMuted,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Quick Stats
                    Expanded(
                      child: Column(
                        children: [
                          CompactMetricCard(
                            label: 'Annual Cash Flow',
                            value: '\$${_formatCurrency(summary['annualCashFlow'])}',
                            icon: Icons.trending_up,
                            color: AppTheme.successGreen,
                            change: '+15.2%',
                            isPositive: true,
                          ),
                          const SizedBox(height: 16),
                          CompactMetricCard(
                            label: 'Total Equity',
                            value: '\$${_formatCurrency(summary['totalEquity'])}',
                            icon: Icons.account_balance,
                            color: AppTheme.primaryBlue,
                            change: '+22.1%',
                            isPositive: true,
                          ),
                          const SizedBox(height: 16),
                          CompactMetricCard(
                            label: 'Avg. Cap Rate',
                            value: '${(summary['portfolioROI'] * 0.85).toStringAsFixed(1)}%',
                            icon: Icons.percent,
                            color: AppTheme.secondaryBlue,
                            change: '+0.8%',
                            isPositive: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Recent Properties Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Properties',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        // Navigate to properties screen
                      },
                      icon: const Icon(Icons.arrow_forward, size: 16),
                      label: const Text('View All Properties'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Properties Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: properties.take(4).length,
                  itemBuilder: (context, index) {
                    final property = properties[index];
                    return ProfessionalPropertyCard(
                      property: property,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PropertyDetailsScreen(property: property),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatCurrency(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)}K';
    } else {
      return value.toStringAsFixed(0);
    }
  }
}

// Professional Properties Screen
class ProfessionalPropertiesScreen extends ConsumerWidget {
  const ProfessionalPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertyListProvider);

    return Column(
      children: [
        ProfessionalAppBar(
          title: 'Properties',
          subtitle: '${properties.length} properties in your portfolio',
          actions: [
            ProfessionalActionButton(
              label: 'Add Property',
              icon: Icons.add,
              onPressed: () {
                // Navigate to add property screen
              },
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                ProfessionalSearchBar(
                  hintText: 'Search properties...',
                  onFilterTap: () {
                    // Show filter dialog
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      final property = properties[index];
                      return ProfessionalPropertyCard(
                        property: property,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PropertyDetailsScreen(property: property),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Professional Analytics Screen
class ProfessionalAnalyticsScreen extends StatelessWidget {
  const ProfessionalAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfessionalAppBar(
          title: 'Analytics',
          subtitle: 'Performance insights and market analysis',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    size: 80,
                    color: AppTheme.textMuted,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Advanced Analytics',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Detailed performance charts and market insights\ncoming in the next update.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Professional Financial Screen
class ProfessionalFinancialScreen extends StatelessWidget {
  const ProfessionalFinancialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfessionalAppBar(
          title: 'Financial',
          subtitle: 'Income, expenses, and financial reports',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 80,
                    color: AppTheme.textMuted,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Financial Management',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Track income, expenses, and generate\nfinancial reports for your properties.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Professional Calculator Screen
class ProfessionalCalculatorScreen extends StatelessWidget {
  const ProfessionalCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfessionalAppBar(
          title: 'ROI Calculator',
          subtitle: 'Investment analysis and profitability tools',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calculate_outlined,
                    size: 80,
                    color: AppTheme.textMuted,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Investment Calculator',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Calculate ROI, cash flow, and\nanalyze investment opportunities.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Professional Reports Screen
class ProfessionalReportsScreen extends StatelessWidget {
  const ProfessionalReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfessionalAppBar(
          title: 'Reports',
          subtitle: 'Generate detailed portfolio reports',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assessment_outlined,
                    size: 80,
                    color: AppTheme.textMuted,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Portfolio Reports',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Generate comprehensive reports\nfor tax and investment analysis.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Professional Settings Screen
class ProfessionalSettingsScreen extends StatelessWidget {
  const ProfessionalSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfessionalAppBar(
          title: 'Settings',
          subtitle: 'Account preferences and configuration',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings_outlined,
                    size: 80,
                    color: AppTheme.textMuted,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Settings & Preferences',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Customize your experience and\nmanage account settings.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// Placeholder tabs
class FinancialTab extends StatelessWidget {
  const FinancialTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('Financial features coming soon...')),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('Settings coming soon...')),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const _FeatureCard({
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final String title;
  final String status;
  final bool isComplete;

  const _StatusItem({
    required this.title,
    required this.status,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isComplete ? Colors.green : Colors.grey[300],
            ),
            child: isComplete
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isComplete
                  ? Colors.green.withValues(alpha: 0.1)
                  : status == 'In Progress'
                  ? Colors.orange.withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isComplete
                    ? Colors.green[700]
                    : status == 'In Progress'
                    ? Colors.orange[700]
                    : Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
