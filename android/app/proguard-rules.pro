# Keep Play Core split compat classes
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Keep Flutter-related classes (optional, but safe)
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

# Prevent R8 from removing Application split compat fallback
-keep class com.google.android.play.core.splitcompat.SplitCompatApplication { *; }

# Keep main app class
-keep class com.olacodez.vaura.MainActivity { *; }
