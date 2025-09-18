import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:mqtt/mqtt.dart';

import '../../repository/article_repository.dart';
import '../../repository/model/model.dart';

class MobileEditor extends StatefulWidget {
  final ArticlePo article;

  const MobileEditor({super.key, required this.article});

  @override
  State<MobileEditor> createState() => _MobileEditorState();
}

class _MobileEditorState extends State<MobileEditor> {
  TextEditingController ctrl = TextEditingController();
  MqttRepository _repository = HttpMqttRepository();
  //FocusNode titleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // _loadArticleContent(widget.article.id);
    //titleFocusNode.addListener(_titleFocusNode);
  }

  // void _loadArticleContent(int id) async {
  //   ApiRet<String> ret = await _repository.open(id);
  //   if (ret.success) {
  //     ctrl.text = ret.data;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    MqttSysBloc bloc = context.watch<MqttSysBloc>();

    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Color(0xfffafafa),
        // title: Text(widget.article.title),
        actions: [
          IconButton(
              onPressed: () {
                showBottomTip(context);
              },
              icon: Icon(Icons.more_vert))
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(32),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0, left: 18),
              child: Row(
                spacing: 8,
                children: [
                  Text(
                    '${bloc.state.active?.remark}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(
                          0xffadadad,
                        )),
                  ),
                  SizedBox(height: 14, child: VerticalDivider()),
                  Text(
                    'ID: ${widget.article.id}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(
                          0xffadadad,
                        )),
                  ),
                ],
              ),
            )),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDetailRow('名称', widget.article.name),
          _buildDetailRow('sn', widget.article.sn),
          _buildDetailRow('ip', widget.article.ip),
          _buildDetailRow('port', widget.article.port.toString()),
          _buildDetailRow('machineType', widget.article.machineType.toString()),
          _buildDetailRow('aiEnable', widget.article.aiEnable.toString()),
          _buildDetailRow('dlRunning', widget.article.dlRunning.toString()),
          _buildDetailRow('备注', bloc.state.active?.remark ?? ''),
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
              width: 80,
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
          await context.read<MqttSysBloc>().delete();
          Navigator.of(context).pop();
        },
        message: '更多操作',
        deleteText: '删除设备',
      ),
    );
  }

  // end
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
                    style: TextStyle(color: Color(0xff8f8f8f)),
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
                      style: TextStyle(color: Color(0xfff14835), fontSize: 16),
                    )),
              ),
              Container(
                color: Color(0xfff2f3f5),
                height: 8,
              ),
              InkWell(
                splashColor: Colors.white,
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    child: Text(
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
