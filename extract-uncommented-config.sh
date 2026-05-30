#!/bin/bash

set -euo pipefail

if [ "$#" -gt 2 ]; then
  printf '用法: %s [输入配置文件] [输出配置文件]\n' "$0" >&2
  exit 1
fi

if [ "$#" -eq 0 ]; then
  input="2410-6.6-360t7.config"
else
  input="$1"
fi

if [ "$#" -lt 2 ]; then
  output="${input%.config}.uncommented.config"
else
  output="$2"
fi

if [ ! -f "$input" ]; then
  printf '输入文件不存在: %s\n' "$input" >&2
  exit 1
fi

# 只保留非空且首个非空字符不是 # 的有效配置行。
awk 'NF && $0 !~ /^[[:space:]]*#/' "$input" > "$output"

printf '已提取未注释配置: %s -> %s\n' "$input" "$output"
