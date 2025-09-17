import 'package:fx_dio/fx_dio.dart';
import 'package:fx_dio/src/client/host.dart';
import 'package:mqtt/mqtt.dart';
import 'package:app/app.dart';

class UnitMqttBridge with MqttModuleBridge {
  @override
  Host get host => FxDio()<ScienceHost>();
}
