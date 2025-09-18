import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../repository/model/model.dart';
import '../../repository/article_repository.dart';

import 'dart:convert';

class MobileEditor extends StatefulWidget {
  final ArticlePo article;

  const MobileEditor({super.key, required this.article});

  @override
  State<MobileEditor> createState() => _MobileEditorState();
}

class _MobileEditorState extends State<MobileEditor> {
  // MQTT 客户端
  late MqttServerClient client;
  ArticlePo? mqttArticle;
  String? mqttMessage = "";

  // 写死配置
  final String broker = "192.168.29.86";
  final int port = 1883;
  final String topic = "topic1";
  final String clientId =
      "flutter_client_${DateTime.now().millisecondsSinceEpoch}";

  @override
  void initState() {
    super.initState();
    _connectMqtt();
  }

  Future<void> _connectMqtt() async {
    client = MqttServerClient(broker, clientId);
    client.port = port;
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onConnected = () => debugPrint('MQTT 已连接');
    client.onDisconnected = () => debugPrint('MQTT 已断开');
    client.onSubscribed = (t) => debugPrint('已订阅: $t');

    try {
      await client.connect();
    } catch (e) {
      debugPrint("MQTT 连接失败: $e");
      client.disconnect();
      return;
    }

    client.subscribe(topic, MqttQos.atMostOnce);

    client.updates?.listen((messages) {
      final recMess = messages[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      debugPrint('收到消息: $pt');
      if (pt.isEmpty) return;
      try {
        final data = jsonDecode(pt) as Map<String, dynamic>;
        setState(() {
          mqttMessage = pt;
          mqttArticle = ArticlePo.fromApi(data); // 直接转成 ArticlePo
        });
      } catch (e) {
        debugPrint("⚠️ JSON 解析失败: $e");
      }
    });
  }

  @override
  void dispose() {
    client.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final article = mqttArticle ?? widget.article; // 👈 优先mqtt数据

    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xfffafafa),
        title: Text(widget.article.name),
        actions: [
          IconButton(
              onPressed: () {
                showBottomTip(context);
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDetailRow('名称', article.name),
          _buildDetailRow('sn', article.sn),
          _buildDetailRow('ip', article.ip),
          _buildDetailRow('port', article.port.toString()),
          _buildDetailRow('machineType', article.machineType.toString()),
          _buildDetailRow('aiEnable', article.aiEnable.toString()),
          _buildDetailRow('dlRunning', article.dlRunning.toString()),
          const Divider(),
          _buildDetailRow('最新MQTT数据', mqttMessage ?? "等待消息..."),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 100,
              child: Text(
                '$label:',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              )),
          Expanded(
              child: Text(
            value,
            style: const TextStyle(fontSize: 14),
          )),
        ],
      ),
    );
  }

  void showBottomTip(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => PopBottomTip(
        onDelete: () async {
          Navigator.of(context).pop();
        },
        message: '更多操作',
        deleteText: '删除设备',
      ),
    );
  }
}

class PopBottomTip extends StatelessWidget {
  final VoidCallback onDelete;
  final String message;
  final String deleteText;

  const PopBottomTip({
    super.key,
    required this.onDelete,
    required this.message,
    required this.deleteText,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Material(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        )),
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: Colors.grey.withOpacity(0.2)))),
                  child: Text(
                    message,
                    style: const TextStyle(color: Color(0xff8f8f8f)),
                  )),
              InkWell(
                splashColor: Colors.white,
                onTap: () {
                  Navigator.of(context).pop();
                  onDelete();
                },
                child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    child: Text(
                      deleteText,
                      style: const TextStyle(
                          color: Color(0xfff14835), fontSize: 16),
                    )),
              ),
              Container(
                color: const Color(0xfff2f3f5),
                height: 8,
              ),
              InkWell(
                splashColor: Colors.white,
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    child: const Text(
                      '取消',
                      style: TextStyle(fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
