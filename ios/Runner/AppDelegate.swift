import UIKit
import Flutter
import GoogleMaps
import Firebase




@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    
    // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyDRgcVDP1V2X8OFFTkODZy3ZhPWSWuw_lw")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
