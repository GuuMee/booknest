// lib/presentation/bloc/subscription/subscription_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Domain - Entities
import '../../../domain/entities/subscription.dart';

// Domain - Repositories
import '../../../domain/repositories/subscription_repository.dart';

// Data - Models
import '../../../data/models/subscription_model.dart';

// Services
import '../../../services/purchase_service.dart';

// Events
abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
  @override
  List<Object?> get props => [];
}

class LoadSubscriptionPlans extends SubscriptionEvent {}

class PurchaseSubscription extends SubscriptionEvent {
  final SubscriptionTier tier;
  final bool isAnnual;
  const PurchaseSubscription({required this.tier, this.isAnnual = false});
  @override
  List<Object?> get props => [tier, isAnnual];
}

class RestorePurchases extends SubscriptionEvent {}

class CancelSubscription extends SubscriptionEvent {}

class CheckSubscriptionStatus extends SubscriptionEvent {}

// States
abstract class SubscriptionState extends Equatable {
  const SubscriptionState();
  @override
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionPlansLoaded extends SubscriptionState {
  final List<SubscriptionPlan> plans;
  final SubscriptionModel? currentSubscription;

  const SubscriptionPlansLoaded({
    required this.plans,
    this.currentSubscription,
  });

  @override
  List<Object?> get props => [plans, currentSubscription];
}

class SubscriptionPurchaseSuccess extends SubscriptionState {
  final SubscriptionModel subscription;
  const SubscriptionPurchaseSuccess({required this.subscription});
  @override
  List<Object?> get props => [subscription];
}

class SubscriptionPurchaseError extends SubscriptionState {
  final String message;
  const SubscriptionPurchaseError({required this.message});
  @override
  List<Object?> get props => [message];
}

class SubscriptionRestored extends SubscriptionState {
  final SubscriptionModel subscription;
  const SubscriptionRestored({required this.subscription});
  @override
  List<Object?> get props => [subscription];
}

// Bloc
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository subscriptionRepository;
  final PurchaseService purchaseService;

  SubscriptionBloc({
    required this.subscriptionRepository,
    required this.purchaseService,
  }) : super(SubscriptionInitial()) {
    on<LoadSubscriptionPlans>(_onLoadPlans);
    on<PurchaseSubscription>(_onPurchase);
    on<RestorePurchases>(_onRestore);
    on<CancelSubscription>(_onCancel);
    on<CheckSubscriptionStatus>(_onCheckStatus);
  }

  Future<void> _onLoadPlans(
    LoadSubscriptionPlans event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());
    try {
      final plans = await subscriptionRepository.getAvailablePlans();
      final current = await subscriptionRepository.getCurrentSubscription();

      emit(SubscriptionPlansLoaded(
        plans: plans,
        currentSubscription: current,
      ));
    } catch (e) {
      emit(SubscriptionPurchaseError(message: e.toString()));
    }
  }

  Future<void> _onPurchase(
    PurchaseSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());
    try {
      final productId = _getProductId(event.tier, event.isAnnual);

      final purchaseResult = await purchaseService.purchase(productId);

      if (purchaseResult.success) {
        final subscription = await subscriptionRepository.activateSubscription(
          tier: event.tier,
          isAnnual: event.isAnnual,
          receiptData: purchaseResult.receiptData,
        );

        emit(SubscriptionPurchaseSuccess(subscription: subscription));
      } else {
        emit(SubscriptionPurchaseError(
          message: purchaseResult.errorMessage ?? 'Purchase failed',
        ));
      }
    } catch (e) {
      emit(SubscriptionPurchaseError(message: e.toString()));
    }
  }

  Future<void> _onRestore(
    RestorePurchases event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());
    try {
      final restored = await purchaseService.restorePurchases();
      if (restored != null) {
        final subscription =
            await subscriptionRepository.restoreSubscription(restored);
        emit(SubscriptionRestored(subscription: subscription));
      } else {
        emit(const SubscriptionPurchaseError(
          message: 'No previous purchases found',
        ));
      }
    } catch (e) {
      emit(SubscriptionPurchaseError(message: e.toString()));
    }
  }

  Future<void> _onCancel(
    CancelSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    try {
      await subscriptionRepository.cancelSubscription();
      add(LoadSubscriptionPlans());
    } catch (e) {
      emit(SubscriptionPurchaseError(message: e.toString()));
    }
  }

  Future<void> _onCheckStatus(
    CheckSubscriptionStatus event,
    Emitter<SubscriptionState> emit,
  ) async {
    try {
      await subscriptionRepository.verifySubscriptionStatus();
      add(LoadSubscriptionPlans());
    } catch (e) {
      emit(SubscriptionPurchaseError(message: e.toString()));
    }
  }

  String _getProductId(SubscriptionTier tier, bool isAnnual) {
    switch (tier) {
      case SubscriptionTier.premium:
        return isAnnual ? 'premium_annual' : 'premium_monthly';
      case SubscriptionTier.family:
        return isAnnual ? 'family_annual' : 'family_monthly';
      default:
        return 'free';
    }
  }
}