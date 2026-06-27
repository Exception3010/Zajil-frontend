import 'package:flutter/material.dart';
import 'package:zajil/l10n/app_localizations.dart';

class PrivacyPolicySheet extends StatelessWidget {
  const PrivacyPolicySheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    const surfaceBright = Color(0xFFF7FAFC);
    const onSurface = Color(0xFF181C1E);
    const onSurfaceVariant = Color(0xFF40484D);
    const outlineVariant = Color(0xFFBFC8CD);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: surfaceBright,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: outlineVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.privacyPolicy,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                        fontFamily: 'Inter',
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 8), // Replaces Divider for "No-Line" rule

              // Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    _buildSection(
                      l10n.ppSection1Title,
                      l10n.ppSection1Content,
                      onSurface,
                      onSurfaceVariant,
                    ),
                    _buildSection(
                      l10n.ppSection2Title,
                      l10n.ppSection2Content,
                      onSurface,
                      onSurfaceVariant,
                    ),
                    _buildSection(
                      l10n.ppSection3Title,
                      l10n.ppSection3Content,
                      onSurface,
                      onSurfaceVariant,
                    ),
                    _buildSection(
                      l10n.ppSection4Title,
                      l10n.ppSection4Content,
                      onSurface,
                      onSurfaceVariant,
                    ),
                    _buildSection(
                      l10n.ppSection5Title,
                      l10n.ppSection5Content,
                      onSurface,
                      onSurfaceVariant,
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        l10n.ppLastUpdated,
                        style: TextStyle(
                          fontSize: 12,
                          color: onSurfaceVariant.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(String title, String content, Color titleColor, Color contentColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: titleColor,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: contentColor,
              height: 1.5,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
