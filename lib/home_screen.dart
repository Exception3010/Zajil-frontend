import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zajil/login_screen.dart';
import 'package:zajil/services/widget_service.dart';
import 'package:zajil/widgets/quote_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Placeholder quote shown in-app and pushed to the home-screen widget.
  static const String _quote =
      'The art of the messenger lies not in speed, '
      'but in the weight of the words carried.';
  static const String _author = 'Zajil';

  Future<void> _sendToWidget(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final sent = await WidgetService.updateQuote(
      quote: _quote,
      author: _author,
    );
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          sent ? 'Quote sent to home-screen widget' : 'Widget not available',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Placeholder'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('username'); // Clear local username on logout

              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF7FAFC),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: QuoteCard(quote: _quote, author: _author),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _sendToWidget(context),
        backgroundColor: const Color(0xFF0D6683),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.send),
        label: const Text('Send to widget'),
      ),
    );
  }
}
