// lib/presentation/screens/reader/widgets/top_controls.dart

import 'package:flutter/material.dart';          // StatelessWidget
                                                  // Widget, BuildContext
                                                  // VoidCallback
                                                  // Color, Colors
                                                  // Positioned
                                                  // Container, BoxDecoration
                                                  // BoxShadow, Offset
                                                  // SafeArea, Padding
                                                  // EdgeInsets
                                                  // Row, Column, Expanded
                                                  // IconButton, Icon, Icons
                                                  // Text, TextStyle
                                                  // FontWeight
                                                  // TextOverflow
                                                  // SizedBox
                                                  // CrossAxisAlignment

// Domain - Models
import '../../../../domain/models/book.dart';     // Book
                                                  // .title
                                                  // .author

// Core - Theme
import '../../../../core/theme/app_colors.dart';  // AppColors.primary

// ─────────────────────────────────────────────────────────────────────────────

class _TopControls extends StatelessWidget {
  final Book book;
  final VoidCallback onBack;
  final VoidCallback onBookmark;
  final VoidCallback onTableOfContents;
  final bool isBookmarked;
  final Color backgroundColor;
  final Color textColor;

  const _TopControls({
    required this.book,
    required this.onBack,
    required this.onBookmark,
    required this.onTableOfContents,
    required this.isBookmarked,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.05,
              ),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            child: Row(
              children: [
                // Back
                IconButton(
                  onPressed: onBack,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: textColor,
                  ),
                ),
                const SizedBox(width: 4),

                // Title
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w700,
                          fontSize: 15,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                      ),
                      Text(
                        book.author,
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor
                              .withOpacity(0.6),
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),

                // TOC
                IconButton(
                  onPressed: onTableOfContents,
                  icon: Icon(
                    Icons.list_rounded,
                    color: textColor,
                  ),
                  tooltip: 'Table of Contents',
                ),

                // Bookmark
                IconButton(
                  onPressed: onBookmark,
                  icon: Icon(
                    isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons
                            .bookmark_outline_rounded,
                    color: isBookmarked
                        ? AppColors.primary
                        : textColor,
                  ),
                  tooltip: 'Bookmark',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}