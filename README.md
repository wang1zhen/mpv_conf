# mpv configuration

一套以 `gpu-next`、ModernZ 和常用播放脚本为核心的 mpv 配置。

## 主要设置

- 视频输出：`vo=gpu-next`
- 硬件解码：`hwdec=auto`
- 显示同步：`video-sync=display-resample`
- 时间插值：`interpolation`
- 退出时保存播放进度：`save-position-on-quit=yes`
- 音轨优先级：日语 > 英语 > 中文
- 字幕优先级：中文 > 英语 > 日语
- 支持 mpv 0.40+ secondary subtitle
- ModernZ 替代 mpv 内置 OSC

## 目录结构

```text
portable_config/
├── mpv.conf
├── input.conf
├── fonts/
│   └── modernz-icons.ttf
├── script-opts/
│   ├── autoload.conf
│   ├── modernz.conf
│   └── playlistmanager.conf
└── scripts/
    ├── audio-osc.lua
    ├── autoload.lua
    ├── modernz.lua
    ├── playlistmanager.lua
    └── thumbfast.lua
```

`portable_config` 可直接用于 mpv portable 配置布局；标准 Linux 安装也可将其中内容放到 `~/.config/mpv/`。

## 快捷键

| 按键 | 功能 |
| --- | --- |
| 双击左键 | 暂停 / 播放 |
| 滚轮 | 音量 ±2 |
| ← / → | 快退 / 快进 5 秒 |
| Shift + ← / → | 快退 / 快进 60 秒 |
| Ctrl + ← / → | 上一个 / 下一个字幕事件 |
| ↑ / ↓ | 音量 ±5 |
| `[` / `]` | 降低 / 提高播放速度 |
| `{` / `}` | 速度减半 / 加倍 |
| Backspace | 恢复 1.0 倍速 |
| `s` / `S` | 含字幕 / 纯视频截图 |
| `f` | 全屏 |
| `t` | 窗口置顶 |
| `j` / `J` | 主字幕轨道正向 / 反向切换 |
| `k` / `K` | 次字幕轨道正向 / 反向切换 |
| `Tab` | ModernZ 显示模式 |
| `F8` | playlistmanager 播放列表 |

## 脚本与上游

- [ModernZ](https://github.com/Samillion/ModernZ)：使用 v0.3.3 及对应的 `modernz-icons.ttf`。
- [thumbfast](https://github.com/po5/thumbfast)：跟随上游。
- [mpv-playlistmanager](https://github.com/jonniek/mpv-playlistmanager)：跟随上游；`script-opts/playlistmanager.conf` 只保留本地 F8 覆盖。
- [autoload.lua](https://github.com/mpv-player/mpv/blob/master/TOOLS/lua/autoload.lua)：跟随 mpv 官方上游；`script-opts/autoload.conf` 保持 `images=no`。

## ModernZ

`script-opts/modernz.conf` 只保留本配置实际覆盖的选项，其余继承 ModernZ 上游默认值，以减少后续升级时的配置漂移。

当前主要偏好：

- 2 秒自动隐藏
- 暂停时保留底部控制条
- seek 和启动时不主动弹出 OSC
- 保留跳转、播放列表、截图、置顶、信息和全屏按钮
- 隐藏章节跳转、下载、循环和速度按钮
- 保留橙色进度条主题

## 依赖

- 较新的 mpv；secondary subtitle 部分按 mpv 0.40+ 编写
- ModernZ v0.3.3
- `modernz-icons.ttf`
