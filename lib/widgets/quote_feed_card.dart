import 'package:flutter/material.dart';
import 'package:zajil/l10n/app_localizations.dart';
import 'package:zajil/models/feed_quote.dart';

/// A single quote card in the home feed, mirroring the `<article>` in
/// assets/html/home.html: surface-container-lowest fill, rounded-2xl corners,
/// soft ambient shadow, optional header image, then quote / author / "via" row.
class QuoteFeedCard extends StatelessWidget {
  final FeedQuote quote;
  final VoidCallback? onTap;

  const QuoteFeedCard({super.key, required this.quote, this.onTap});

  // Design tokens (DESIGN.md / home.html tailwind config).
  static const _primary = Color(0xFF0D6683);
  static const _secondary = Color(0xFF406376);
  static const _surfaceContainerLowest = Color(0xFFFFFFFF);
  static const _surfaceVariant = Color(0xFFE0E3E5);
  static const _onSurface = Color(0xFF181C1E);
  static const _onSurfaceVariant = Color(0xFF40484D);
  static const _outline = Color(0xFF70787D);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: _surfaceContainerLowest,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      // Ambient shadow: 0 4px 24px rgba(24,28,30,0.04).
      shadowColor: _onSurface.withValues(alpha: 0.10),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (quote.imageUrl != null)
              SizedBox(
                height: 192,
                width: double.infinity,
                child: Image.network(
                  quote.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      Container(color: _surfaceVariant),
                  loadingBuilder: (context, child, progress) => progress == null
                      ? child
                      : Container(color: _surfaceVariant),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    quote.text,
                    style: TextStyle(
                      fontSize: 24,
                      height: 1.5,
                      fontWeight: FontWeight.w300,
                      fontStyle:
                          quote.italic ? FontStyle.italic : FontStyle.normal,
                      color: _onSurface,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '— ${quote.author}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _primary,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${l10n.via} ',
                        style: const TextStyle(
                          fontSize: 12,
                          color: _onSurfaceVariant,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        '@${quote.viaHandle}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _secondary,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const Spacer(),
                      Text(
                        quote.timeAgo.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          letterSpacing: -0.2,
                          color: _outline,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
