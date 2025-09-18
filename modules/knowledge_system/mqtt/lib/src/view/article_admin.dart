import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:mqtt/mqtt.dart';
import 'package:tolyui/tolyui.dart';
import 'package:app/app.dart';
import 'article_editor.dart';
import 'article_list.dart';
import 'desktop/article_display.dart';

class MqttAdmin extends StatefulWidget {
  const MqttAdmin({super.key});

  @override
  State<MqttAdmin> createState() => _MqttAdminState();
}

class _MqttAdminState extends State<MqttAdmin> {
  @override
  Widget build(BuildContext context) {
    MqttSysBloc bloc = context.watch<MqttSysBloc>();
    ListStatus status = bloc.state.status;
    bool hasActive = bloc.state.active != null;

    Widget table = switch (status) {
      LoadingStatus() => const CupertinoActivityIndicator(),
      SuccessStatus() => ArticleList(
          articles: bloc.state.articles,
          activeId: bloc.state.active?.id ?? "",
          onTap: bloc.select,
          onUpdateTitle: bloc.updateTitle,
        ),
      FailedStatus() => Text("Error:${status.error}"),
    };
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 240,
            decoration: BoxDecoration(color: Color(0xfffafbfc)
                // gradient: LinearGradient(colors: [
                //   Color(0xffe9f1f8),
                //   Color(0xffebf2f8),
                // ])
                ),
            child: Column(
              children: [
                DragToMoveWrapper(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: 46,
                    child: Row(
                      spacing: 6,
                      children: [
                        Icon(
                          Icons.note_alt_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          '设备新建',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff242a39)),
                        ),
                        Spacer(),
                        TolyAction(
                          child: Icon(
                            Icons.sync,
                            size: 20,
                            color: Color(0xff242a39),
                          ),
                          onTap: () async {
                            bloc.loadFirstFrame();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: ElevatedButton(
                          onPressed: bloc.newArticle,
                          child: Wrap(
                            spacing: 6,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Text(
                                "新建",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          style: FillButtonPalette(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            foregroundPalette: Palette.all(Colors.white),
                            borderRadius: BorderRadius.circular(6),
                            backgroundPalette: const Palette(
                              normal: Color(0xff1890ff),
                              hover: Color(0xff40a9ff),
                              pressed: Color(0xff096dd9),
                            ),
                          ).style,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(child: table)
              ],
            ),
          ),
          VerticalDivider(),
          Expanded(
              child: Column(
            children: [
              Container(
                height: 46,
                child: Row(
                  children: [
                    if (hasActive)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextField(
                            onTapOutside: (_) => bloc.updateTitleV2(),
                            onSubmitted: (_) => bloc.updateTitleV2(),
                            controller: bloc.titleCtrl,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    if (!hasActive) Spacer(),
                    WindowButtons()
                  ],
                ),
              ),
              Divider(),
              // Expanded(child: RichEditor()),
              Expanded(child: ArticleDisplay()),
            ],
          ))
        ],
      ),
    );
  }
}

class RichEditor extends StatefulWidget {
  const RichEditor({super.key});

  @override
  State<RichEditor> createState() => _RichEditorState();
}

class _RichEditorState extends State<RichEditor> {
  QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuillSimpleToolbar(
          controller: _controller,
          config: const QuillSimpleToolbarConfig(),
        ),
        Expanded(
          child: QuillEditor.basic(
            controller: _controller,
            config: const QuillEditorConfig(),
          ),
        )
      ],
    );
  }
}
