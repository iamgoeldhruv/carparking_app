import 'package:background_location/background_location.dart';
import 'package:location/location.dart';


Future<dynamic> getpos() async{
BackgroundLocation.setAndroidNotification(
	title: "Notification title",
        message: "Notification message",
        icon: "@mipmap/ic_launcher",
);

BackgroundLocation.setAndroidConfiguration(1000);

BackgroundLocation.startLocationService();

BackgroundLocation.startLocationService(distanceFilter : 10);

// BackgroundLocation.startLocationService(forceAndroidLocationManager: true);

BackgroundLocation.getLocationUpdates((location) {
  return 1;
});

 return 1;

 }
