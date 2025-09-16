### 环境与构建

#### Flutter 版本

```
·]>>  flutter --version
Flutter 3.35.1 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 20f8274939 (6 days ago) • 2025-08-14 10:53:09 -0700
Engine • hash 6cd51c08a88e7bbe848a762c20ad3ecb8b063c0e (revision 1e9a811bf8) (7 days ago) • 2025-08-13 23:35:25.000Z
Tools • Dart 3.9.0 • DevTools 2.48.0
```

#### 构建应用

```
·]>>  cd FlutterUnit

Build Android:
·]>>  flutter build apk --target-platform --split-per-abi
Build iOS:
·]>>  flutter build ios
Build Windows:
·]>>  flutter build windows
Build Linux:
·]>>  flutter build linux
Build web:
·]>>  flutter build web
```
