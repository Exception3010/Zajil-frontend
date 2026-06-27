import 'package:flutter/services.dart';

/// Pushes quotes to the native Android home-screen widget.
///
/// Communicates over a [MethodChannel] with `MainActivity`, which writes the
/// values into the SharedPreferences that `QuoteWidgetProvider` reads and then
/// refreshes any placed widget instances. No-op on platforms without the widget
/// (e.g. iOS) or before the channel is available.
class WidgetService {
  static const MethodChannel _channel =
      MethodChannel('com.exception.zajil/widget');

  /// Updates the home-screen quote widget with [quote] and optional [author].
  ///
  /// Returns `true` if the native side acknowledged the update, `false` if the
  /// widget is unavailable on this platform.
  static Future<bool> updateQuote({
    required String quote,
    String? author,
  }) async {
    try {
      final result = await _channel.invokeMethod<bool>('updateQuote', {
        'quote': quote,
        'author': author,
      });
      return result ?? false;
    } on MissingPluginException {
      // No native handler registered (e.g. iOS) — nothing to update.
      return false;
    } on PlatformException {
      return false;
    }
  }
}
