#!/bin/bash
# MPV 配置测试脚本

CONFIG_DIR="/home/wang1zhen/mpv/portable_config"

echo "================================================"
echo "MPV 配置测试"
echo "================================================"
echo ""

# 检查 mpv 是否安装
if ! command -v mpv &> /dev/null; then
    echo "❌ MPV 未安装"
    exit 1
fi

echo "✅ MPV 版本: $(mpv --version | head -1)"
echo ""

# 检查配置文件
echo "配置文件检查:"
echo "  主配置: $([ -f "$CONFIG_DIR/mpv.conf" ] && echo '✅' || echo '❌') mpv.conf"
echo "  快捷键: $([ -f "$CONFIG_DIR/input.conf" ] && echo '✅' || echo '❌') input.conf"
echo "  ModernZ: $([ -f "$CONFIG_DIR/scripts/modernz.lua" ] && echo '✅' || echo '❌') modernz.lua"
echo "  着色器: $([ -d "$CONFIG_DIR/shaders" ] && echo "✅ $(ls -1 $CONFIG_DIR/shaders/*.glsl 2>/dev/null | wc -l) 个文件" || echo '❌')"
echo ""

# 检查标准配置目录
if [ -L "$HOME/.config/mpv" ]; then
    echo "📂 配置方式: 软链接 (推荐)"
    echo "   链接到: $(readlink -f ~/.config/mpv)"
elif [ -d "$HOME/.config/mpv" ]; then
    echo "📂 配置方式: 标准目录"
else
    echo "⚠️  未设置标准配置，需要使用 --config-dir 参数"
    echo ""
    echo "建议运行以下命令设置配置："
    echo "  ln -s $CONFIG_DIR ~/.config/mpv"
fi

echo ""
echo "================================================"
echo "使用方法:"
echo "================================================"
if [ -d "$HOME/.config/mpv" ] || [ -L "$HOME/.config/mpv" ]; then
    echo "直接运行: mpv 视频文件.mp4"
else
    echo "临时使用: mpv --config-dir=$CONFIG_DIR 视频文件.mp4"
    echo "或设置别名: alias mpv='mpv --config-dir=$CONFIG_DIR'"
fi
echo ""