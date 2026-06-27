import 'package:flutter/material.dart';

/// A single quote rendered as an editorial card, following the
/// "Digital Editorial" design system (see DESIGN.md): no borders,
/// `surface-container-lowest` fill, `rounded-xl` corners, soft ambient
/// shadow, and whitespace separating the quote body from its author.
class QuoteCard extends StatelessWidget {
  final String quote;
  final String? author;

  const QuoteCard({
    super.key,
    this.quote = 'The art of the messenger lies not in speed, '
        'but in the weight of the words carried.',
    this.author = 'Unknown',
  });

  @override
  Widget build(BuildContext context) {
    // Design tokens (DESIGN.md). No shared theme file yet, so colors are
    // declared locally to match the other screens.
    const primaryColor = Color(0xFF0D6683);
    const onSurface = Color(0xFF181C1E);
    const onSurfaceVariant = Color(0xFF40484D);
    const surfaceContainerLowest = Color(0xFFFFFFFF);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          // Ambient shadow: 24px blur, 0 offset, ~6% opacity tint of on-surface.
          BoxShadow(
            color: onSurface.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.format_quote, color: primaryColor, size: 28),
          const SizedBox(height: 12),
          Text(
            quote,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
              height: 1.5,
              letterSpacing: 0.2,
              color: onSurface,
              fontFamily: 'Inter',
            ),
          ),
          if (author != null && author!.isNotEmpty) ...[
            // Functional whitespace separating author from the quote body.
            const SizedBox(height: 24),
            Text(
              '— ${author!}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: onSurfaceVariant,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
