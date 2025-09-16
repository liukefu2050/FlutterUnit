### 环境与构建

#### Flutter 版本

```
·]>>  flutter --version
Flutter 3.35.1 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 20f8274939 (6 days ago) • 2025-08-14 10:53:09 -0700
Engine • hash 6cd51c08a88e7bbe848a762c20ad3ecb8b063c0e (revision 1e9a811bf8) (7 days ago) • 2025-08-13 23:35:25.000Z
Tools • Dart 3.9.0 • DevTools 2.48.0
```

#### 编辑依赖

在项目根目录的 pubspec.yaml 文件中，找到 dependencies: 部分，添加你需要的包，比如：

```
dependencies:
  flutter:
    sdk: flutter

  dio: ^5.4.0
  shared_preferences: ^2.2.2
```

#### 安装依赖

```
flutter clean
flutter pub get

```

#### 更新依赖

```
flutter pub upgrade

```

#### 构建应用

```
·]>>  cd FlutterUnit

Build Android 不分包:
·]>>  flutter build apk
Build Android 分包:
·]>>  flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi
Build iOS:
·]>>  flutter build ios
Build Windows:
·]>>  flutter build windows
Build Linux:
·]>>  flutter build linux
Build web:
·]>>  flutter build web
```
