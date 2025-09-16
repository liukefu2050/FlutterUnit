// Copyright 2014 The 张风捷特烈 . All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Author:      张风捷特烈
// CreateTime:  2024-05-13
// Contact Me:  1981462002@qq.com

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:tolyui/tolyui.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuBarLeading extends StatelessWidget {
  const MenuBarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Column(
        children: [
          Wrap(
            direction: Axis.vertical,
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  sendEvent(1);
                },
                child: const CircleImage(
                  image: AssetImage('assets/images/icon_head.webp'),
                  size: 60,
                ),
              ),
              const Text(
                '上海鼎宏网络科技',
                style: TextStyle(color: Colors.white70),
              )
            ],
          ),
          _buildIcons(),
          const Divider(color: Colors.white, height: 1, endIndent: 20),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  final List<LinkIconMenu> menus = const [
    LinkIconMenu(TolyIcon.icon_github, "https://www.baid.com"),
    LinkIconMenu(TolyIcon.icon_juejin, 'https://www.365me.cn'),
    LinkIconMenu(TolyIcon.icon_item, 'https://www.365me.me'),
  ];

  Widget _buildIcons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Wrap(
        spacing: 8,
        children: menus
            .map((menu) => TolyAction(
                  style: const ActionStyle.dark(),
                  onTap: menu.launch,
                  child: Icon(menu.icon, color: Colors.white, size: 22),
                ))
            .toList(),
      ),
    );
  }
}

class LinkIconMenu {
  final IconData icon;
  final String url;

  const LinkIconMenu(this.icon, this.url);

  void launch() => _launchUrl(url);

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {}
  }
}
