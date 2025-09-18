import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:mqtt/src/repository/article_repository.dart';
import 'package:mqtt/src/repository/model/article.dart';

import '../repository/model/model.dart';

class MqttSysBloc extends Cubit<MqttSysState> {
  MqttSysBloc() : super(MqttSysState(articles: []));

  final MqttRepository _repository = HttpMqttRepository();

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController ctrl = TextEditingController();

  Future<void> loadFirstFrame() async {
    if (state.articles.isEmpty) {
      emit(state.copyWith(status: const LoadingStatus()));
    }
    ApiRet<List<ArticlePo>> ret = await _repository.list(SizeFilter());
    if (ret.success) {
      MqttSysState newState = state.copyWith(
        articles: ret.data,
        status: SuccessStatus(ret.paginate?.total ?? 0),
      );
      emit(newState);
      _openCurrent();
      return;
    }
    print("❌ loadFirstFrame failed");
    print(ret.trace?.error?.toString());
    print(ret.trace?.stack?.toString());
    MqttSysState newState = state.copyWith(
      status: FailedStatus(ret.trace?.error, ret.trace?.stack),
    );
    emit(newState);
  }

  void _openCurrent() {
    int? id = state.active?.id;
    if (id != null) {
      open(id);
    }
  }

  Future<void> newArticle() async {
    await _repository.create(
      ArticleCreatePayload(
        subtitle: '',
        title: '新建文档',
        url: '',
        cover: '',
        type: 1,
        createAt: DateTime.timestamp().toIso8601String(),
      ),
    );
    await loadFirstFrame();
  }

  void select(ArticlePo article) {
    open(article.id);
    titleCtrl.text = article.name;
    emit(state.copyWith(active: article));
  }

  void open(int id) async {
    ApiRet<String> ret = await _repository.open(id);
    if (ret.success) {
      ctrl.text = ret.data;
    }
  }

  void write(String content) async {
    int? id = state.active?.id;
    if (id != null) {
      ApiRet<bool> ret = await _repository.write(id, content);
    }
  }

  void updateTitleV2() {
    ArticlePo? article = state.active;
    String title = titleCtrl.text;
    if (article != null) {
      updateTitle(article, title);
    }
  }

  void updateTitle(ArticlePo article, String title) async {
    if (title == article.name) return;
    ApiRet<ArticlePo> ret = await _repository.update(
        article.id, ArticleUpdatePayload(title: title));
    if (ret.success) {
      open(article.id);
      loadFirstFrame();
      titleCtrl.text = ret.data.name;
    } else {
      print(ret.trace?.error);
    }
  }

  Future<void> delete() async {
    int? id = state.active?.id;
    if (id != null) {
      ApiRet<bool> ret = await _repository.delete(id);
      await loadFirstFrame();
    }
  }
}

sealed class ListStatus {
  const ListStatus();
}

class LoadingStatus extends ListStatus {
  const LoadingStatus();
}

class SuccessStatus extends ListStatus {
  final int total;

  const SuccessStatus(this.total);
}

class FailedStatus extends ListStatus {
  final Object? error;
  final StackTrace? trace;

  const FailedStatus(this.error, [this.trace]);
}

class MqttSysState {
  final List<ArticlePo> articles;
  final ArticlePo? active;
  final ListStatus status;

  MqttSysState({
    required this.articles,
    this.active,
    this.status = const LoadingStatus(),
  });

  MqttSysState copyWith({
    List<ArticlePo>? articles,
    ArticlePo? active,
    ListStatus? status,
  }) {
    return MqttSysState(
      articles: articles ?? this.articles,
      active: active ?? this.active,
      status: status ?? this.status,
    );
  }
}
