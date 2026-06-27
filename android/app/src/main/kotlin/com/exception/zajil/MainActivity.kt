package com.exception.zajil

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val channelName = "com.exception.zajil/widget"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "updateQuote" -> {
                        val quote = call.argument<String>("quote")
                        val author = call.argument<String>("author")
                        updateQuote(quote, author)
                        result.success(true)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Writes the quote to the same SharedPreferences file [QuoteWidgetProvider]
     * reads from, then refreshes every placed instance of the widget.
     */
    private fun updateQuote(quote: String?, author: String?) {
        val prefs = getSharedPreferences(
            QuoteWidgetProvider.PREFS_NAME,
            Context.MODE_PRIVATE,
        )
        prefs.edit().apply {
            quote?.let { putString(QuoteWidgetProvider.KEY_QUOTE, it) }
            author?.let { putString(QuoteWidgetProvider.KEY_AUTHOR, it) }
            apply()
        }

        val appWidgetManager = AppWidgetManager.getInstance(this)
        val ids = appWidgetManager.getAppWidgetIds(
            ComponentName(this, QuoteWidgetProvider::class.java),
        )
        for (id in ids) {
            QuoteWidgetProvider.updateWidget(this, appWidgetManager, id)
        }
    }
}
