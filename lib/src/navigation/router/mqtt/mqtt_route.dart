import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:widget_module/widget_module.dart';

import 'package:mqtt/mqtt.dart';

GoRoute get mqttRoute => GoRoute(
      path: AppRoute.messsages.path,
      builder: (_, __) => MqttSysScope(child: const MqttAdmin()),
      // routes: [
      //   GoRoute(
      //       path: AppRoute.messsagesDetail.path, builder: mqttDetailBuilder),
      // ],
    );

// Widget mqttDetailBuilder(BuildContext context, GoRouterState state) {
//   Object? extra = state.extra;
//   String? widgetName = state.pathParameters['name'];

//   WidgetModel? model;
//   if (extra is WidgetModel) {
//     model = extra;
//   }

//   return WidgetDetailPageScope(model: model!);
// }
