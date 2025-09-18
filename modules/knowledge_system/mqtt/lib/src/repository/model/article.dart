import 'package:fx_dao/fx_dao.dart';
import 'package:intl/intl.dart';

DateFormat _noteTimeShort = DateFormat('yyyy/M/d');
DateFormat _noteTimeLong = DateFormat('yyyy/M/d HH:mm:ss');
Duration offset = DateTime.now().timeZoneOffset;

enum ArticleType {
  net,
  custom,
}

class ArticlePo implements Po {
  final String id;
  final String name;
  final String sn;
  final String ip;
  final String port;
  final String groupId;
  final String centerId;
  final String machineType;
  final String aiEnable;
  final String aiIp;
  final String aiPort;
  final String liangcheng;
  final String voltage;
  final String dlStandby;
  final String dlRunning;
  final String remark;
  final dynamic reserve;

  ArticlePo({
    required this.id,
    required this.name,
    required this.sn,
    required this.ip,
    required this.port,
    required this.groupId,
    required this.centerId,
    required this.machineType,
    required this.aiEnable,
    required this.aiIp,
    required this.aiPort,
    required this.liangcheng,
    required this.voltage,
    required this.dlStandby,
    required this.dlRunning,
    required this.remark,
    this.reserve,
  });

  factory ArticlePo.fromApi(Map<String, dynamic> map) => ArticlePo(
        id: map['id']?.toString() ?? '',
        name: map['name']?.toString() ?? '',
        sn: map['sn']?.toString() ?? '',
        ip: map['ip']?.toString() ?? '',
        port: map['port']?.toString() ?? '',
        groupId: map['groupId']?.toString() ?? '',
        centerId: map['centerId']?.toString() ?? '',
        machineType: map['machineType']?.toString() ?? '',
        aiEnable: map['aienable']?.toString() ?? '',
        aiIp: map['aiip']?.toString() ?? '',
        aiPort: map['aiport']?.toString() ?? '',
        liangcheng: map['liangcheng'] ?? '',
        voltage: map['voltage']?.toString() ?? '',
        dlStandby: map['dlStandby']?.toString() ?? '',
        dlRunning: map['dlRunning']?.toString() ?? '',
        remark: map['remark']?.toString() ?? '',
        reserve: map['reserve']?.toString() ?? '',
      );

  factory ArticlePo.fromCache(Map<String, dynamic> map) => ArticlePo(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        sn: map['sn'] ?? '',
        ip: map['ip'] ?? '',
        port: map['port'] ?? '',
        groupId: map['groupId'] ?? '',
        centerId: map['centerId'] ?? '',
        machineType: map['machineType'] ?? '',
        aiEnable: map['aienable'] ?? '',
        aiIp: map['aiip'] ?? '',
        aiPort: map['aiport'] ?? 0,
        liangcheng: map['liangcheng'] ?? '',
        voltage: map['voltage'] ?? '',
        dlStandby: map['dlStandby'] ?? '',
        dlRunning: map['dlRunning'] ?? '',
        remark: map['remark'] ?? '',
        reserve: map['reserve'],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sn': sn,
      'ip': ip,
      'port': port,
      'groupid': groupId,
      'centerid': centerId,
      'machinetype': machineType,
      'aienable': aiEnable,
      'aiip': aiIp,
      'aiport': aiPort,
      'liangcheng': liangcheng,
      'voltage': voltage,
      'dlStandby': dlStandby,
      'dlRunning': dlRunning,
      'remark': remark,
      'reserve': reserve,
    };
  }
}

class ArticleCreatePayload {
  final String subtitle;
  final String title;
  final String url;
  final int type;
  final String cover;
  final String createAt;

  ArticleCreatePayload({
    required this.subtitle,
    required this.title,
    required this.url,
    required this.type,
    required this.cover,
    required this.createAt,
  });

  Map<String, dynamic> get apiData => {
        "title": title,
        "create_at": createAt,
        "subtitle": subtitle,
        "url": url,
        "type": type,
        "cover": cover,
      };

  Map<String, dynamic> toJson() => apiData;
}

class ArticleUpdatePayload {
  final String? subtitle;
  final String? title;
  final String? url;
  final String? cover;

  ArticleUpdatePayload({
    this.subtitle,
    this.title,
    this.url,
    this.cover,
  });

  Map<String, dynamic> get apiData {
    Map<String, dynamic> ret = {};
    if (title != null) {
      ret['title'] = title;
    }
    if (url != null) {
      ret['url'] = title;
    }
    if (subtitle != null) {
      ret['subtitle'] = title;
    }
    if (cover != null) {
      ret['cover'] = title;
    }
    return ret;
  }

  Map<String, dynamic> toJson() => apiData;
}
