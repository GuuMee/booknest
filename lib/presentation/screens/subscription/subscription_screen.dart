// lib/presentation/screens/subscription/subscription_screen.dart

import 'package:flutter/material.dart';             // StatefulWidget, Widget, etc.
import 'package:flutter_bloc/flutter_bloc.dart';    // BlocConsumer, context.read<>()
import 'package:lottie/lottie.dart';                // Lottie.asset

// Presentation - BLoC - Subscription
import '../../bloc/subscription/subscription_bloc.dart';
import '../../bloc/subscription/subscription_state.dart';
import '../../bloc/subscription/subscription_event.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() =>
      _SubscriptionScreenState();
}

class _SubscriptionScreenState
    extends State<SubscriptionScreen> {
  // ─────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────

  String _selectedPlan = 'yearly';

  // ─────────────────────────────────────────
  // DATA
  // ─────────────────────────────────────────

  final List<Map<String, dynamic>> _plans = [
    {
      'id': 'monthly',
      'name': 'Monthly',
      'price': '\$4.99',
      'period': '/month',
      'savings': null,
      'productId': 'com.booknest.premium.monthly',
    },
    {
      'id': 'yearly',
      'name': 'Yearly',
      'price': '\$29.99',
      'period': '/year',
      'savings': 'Save 50%',
      'productId': 'com.booknest.premium.yearly',
      'monthlyPrice': '\$2.49/mo',
    },
    {
      'id': 'lifetime',
      'name': 'Lifetime',
      'price': '\$79.99',
      'period': 'one time',
      'savings': 'Best Value',
      'productId': 'com.booknest.premium.lifetime',
    },
  ];

  final List<Map<String, dynamic>> _features = [
    {
      'icon': Icons.library_books_rounded,
      'title': 'Unlimited Access',
      'description': 'Read all books in our library',
      'free': 'Limited',
      'premium': 'Unlimited',
    },
    {
      'icon': Icons.download_rounded,
      'title': 'Offline Downloads',
      'description':
          'Download books for offline reading',
      'free': '3 books',
      'premium': 'Unlimited',
    },
    {
      'icon': Icons.block_rounded,
      'title': 'Ad-Free',
      'description':
          'No interruptions while reading',
      'free': 'With ads',
      'premium': 'No ads',
    },
    {
      'icon': Icons.bookmark_rounded,
      'title': 'Bookmarks & Notes',
      'description': 'Save pages and add notes',
      'free': '10 total',
      'premium': 'Unlimited',
    },
    {
      'icon': Icons.sync_rounded,
      'title': 'Cloud Sync',
      'description': 'Sync across all your devices',
      'free': '❌',
      'premium': '✅',
    },
    {
      'icon': Icons.new_releases_rounded,
      'title': 'Early Access',
      'description': 'Get new books before everyone',
      'free': '❌',
      'premium': '✅',
    },
  ];

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    context
        .read<SubscriptionBloc>()
        .add(LoadSubscriptionPlans());
  }

  // ─────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SubscriptionBloc,
          SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionPurchased) {
            _showSuccessDialog();
          }
          if (state is SubscriptionError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // ── Scrollable Content ───────────
              CustomScrollView(
                physics:
                    const BouncingScrollPhysics(),
                slivers: [
                  // ── App Bar ─────────────────
                  SliverAppBar(
                    expandedHeight: 280,
                    pinned: true,
                    backgroundColor:
                        Colors.deepPurple.shade800,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          Navigator.pop(context),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end:
                                Alignment.bottomRight,
                            colors: [
                              Colors
                                  .deepPurple.shade800,
                              Colors.purple.shade600,
                              Colors.amber.shade700,
                            ],
                          ),
                        ),
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                            children: [
                              const SizedBox(
                                  height: 40),

                              // Crown Icon
                              Container(
                                width: 80,
                                height: 80,
                                decoration:
                                    BoxDecoration(
                                  color: Colors.white
                                      .withOpacity(
                                          0.15),
                                  shape:
                                      BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons
                                      .workspace_premium,
                                  color: Colors.amber,
                                  size: 44,
                                ),
                              ),
                              const SizedBox(
                                  height: 20),

                              const Text(
                                'BookNest Premium',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight:
                                      FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 8),

                              Text(
                                'Unlock your full reading potential',
                                style: TextStyle(
                                  color: Colors.white
                                      .withOpacity(
                                          0.85),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ── Body Content ─────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // Plans
                          const Text(
                            'Choose Your Plan',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 16),

                          ..._plans.map(
                            (plan) =>
                                _buildPlanCard(plan),
                          ),

                          const SizedBox(height: 32),

                          // Features Comparison
                          const Text(
                            'What You Get',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Header row
                          Container(
                            padding: const EdgeInsets
                                .symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Colors.grey.shade100,
                              borderRadius:
                                  const BorderRadius
                                      .vertical(
                                top:
                                    Radius.circular(
                                        16),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Feature',
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Free',
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                      fontSize: 13,
                                      color: Colors
                                          .grey
                                          .shade600,
                                    ),
                                    textAlign:
                                        TextAlign
                                            .center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Premium',
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                      fontSize: 13,
                                      color: Colors
                                          .amber
                                          .shade700,
                                    ),
                                    textAlign:
                                        TextAlign
                                            .center,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Feature rows
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius
                                      .vertical(
                                bottom:
                                    Radius.circular(
                                        16),
                              ),
                              border: Border.all(
                                color: Colors
                                    .grey.shade200,
                              ),
                            ),
                            child: Column(
                              children: _features
                                  .map(
                                    (f) =>
                                        _buildFeatureRow(
                                      f,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Testimonials
                          const Text(
                            'What Readers Say',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 16),

                          _buildTestimonial(
                            name: 'Sarah M.',
                            text:
                                'Best investment for my reading habit!'
                                ' The offline mode is a game changer.',
                            rating: 5,
                          ),
                          _buildTestimonial(
                            name: 'James K.',
                            text:
                                'Love the unlimited access. Found so many'
                                ' great books I wouldn\'t have tried otherwise.',
                            rating: 5,
                          ),

                          const SizedBox(height: 32),

                          // Trust Badges
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                            children: const [
                              _TrustBadge(
                                icon: Icons.security,
                                label:
                                    'Secure\nPayment',
                              ),
                              SizedBox(width: 24),
                              _TrustBadge(
                                icon: Icons
                                    .cancel_outlined,
                                label:
                                    'Cancel\nAnytime',
                              ),
                              SizedBox(width: 24),
                              _TrustBadge(
                                icon: Icons.refresh,
                                label:
                                    '7-Day\nFree Trial',
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Restore Purchases
                          Center(
                            child: TextButton(
                              onPressed: () {
                                context
                                    .read<
                                        SubscriptionBloc>()
                                    .add(
                                      RestorePurchases(),
                                    );
                              },
                              child: Text(
                                'Restore Purchases',
                                style: TextStyle(
                                  color: Colors
                                      .grey.shade600,
                                  decoration:
                                      TextDecoration
                                          .underline,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // ── Sticky CTA ───────────────────
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    16,
                    20,
                    MediaQuery.of(context)
                            .padding
                            .bottom +
                        16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state
                                  is SubscriptionLoading
                              ? null
                              : () {
                                  final plan =
                                      _plans
                                          .firstWhere(
                                    (p) =>
                                        p['id'] ==
                                        _selectedPlan,
                                  );
                                  context
                                      .read<
                                          SubscriptionBloc>()
                                      .add(
                                        PurchaseSubscription(
                                          productId:
                                              plan[
                                                  'productId'],
                                        ),
                                      );
                                },
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .deepPurple.shade700,
                            foregroundColor:
                                Colors.white,
                            padding: const EdgeInsets
                                .symmetric(
                              vertical: 18,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(18),
                            ),
                            elevation: 4,
                          ),
                          child: state
                                  is SubscriptionLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child:
                                      CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'Start 7-Day Free Trial',
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.w800,
                                    fontSize: 17,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Cancel anytime during trial.'
                        ' No charge.',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────
  // BUILDERS
  // ─────────────────────────────────────────

  Widget _buildPlanCard(
    Map<String, dynamic> plan,
  ) {
    final isSelected = _selectedPlan == plan['id'];
    final isPopular = plan['id'] == 'yearly';

    return GestureDetector(
      onTap: () =>
          setState(() => _selectedPlan = plan['id']),
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 200),
        margin:
            const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepPurple.shade50
              : Colors.white,
          borderRadius:
              BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.deepPurple.shade400
                : Colors.grey.shade200,
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.deepPurple
                        .withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                // Radio Button
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Colors.deepPurple
                          : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration:
                                const BoxDecoration(
                              color:
                                  Colors.deepPurple,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),

                // Plan Details
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      if (plan['monthlyPrice'] !=
                          null) ...[
                        const SizedBox(height: 2),
                        Text(
                          plan['monthlyPrice'],
                          style: TextStyle(
                            color:
                                Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Price
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.end,
                  children: [
                    Text(
                      plan['price'],
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: isSelected
                            ? Colors.deepPurple
                            : Colors.black,
                      ),
                    ),
                    Text(
                      plan['period'],
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Savings Badge
            if (plan['savings'] != null)
              Positioned(
                top: -10,
                right: -10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber.shade600,
                        Colors.orange.shade700,
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange
                            .withOpacity(0.3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Text(
                    plan['savings'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),

            // Most Popular Badge
            if (isPopular)
              Positioned(
                top: -10,
                left: 50,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '⭐ MOST POPULAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────

  Widget _buildFeatureRow(
    Map<String, dynamic> feature,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade100,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Icon(
                  feature['icon'] as IconData,
                  size: 20,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        feature['description'],
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              feature['free'],
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              feature['premium'],
              style: TextStyle(
                color: Colors.amber.shade800,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────

  Widget _buildTestimonial({
    required String name,
    required String text,
    required int rating,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade100,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ...List.generate(
                rating,
                (i) => const Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 18,
                ),
              ),
              const Spacer(),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '"$text"',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // DIALOGS
  // ─────────────────────────────────────────

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/animations/success.json',
                width: 150,
                repeat: false,
              ),
              const SizedBox(height: 20),

              const Text(
                'Welcome to Premium! 🎉',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'You now have unlimited access to all'
                ' books and features. Happy reading!',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Start Reading',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _TrustBadge
// ─────────────────────────────────────────────────────────────────────────────

class _TrustBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TrustBadge({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.grey.shade600,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}