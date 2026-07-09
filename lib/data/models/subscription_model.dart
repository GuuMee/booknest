// lib/data/models/subscription_model.dart

enum SubscriptionTier { free, premium, family }
enum SubscriptionStatus { active, expired, trial, cancelled }

class SubscriptionModel {
  final String id;
  final String userId;
  final SubscriptionTier tier;
  final SubscriptionStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? trialEndDate;
  final bool isAnnual;
  final double price;
  final String currency;
  final bool autoRenew;
  final String? paymentMethod;
  final List<String> features;

  SubscriptionModel({
    required this.id,
    required this.userId,
    required this.tier,
    required this.status,
    required this.startDate,
    required this.endDate,
    this.trialEndDate,
    this.isAnnual = false,
    required this.price,
    this.currency = 'USD',
    this.autoRenew = true,
    this.paymentMethod,
    required this.features,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      tier: SubscriptionTier.values.firstWhere(
        (e) => e.name == json['tier'],
        orElse: () => SubscriptionTier.free,
      ),
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => SubscriptionStatus.expired,
      ),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      trialEndDate: json['trialEndDate'] != null
          ? DateTime.parse(json['trialEndDate'])
          : null,
      isAnnual: json['isAnnual'] ?? false,
      price: (json['price'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'USD',
      autoRenew: json['autoRenew'] ?? true,
      paymentMethod: json['paymentMethod'],
      features: List<String>.from(json['features'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tier': tier.name,
      'status': status.name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'trialEndDate': trialEndDate?.toIso8601String(),
      'isAnnual': isAnnual,
      'price': price,
      'currency': currency,
      'autoRenew': autoRenew,
      'paymentMethod': paymentMethod,
      'features': features,
    };
  }

  bool get isActive =>
      status == SubscriptionStatus.active ||
      status == SubscriptionStatus.trial;

  bool get isPremiumOrAbove =>
      tier == SubscriptionTier.premium ||
      tier == SubscriptionTier.family;

  bool get isExpired => DateTime.now().isAfter(endDate);
  bool get isTrial => status == SubscriptionStatus.trial;
  int get daysRemaining => endDate.difference(DateTime.now()).inDays;
}