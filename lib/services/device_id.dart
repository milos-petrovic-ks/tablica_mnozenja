import 'package:platform_device_id/platform_device_id.dart';

class DeviceId {
  static String deviceId = "";

  static setDeviceId() async {
    String? devId = await PlatformDeviceId.getDeviceId;
    DeviceId.deviceId = devId ?? "";
  }

  static String getDomainName() {
    return DeviceId.deviceId.replaceAll("-", "1");
  }
}
