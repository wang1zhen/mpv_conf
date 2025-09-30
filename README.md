# MPV 配置说明

这是一套精简的 MPV 播放器配置，主要针对动漫观看优化。

## 📁 目录结构

```
mpv/
├── portable_config/
│   ├── mpv.conf              # 主配置文件
│   ├── input.conf            # 快捷键配置
│   ├── script-opts/          # 脚本选项
│   │   ├── autoload.conf     # 自动加载配置
│   │   ├── playlistmanager.conf
│   │   └── modernz.conf      # ModernZ OSC配置
│   ├── scripts/              # Lua脚本
│   │   ├── modernz.lua       # ModernZ OSC
│   │   ├── thumbfast.lua     # 缩略图预览
│   │   └── ...               # 其他脚本
│   └── shaders/              # Anime4K着色器文件
└── README.md
```

## ⚙️ 主要功能

### 画质增强
- **GPU高画质渲染**：使用 `gpu-hq` 预设
- **硬件解码**：自动启用硬件加速
- **帧插值**：运动补偿，提供流畅播放体验
- **Anime4K**：动漫画质增强着色器（默认 Mode A HQ 高质量模式）

### 播放控制
- 播放完毕后自动暂停
- 自动保存播放进度
- 自动加载外挂字幕和音轨

### 语言优先级
- **音轨**：日语 > 英语 > 中文
- **字幕**：中文 > 英语 > 日语

## ⌨️ 快捷键

### 基础操作
| 按键 | 功能 |
|------|------|
| **双击左键** | 暂停/播放 |
| **滚轮上/下** | 音量 ±2 |
| **空格** | 暂停/播放（默认） |

### 进度控制
| 按键 | 功能 |
|------|------|
| **←/→** | 快退/快进 5秒 |
| **Shift + ←/→** | 快退/快进 60秒 |
| **Ctrl + ←/→** | 跳到上/下一个字幕 |
| **↑/↓** | 音量 ±5 |

### 播放速度
| 按键 | 功能 |
|------|------|
| **[ / ]** | 速度 -10% / +10% |
| **{ / }** | 速度减半 / 加倍 |
| **退格键** | 重置速度为 1.0 |

### Anime4K 切换（HQ 高质量模式）
| 按键 | 功能 |
|------|------|
| **Ctrl+1** | Mode A (HQ) - 标准锐化 |
| **Ctrl+2** | Mode B (HQ) - 柔和锐化 |
| **Ctrl+3** | Mode C (HQ) - 降噪增强 |
| **Ctrl+4** | Mode A+A (HQ) - 双重标准锐化 |
| **Ctrl+5** | Mode B+B (HQ) - 双重柔和锐化 |
| **Ctrl+6** | Mode C+A (HQ) - 降噪+标准锐化 |
| **Ctrl+0** | 关闭所有着色器 |

### 其他
| 按键 | 功能 |
|------|------|
| **F8** | 显示/隐藏播放列表 |
| **s** | 截图（默认） |
| **q** | 退出（默认） |
| **Tab** | 显示/隐藏 ModernZ OSC |
| **i** | 显示统计信息（默认） |

## 🎨 Anime4K 模式说明（HQ 高质量版本）

### 基础模式
- **Mode A (HQ)**：标准锐化，适合大多数动漫（使用 VL 超轻量级 + M 中等组合）
- **Mode B (HQ)**：柔和锐化，适合画风柔和的作品（柔和恢复 + 标准放大）
- **Mode C (HQ)**：降噪增强，适合低质量片源（降噪放大 + 标准放大）

### 增强模式
- **Mode A+A (HQ)**：双重标准锐化，最强锐化效果（适合高端显卡）
- **Mode B+B (HQ)**：双重柔和锐化，保持细节同时柔和处理
- **Mode C+A (HQ)**：降噪后标准锐化，先降噪再增强（适合老旧片源）

💡 **提示**：HQ 模式使用 VL (Very Light) 版本着色器，对显卡要求较高，如遇卡顿可使用 Ctrl+0 关闭

## 📝 配置文件说明

### mpv.conf
包含所有主要设置，分为以下几个部分：
- 画质设置
- 播放控制
- 音频/字幕
- 界面设置
- Anime4K 着色器

### input.conf
自定义快捷键绑定，可根据个人习惯修改。

### script-opts/
各个脚本的独立配置文件：
- `autoload.conf`：自动加载设置（图片加载已禁用）
- `playlistmanager.conf`：播放列表管理器快捷键
- `modernz.conf`：ModernZ OSC 外观和行为配置

### scripts/
已安装的 Lua 脚本：
- `modernz.lua`：现代化 OSC 控制条（替代默认 OSC）
- `thumbfast.lua`：进度条缩略图预览
- `playlistmanager.lua`：增强的播放列表管理
- `autoload.lua`：自动加载同目录文件
- 其他辅助脚本

## 🔧 自定义配置

### 修改语言优先级
编辑 `mpv.conf`：
```ini
alang=ja,en,zh    # 音轨优先级
slang=zh,en,ja    # 字幕优先级
```

### 调整窗口大小
```ini
autofit-larger=80%x80%    # 改为其他百分比
```

### 禁用帧插值（降低GPU负担）
注释掉以下行：
```ini
#video-sync=display-resample
#interpolation
```

### 禁用 Anime4K
注释掉或删除 `glsl-shaders` 行，或使用 `Ctrl+0` 快捷键临时关闭。

## 💡 提示

- 首次使用建议先用 `Ctrl+0` 关闭 Anime4K，测试性能
- 如果播放卡顿，可以关闭帧插值或降低 Anime4K 模式
- 硬件解码模式 `auto-copy` 兼容性较好，如需更高性能可改为 `auto`

## 📦 依赖

- MPV 播放器（最新版本）
- Anime4K v4.x 着色器文件（需放在 `shaders/` 目录）
- ModernZ OSC 脚本
- 可选：thumbfast、playlistmanager 等脚本

## 🔗 相关链接

- [MPV 官方文档](https://mpv.io/manual/)
- [Anime4K 项目](https://github.com/bloc97/Anime4K)
- [ModernZ OSC](https://github.com/Samillion/ModernZ)
- [MPV 配置指南](https://github.com/mpv-player/mpv/wiki)

## 🚨 重要提醒

### Anime4K 版本
⚠️ **你当前的 Anime4K 着色器仍是 v3.x（2021年版本）**

建议更新到最新的 v4.x 版本以获得更好的画质和性能：
1. 访问 https://github.com/bloc97/Anime4K/releases
2. 下载最新版本（v4.0.1 或更高）
3. 解压并替换整个 `shaders/` 目录
4. 重启 mpv 播放器

**注意**：v4.x 与 v3.x 不兼容，请完整替换所有着色器文件。