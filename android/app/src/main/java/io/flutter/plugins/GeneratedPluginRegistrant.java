package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.javih.add2calendar.Add2CalendarPlugin;
import com.appleeducate.appreview.AppReviewPlugin;
import com.mranuran.clipboardmanager.ClipboardManagerPlugin;
import io.flutter.plugins.firebase.cloudfirestore.CloudFirestorePlugin;
import io.flutter.plugins.firebase.core.FirebaseCorePlugin;
import dev.vbonnet.flutterwebbrowser.FlutterWebBrowserPlugin;
import com.ko2ic.imagedownloader.ImageDownloaderPlugin;
import com.lyokone.location.LocationPlugin;
import io.flutter.plugins.packageinfo.PackageInfoPlugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import io.flutter.plugins.share.SharePlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import io.flutter.plugins.urllauncher.UrlLauncherPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    Add2CalendarPlugin.registerWith(registry.registrarFor("com.javih.add2calendar.Add2CalendarPlugin"));
    AppReviewPlugin.registerWith(registry.registrarFor("com.appleeducate.appreview.AppReviewPlugin"));
    ClipboardManagerPlugin.registerWith(registry.registrarFor("com.mranuran.clipboardmanager.ClipboardManagerPlugin"));
    CloudFirestorePlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.cloudfirestore.CloudFirestorePlugin"));
    FirebaseCorePlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.core.FirebaseCorePlugin"));
    FlutterWebBrowserPlugin.registerWith(registry.registrarFor("dev.vbonnet.flutterwebbrowser.FlutterWebBrowserPlugin"));
    ImageDownloaderPlugin.registerWith(registry.registrarFor("com.ko2ic.imagedownloader.ImageDownloaderPlugin"));
    LocationPlugin.registerWith(registry.registrarFor("com.lyokone.location.LocationPlugin"));
    PackageInfoPlugin.registerWith(registry.registrarFor("io.flutter.plugins.packageinfo.PackageInfoPlugin"));
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
    SharePlugin.registerWith(registry.registrarFor("io.flutter.plugins.share.SharePlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    UrlLauncherPlugin.registerWith(registry.registrarFor("io.flutter.plugins.urllauncher.UrlLauncherPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
