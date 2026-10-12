# IPlay - iPad 无线 CarPlay 接收端

参考 [WinPlay](https://github.com/Roylyl/WinPlay) 项目开发，让 iPad 成为 CarPlay 车载显示终端。

## 功能特性

- ✅ 无线 CarPlay 接收（蓝牙配对 + Wi-Fi 传输）
- ✅ 支持本机热点 / 局域网两种连接模式
- ✅ 独立 CarPlay 画面窗口
- ✅ 触摸操作支持
- ✅ 音频播放
- ✅ 视频分辨率 / 帧率可调
- ✅ 深色模式界面
- ✅ 多语言支持

## 系统要求

- iPadOS 15.1+
- iPad mini 6 或更新设备
- 支持 TrollStore 永久签名安装

## 项目结构

```
IPlay/
├── IPlayApp.swift          # App 入口与全局状态
├── Info.plist              # 应用配置
├── Views/
│   ├── RootView.swift       # 主界面（导航拆分视图）
│   ├── ConnectionView.swift # 连接设置页
│   ├── DisplayView.swift    # 显示设置页
│   ├── AudioView.swift      # 音频设置页
│   ├── AboutView.swift      # 关于页
│   └── CarPlayView.swift    # CarPlay 投屏画面
└── Services/
    ├── BluetoothManager.swift  # 蓝牙配对与发现
    ├── NetworkManager.swift    # 网络管理与 Bonjour
    ├── CarPlayProtocol.swift   # CarPlay 协议核心
    └── VideoDecoder.swift      # H.264 视频解码
```

## 编译说明

### 方式一：Xcode 打开（推荐）

1. 在 Mac 上安装 Xcode 15+
2. 打开 Xcode → File → Open → 选择本项目目录
3. 等待 Swift Package 下载完成
4. 选择你的 iPad 作为目标设备
5. 点击 Run 编译运行

### 方式二：命令行编译

```bash
xcodebuild -project IPlay.xcodeproj -scheme IPlay -destination 'platform=iOS,id=YOUR_DEVICE_ID' build
```

## 安装到 iPad

### TrollStore 安装（推荐）

1. 编译生成 .ipa 文件
2. 将 .ipa 传到 iPad
3. 用 TrollStore 打开安装

### AltStore 安装

1. 编译生成 .ipa 文件
2. 用 AltStore 侧载安装（7 天有效期）

## 开发进度

- [x] 项目骨架与界面
- [x] 蓝牙管理器框架
- [x] 网络管理器框架
- [x] CarPlay 协议层框架
- [x] 视频解码器框架
- [ ] iAP2 认证协议实现
- [ ] H.264 视频流解码测试
- [ ] 音频播放集成
- [ ] 触摸事件回传
- [ ] 完整连接流程调通

## 参考项目

- [WinPlay](https://github.com/Roylyl/WinPlay) - Windows 无线 CarPlay 接收端
- MacPlay - macOS 版本
- AndroidPlay - Android 版本
