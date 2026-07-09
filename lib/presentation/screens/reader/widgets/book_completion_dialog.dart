// lib/presentation/screens/reader/widgets/book_completion_dialog.dart

import 'package:flutter/material.dart';           // StatefulWidget, Animation, etc.
import 'package:flutter/services.dart';           // HapticFeedback
import 'package:flutter_bloc/flutter_bloc.dart';  // context.read<>()
import 'package:lottie/lottie.dart';              // Lottie.asset
import 'package:share_plus/share_plus.dart';      // Share.share

// Data - Models
import '../../../../data/models/book_model.dart';

// Presentation - BLoC - Reader
import '../../../bloc/reader/reader_bloc.dart';   // BookCompletionStats

// Presentation - BLoC - Book Detail
import '../../../bloc/book_detail/book_detail_bloc.dart';
import '../../../bloc/book_detail/book_detail_event.dart'; // RateBook

// Core - Theme
import '../../../../core/theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MAIN WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class BookCompletionDialog extends StatefulWidget {
  final BookModel book;
  final BookCompletionStats stats;

  const BookCompletionDialog({
    super.key,
    required this.book,
    required this.stats,
  });

  @override
  State<BookCompletionDialog> createState() =>
      _BookCompletionDialogState();
}

class _BookCompletionDialogState
    extends State<BookCompletionDialog>
    with TickerProviderStateMixin {
  // ── Controllers ───────────────────────────
  late AnimationController _confettiController;
  late AnimationController _fadeController;

  // ── Animations ────────────────────────────
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  // ── State ─────────────────────────────────
  double _userRating = 0;

  // ─────────────────────────────────────────
  // LIFECYCLE
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();

    // Confetti — plays once for 3 s
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Dialog entrance — 800 ms
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutBack,
    );

    _scaleAnimation =
        Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.elasticOut,
      ),
    );

    _fadeController.forward();
    _confettiController.forward();

    // Haptic feedback on open
    HapticFeedback.heavyImpact();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Confetti Animation ───────
                SizedBox(
                  height: 120,
                  child: Lottie.asset(
                    'assets/animations/celebration.json',
                    controller: _confettiController,
                    repeat: false,
                  ),
                ),

                // ── Trophy Icon ──────────────
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber.shade400,
                        Colors.orange.shade600,
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber
                            .withOpacity(0.4),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
                const SizedBox(height: 24),

                // ── Title ────────────────────
                const Text(
                  'Congratulations! 🎉',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You finished "${widget.book.title}"',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),

                // ── Stats Grid ───────────────
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                    children: [
                      _CompletionStat(
                        icon: Icons.schedule_rounded,
                        value: widget
                            .stats.formattedReadTime,
                        label: 'Read Time',
                        color: Colors.blue,
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      _CompletionStat(
                        icon: Icons
                            .auto_stories_rounded,
                        value:
                            '${widget.stats.totalPages}',
                        label: 'Pages',
                        color: Colors.green,
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      _CompletionStat(
                        icon: Icons
                            .calendar_today_rounded,
                        value:
                            '${widget.stats.daysToComplete}',
                        label: 'Days',
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // ── Rate This Book ───────────
                Text(
                  'Rate this book',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _userRating = index + 1.0;
                        });
                        HapticFeedback.lightImpact();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 200,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          index < _userRating
                              ? Icons.star_rounded
                              : Icons
                                  .star_outline_rounded,
                          color: Colors.amber,
                          size: index < _userRating
                              ? 40
                              : 36,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 28),

                // ── Action Buttons ───────────
                Row(
                  children: [
                    // Share
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Share.share(
                            'I just finished reading'
                            ' "${widget.book.title}"'
                            ' by ${widget.book.author}!'
                            ' 📚🏆 #BookNest',
                          );
                        },
                        style:
                            OutlinedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.share_rounded,
                              size: 18,
                            ),
                            SizedBox(width: 6),
                            Text('Share'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Done
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_userRating > 0) {
                            context
                                .read<BookDetailBloc>()
                                .add(
                                  RateBook(
                                    bookId:
                                        widget.book.id,
                                    rating: _userRating,
                                  ),
                                );
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.primary,
                          foregroundColor: Colors.white,
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
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
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE WIDGET — _CompletionStat
// ─────────────────────────────────────────────────────────────────────────────

class _CompletionStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _CompletionStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}s