import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt/mqtt.dart';

class MqttSysScope extends StatelessWidget {
  final Widget child;

  const MqttSysScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArtSysBloc>(
      create: (_) => ArtSysBloc()..loadFirstFrame(),
      child: child,
    );
  }
}
