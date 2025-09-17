import 'package:fx_dio/fx_dio.dart';

class MqttEnv with MqttModuleBridge {
  static MqttEnv? _instance;

  MqttEnv._();

  factory MqttEnv() {
    _instance ??= MqttEnv._();
    return _instance!;
  }

  MqttModuleBridge? _bridge;

  void attachBridge(MqttModuleBridge bridge) {
    _bridge = bridge;
  }

  @override
  Host get host => _bridge!.host;
}

mixin MqttModuleBridge {
  Host get host;
}
