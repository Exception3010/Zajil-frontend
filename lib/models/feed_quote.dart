/// A quote shown in the home feed.
///
/// Placeholder model for now — these are hardcoded in `HomeScreen` until the
/// receive-a-quote flow (Firestore + friends) exists. `timeAgo` is a
/// pre-formatted display string rather than a real timestamp for the same
/// reason; it will become a `DateTime` once quotes are backed by data.
class FeedQuote {
  final String text;
  final String author;

  /// Username of the friend who sent the quote (without the leading `@`).
  final String viaHandle;

  /// Pre-formatted relative time, e.g. "2h ago" (placeholder).
  final String timeAgo;

  /// Optional header image for the card.
  final String? imageUrl;

  /// Render the quote body in italic (editorial variety per DESIGN.md).
  final bool italic;

  const FeedQuote({
    required this.text,
    required this.author,
    required this.viaHandle,
    required this.timeAgo,
    this.imageUrl,
    this.italic = false,
  });
}
