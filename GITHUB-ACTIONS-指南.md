# GitHub Actions 自动编译 .ipa 指南

## 快速开始

### 第一步：创建 GitHub 仓库

1. 登录你的 GitHub 账号
2. 新建一个私有仓库，名字随便取，比如 `iplay-ipad`
3. 不要勾选 "Add a README file"

### 第二步：上传项目文件

把整个 `iplay-ipad` 文件夹里的所有文件上传到仓库：
- 可以用网页直接上传，或者用 git 命令

网页上传方法：
1. 在仓库页面点击 "Add file" → "Upload files"
2. 把所有文件拖进去
3. 点击 "Commit changes"

### 第三步：触发自动编译

上传完成后，GitHub Actions 会自动开始编译。

查看编译进度：
1. 进入仓库页面
2. 点击顶部的 "Actions" 标签
3. 你会看到 "Build IPlay IPA" 正在运行
4. 等待编译完成（大概 5-10 分钟）

### 第四步：下载 .ipa

1. 编译完成后，点击对应的运行记录
2. 拉到页面底部，找到 "Artifacts" 区域
3. 下载 `IPlay-IPA` 这个压缩包
4. 解压后得到 `IPlay.ipa` 文件

### 第五步：安装到 iPad

1. 把 `IPlay.ipa` 传到你的 iPad mini 6
2. 用 TrollStore 打开安装
3. 完成！

---

## 常见问题

### Q: 编译失败了怎么办？
A: 点进失败的运行记录，看日志里的红色错误信息，把错误发给我，我帮你修。

### Q: 需要苹果开发者账号吗？
A: 不需要！这个编译是不签名的版本，正好适合用 TrollStore 安装。TrollStore 会自己签名。

### Q: 编译要多久？
A: 第一次大概 5-10 分钟，后续如果代码没改太多会快一点。

### Q: 编译好的 .ipa 有效期多久？
A: 用 TrollStore 安装后是永久有效的，不会过期。

---

## 注意事项

1. 这个 .ipa 是**未签名**的，只能用 TrollStore 安装，不能直接用普通方式安装
2. 你的 iPad mini 6 / iOS 15.1 正好支持 TrollStore，没问题
3. 如果以后要更新代码，重新上传文件，Actions 会自动重新编译

---

## 文件结构说明

```
iplay-ipad/
├── .github/
│   └── workflows/
│       └── build-ipa.yml      # 自动编译配置
├── IPlay/
│   ├── IPlayApp.swift           # App 入口
│   ├── Info.plist               # 应用配置
│   ├── Views/                   # 界面文件
│   └── Services/                 # 核心服务
├── IPlay.xcodeproj/              # Xcode 项目
│   └── project.pbxproj
├── README.md
├── CHANGELOG.md
└── GITHUB-ACTIONS-指南.md       # 本文件
```
