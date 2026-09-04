#!/usr/bin/env bash
set -euo pipefail

rm -rf portable_config/shaders
rm -f portable_config/scripts/mpvSockets.lua
rm -f portable_config/fonts/fluent-system-icons.ttf portable_config/fonts/material-design-icons.ttf
mkdir -p portable_config/fonts portable_config/scripts portable_config/script-opts

curl -fsSL https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua -o portable_config/scripts/autoload.lua
curl -fsSL https://raw.githubusercontent.com/jonniek/mpv-playlistmanager/master/playlistmanager.lua -o portable_config/scripts/playlistmanager.lua
curl -fsSL https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.lua -o portable_config/scripts/thumbfast.lua
curl -fsSL https://raw.githubusercontent.com/Samillion/ModernZ/main/modernz.lua -o portable_config/scripts/modernz.lua
curl -fsSL https://raw.githubusercontent.com/Samillion/ModernZ/main/modernz-icons.ttf -o portable_config/fonts/modernz-icons.ttf

cat > portable_config/mpv.conf <<'EOF'
# ========== 视频 ==========
vo=gpu-next                         # 使用 gpu-next 渲染器
gpu-api=auto                        # 自动选择可用 GPU API
dither-depth=auto                   # 自动选择抖动深度
hwdec=auto                          # 自动选择硬件解码后端
video-sync=display-resample         # 按显示刷新率同步视频
interpolation                       # 配合 display-resample 启用时间插值

# ========== 播放控制 ==========
keep-open=always                    # 播放结束后保持窗口
save-position-on-quit=yes           # 退出时保存播放位置
watch-later-options-remove=sub-pos  # 避免 ModernZ 动态字幕边距与 watch-later 冲突

# ========== 音频 ==========
audio-file-auto=fuzzy               # 自动加载外挂音轨
audio-channels=stereo               # 固定双声道输出
audio-normalize-downmix=yes         # 降混时规范化
volume=100                          # 默认音量
alang=ja,en,zh                      # 音轨优先级：日语 > 英语 > 中文

# ========== 字幕 ==========
sub-auto=fuzzy                      # 自动加载外挂字幕
slang=zh,en,ja                      # 字幕优先级：中文 > 英语 > 日语
sub-font='Noto Sans CJK SC'
sub-font-size=48
sub-color='#FFFFFF'
sub-border-size=3
sub-border-color='#000000'
sub-shadow-offset=1
sub-shadow-color='#000000'

# 次字幕（mpv 0.40+）
secondary-sid=auto
secondary-sub-pos=95
secondary-sub-visibility=yes

# ========== 界面 ==========
osc=no                              # 使用 ModernZ，禁用内置 OSC
osd-bar=no                          # 禁用内置 OSD 进度条
border=no                           # 无系统窗口边框
autofit-larger=80%x80%              # 最大窗口尺寸为屏幕 80%
volume-max=200                      # 最大音量 200%
EOF

cat > portable_config/input.conf <<'EOF'
# ========== 鼠标操作 ==========
MBTN_LEFT_DBL cycle pause           # 双击左键：暂停/播放
MBTN_RIGHT    ignore                # 右键单击：禁用
WHEEL_UP      add volume 2          # 滚轮上：音量 +2
WHEEL_DOWN    add volume -2         # 滚轮下：音量 -2

# ========== 方向键导航 ==========
RIGHT       seek 5                  # 快进 5 秒
LEFT        seek -5                 # 快退 5 秒
UP          add volume 5            # 音量 +5
DOWN        add volume -5           # 音量 -5
Shift+RIGHT seek 60                 # 快进 60 秒
Shift+LEFT  seek -60                # 快退 60 秒
Ctrl+RIGHT  sub-seek 1              # 跳到下一个字幕事件
Ctrl+LEFT   sub-seek -1             # 跳到上一个字幕事件

# ========== 播放速度 ==========
[  multiply speed 1/1.1
]  multiply speed 1.1
{  multiply speed 0.5
}  multiply speed 2.0
BS set speed 1.0

# ========== 截图 ==========
s screenshot                       # 含字幕截图
S screenshot video                 # 纯视频截图

# ========== 窗口 ==========
f cycle fullscreen
t cycle ontop

# ========== 字幕轨道 ==========
j cycle sub
J cycle sub down
k cycle secondary-sid
K cycle secondary-sid down

# ========== ModernZ ==========
TAB script-binding modernz/visibility
EOF

cat > portable_config/script-opts/modernz.conf <<'EOF'
# ModernZ v0.3.3 overrides only; unspecified options inherit upstream defaults.
language=en
icon_theme=fluent
icon_style=mixed

hidetimeout=2000
keeponpause=bottombar
fadein=no
osc_on_seek=no
osc_on_start=no

jump_buttons=yes
jump_amount=10
chapter_skip_buttons=no
playlist_button=yes
screenshot_button=yes
ontop_button=yes
loop_button=no
speed_button=no
info_button=yes
fullscreen_button=yes
download_button=no

seekbarfg_color=#FB8C00
seekbarbg_color=#94754F
seekbar_cache_color=#918F8E
hover_effect_color=#FB8C00
nibbles_style=triangle
persistent_progress=no
visibility=auto
EOF

cat > README.md <<'EOF'
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

仓库不再包含 Anime4K、SVP 或 `mpvSockets.lua`。

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

- [ModernZ](https://github.com/Samillion/ModernZ)：当前同步 v0.3.3，并使用对应的 `modernz-icons.ttf`。
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
EOF

# Temporary transport files are not part of the final repository.
rm -f .github/workflows/mpv-refresh-once.yml
rm -f .github/workflows/mpv-refresh-pr.yml
rm -f .github/scripts/refresh-mpv.sh
rmdir .github/scripts 2>/dev/null || true
rmdir .github/workflows 2>/dev/null || true
rmdir .github 2>/dev/null || true

# Validation
test ! -d portable_config/shaders
test ! -e portable_config/scripts/mpvSockets.lua
test ! -e portable_config/fonts/fluent-system-icons.ttf
test ! -e portable_config/fonts/material-design-icons.ttf
test -s portable_config/fonts/modernz-icons.ttf
grep -q '^vo=gpu-next' portable_config/mpv.conf
grep -q '^hwdec=auto' portable_config/mpv.conf
grep -q '^save-position-on-quit=yes' portable_config/mpv.conf
grep -q 'ModernZ v0.3.3' portable_config/scripts/modernz.lua
file portable_config/fonts/modernz-icons.ttf | grep -qi 'TrueType'
if grep -RniE 'Anime4K|SVP|mpvSockets' README.md portable_config; then
  echo 'Obsolete Anime4K/SVP reference remains.' >&2
  exit 1
fi
