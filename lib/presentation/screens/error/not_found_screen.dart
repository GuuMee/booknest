// lib/presentation/screens/error/not_found_screen.dart

import 'package:flutter/material.dart';             // StatelessWidget
                                                    // Widget
                                                    // BuildContext
                                                    // Scaffold
                                                    // SafeArea
                                                    // Center
                                                    // Padding
                                                    // EdgeInsets
                                                    // Column
                                                    // MainAxisAlignment
                                                    // Container
                                                    // BoxDecoration
                                                    // BoxShape
                                                    // Colors
                                                    // Icon
                                                    // Icons
                                                    // SizedBox
                                                    // Text
                                                    // TextStyle
                                                    // FontWeight
                                                    // TextAlign
                                                    // ElevatedButton
                                                    // RoundedRectangleBorder
                                                    // BorderRadius

import 'package:go_router/go_router.dart';          // context.go()

// Core - Theme
import '../../../core/theme/app_colors.dart';       // AppColors
                                                    // .primary

// ─────────────────────────────────────────────────────────────────────────────

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.menu_book_rounded,
                    size: 56,
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  '404',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Page Not Found',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'The page you\'re looking for doesn\'t exist or has been moved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade500,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () =>
                        context.go('/home'),
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.primary,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Go Home',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}