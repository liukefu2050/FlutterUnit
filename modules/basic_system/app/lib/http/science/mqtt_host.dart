import 'package:flutter/foundation.dart';
import 'package:fx_dio/fx_dio.dart';

class MqttHost extends Host {
  const MqttHost();

  //http://192.168.15.143:8080/config/report/queryMachinePage
  @override
  Map<HostEnv, String> get value => {
        HostEnv.release: '192.168.15.143', // 192.168.15.143   toly1994.com
        HostEnv.dev: '192.168.15.143',
      };

  @override
  HostConfig get config => const HostConfig(
        scheme: 'http',
        port: 8080,
        apiNest: '/',
      );

  @override
  HostEnv get env => HostEnv.release;
}

enum MqttApi {
  appVersion("/app_version"),
  ;

  final String path;
  final Method? method;

  const MqttApi(this.path, [this.method = Method.get]);
}
