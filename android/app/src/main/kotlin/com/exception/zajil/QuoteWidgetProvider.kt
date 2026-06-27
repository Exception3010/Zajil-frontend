package com.exception.zajil

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.view.View
import android.widget.RemoteViews

/**
 * Home-screen App Widget that displays a quote. This is rendered by the Android
 * launcher (not Flutter) via [RemoteViews], which is why it must be native code.
 *
 * Until a quote is pushed from Flutter (see WidgetService / MainActivity), the
 * widget shows a neutral empty state rather than a placeholder quote. The text is
 * read from [SharedPreferences] under [KEY_QUOTE] / [KEY_AUTHOR].
 */
class QuoteWidgetProvider : AppWidgetProvider() {

    companion object {
        const val PREFS_NAME = "zajil_widget_prefs"
        const val KEY_QUOTE = "widget_quote"
        const val KEY_AUTHOR = "widget_author"

        fun updateWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int,
        ) {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            val quote = prefs.getString(KEY_QUOTE, null)
            val author = prefs.getString(KEY_AUTHOR, null)

            val views = RemoteViews(context.packageName, R.layout.quote_widget)

            if (quote.isNullOrEmpty()) {
                // Empty state: no quote received yet.
                views.setTextViewText(
                    R.id.widget_quote_text,
                    context.getString(R.string.widget_empty_quote),
                )
                views.setViewVisibility(R.id.widget_quote_author, View.GONE)
            } else {
                views.setTextViewText(R.id.widget_quote_text, quote)
                if (author.isNullOrEmpty()) {
                    views.setViewVisibility(R.id.widget_quote_author, View.GONE)
                } else {
                    views.setViewVisibility(R.id.widget_quote_author, View.VISIBLE)
                    views.setTextViewText(R.id.widget_quote_author, "— $author")
                }
            }

            // Tapping the widget opens the app.
            val launchIntent = context.packageManager
                .getLaunchIntentForPackage(context.packageName)
            if (launchIntent != null) {
                val pendingIntent = PendingIntent.getActivity(
                    context,
                    0,
                    launchIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
                )
                views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        for (appWidgetId in appWidgetIds) {
            updateWidget(context, appWidgetManager, appWidgetId)
        }
    }
}
