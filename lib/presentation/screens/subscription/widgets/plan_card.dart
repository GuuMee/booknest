// lib/presentation/screens/subscription/widgets/plan_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_typography.dart';

class PlanCard extends StatelessWidget {
  final String planName;
  final String price;
  final String period;
  final List<PlanFeature> features;
  final bool isRecommended;
  final bool isCurrentPlan;
  final String buttonText;
  final VoidCallback onTap;
  final Gradient? gradient;

  const PlanCard({
    super.key,
    required this.planName,
    required this.price,
    required this.period,
    required this.features,
    this.isRecommended = false,
    this.isCurrentPlan = false,
    required this.buttonText,
    required this.onTap,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isRecommended ? AppColors.primary : Colors.grey.shade200,
          width: isRecommended ? 2.5 : 1,
        ),
        boxShadow: isRecommended
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        children: [
          // Recommended Badge
          if (isRecommended)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
              ),
              child: const Center(
                child: Text(
                  '⭐ MOST POPULAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Plan Name
                Text(
                  planName,
                  style: AppTypography.heading2.copyWith(
                    color: isRecommended
                        ? AppColors.primary
                        : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                // Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: AppTypography.heading1.copyWith(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: isRecommended
                            ? AppColors.primary
                            : Colors.black87,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        '/$period',
                        style: AppTypography.bodyMedium.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Divider(color: Colors.grey.shade200),
                const SizedBox(height: 16),

                // Features
                ...features.map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: feature.included
                                ? AppColors.success.withOpacity(0.15)
                                : Colors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            feature.included
                                ? Icons.check_rounded
                                : Icons.close_rounded,
                            size: 16,
                            color: feature.included
                                ? AppColors.success
                                : Colors.red,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature.text,
                            style: AppTypography.bodyMedium.copyWith(
                              color: feature.included
                                  ? Colors.black87
                                  : Colors.grey,
                              decoration: feature.included
                                  ? null
                                  : TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isCurrentPlan ? null : onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCurrentPlan
                          ? Colors.grey.shade300
                          : (isRecommended
                              ? AppColors.primary
                              : Colors.white),
                      foregroundColor: isRecommended
                          ? Colors.white
                          : AppColors.primary,
                      side: isRecommended
                          ? null
                          : const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: isRecommended ? 4 : 0,
                    ),
                    child: Text(
                      isCurrentPlan ? 'Current Plan' : buttonText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1);
  }
}

class PlanFeature {
  final String text;
  final bool included;

  PlanFeature({required this.text, required this.included});
}