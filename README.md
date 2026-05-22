# My Emacs Configuration

一套面向开发的 Emacs 配置，基于 **Emacs 30**，深度集成 **Evil**（Vim 键绑定）、**Eglot**（LSP）、**Vertico/Orderless**（补全）以及 **Magit**（Git）等现代 Emacs 生态工具。

---

## 目录结构

```
~/.emacs.d/
├── init.el            # 主入口：包管理、主题、字体、加载子模块
├── early-init.el      # 早期初始化：GC、UI 设置、帧设置
├── lisp/
│   ├── base.el        # 基础功能：Emacs 核心、补全、UI、辅助包
│   ├── dev.el         # 开发工具：LSP、Git、搜索、文件管理、翻译
│   ├── key.el         # 按键绑定：Evil 集成、Space leader key 体系
│   └── mavc.el        # 版本控制增强：vc-dir 导航与差异查看
└── README.md          # 本文件
```

---

## 文件详解

### 1. init.el — 主配置文件

| 功能 | 说明 |
|------|------|
| **包管理** | 配置 USTC ELPA 镜像源（gnu/melpa/nongnu），关闭签名检查 |
| **主题** | 加载 `modus-vivendi-tinted` 暗色主题 |
| **字体** | 优先使用 `Maple Mono NF CN` 等宽字体（110 高度），配置 emoji/symbol 回退字体 |
| **跨平台** | macOS 下映射 Command/ Option 修饰键 |
| **备份** | 备份文件集中存储到 `backups/` 目录 |
| **自定义** | 加载 `custom.el` 用户自定义配置 |
| **加载子模块** | 顺序加载 `base.el` → `dev.el` → `mavc.el` → `key.el` |
| **启动信息** | 启动后显示启动耗时 |

### 2. early-init.el — 早期初始化

| 功能 | 说明 |
|------|------|
| **GC 优化** | 启动时将 GC 阈值提升至 100MB，减少启动卡顿 |
| **UI 精简** | 关闭菜单栏、工具栏、滚动条 |
| **编码** | 默认 UTF-8 编码 |
| **启动画面** | 禁用启动提示信息 |
| **帧标题** | 显示当前文件名，修改时显示 ✍️ 标记 |
| **窗口** | 默认最大化启动 |

### 3. lisp/base.el — 基础功能

| 类别 | 包/功能 | 说明 |
|------|---------|------|
| **Emacs 核心** | `use-package` | 统一管理所有包的核心框架 |
| | `winner-mode` | 窗口布局撤销/重做 |
| | `save-place` | 恢复文件上次浏览位置 |
| | `savehist` | 保存 minibuffer 历史 |
| | `global-auto-revert` | 文件变动自动刷新 |
| | `auto-save-visited` | 自动保存已访问文件 |
| | `global-hl-line` | 高亮当前行 |
| | `which-key` | 按键提示弹窗 |
| **Org 模式** | `org` | Org 模式配置：TODO 关键字序列、优先级颜色 |
| **最近文件** | `recentf` | 记录最近 300 个文件 |
| **快速跳转** | `avy` | 屏幕可视跳转 |
| **搜索/导航** | `consult` | 统一搜索/导航接口（替换 xref 后端） |
| **补全框架** | `vertico` | 垂直补全 UI，支持循环滚动、repeat 保存 |
| | `orderless` | 灵活模糊匹配补全样式 |
| | `marginalia` | 补全候选项添加注解 |
| | `embark` + `embark-consult` | 补全上下文操作菜单 |
| **代码补全** | `company` | 自动补全（按 occurrence 排序，substring/flex 匹配） |
| | `company-box` | 补全弹窗 UI 美化 |
| | `completion-preview` | shell/eshell 内联补全预览 |
| **撤销历史** | `undo-fu-session` | 持久化撤销历史，重启后可恢复 |
| **模式栏** | `nyan-mode` | 🌈 彩虹猫进度条 |
| | `doom-modeline` | Doom 风格模式栏 |

### 4. lisp/dev.el — 开发配置

| 类别 | 包/功能 | 说明 |
|------|---------|------|
| **编程通用** | `electric-pair-local-mode` | 自动配对括号 |
| | `hs-minor-mode` | 代码折叠 |
| | `highlight-thing` | 高亮当前光标下符号（sql/sh/elisp/java 模式） |
| | `highlight-parentheses` | 彩虹括号（绿→黄→紫→橙→红） |
| | `ws-butler` | 智能清理行尾空白 |
| **比较工具** | `ediff` | 水平分割窗口，退出时撤销窗口布局 |
| **项目管理** | `project` | 项目切换，支持 `.dir-locals.el` 作为项目标记 |
| **LSP** | `eglot` | 内置 LSP 客户端，自动关闭，Python 使用 `ty` 作为 server |
| **代码跳转** | `dumb-jump` | 基于 ripgrep 的智能跳转，支持 `.dir-locals.el` |
| **Git** | `magit` | 全功能 Git 前端 |
| | `diff-hl` | 行号旁显示 Git 差异标记，支持 hunk 预览 |
| | `wgrep` | 在 grep 结果中直接编辑 |
| **标记语言** | `markdown-mode` | Markdown 编辑支持 |
| | `json-mode` | JSON 编辑支持 |
| **搜索** | `color-rg` | 交互式 ripgrep 搜索前端（从 GitHub 安装） |
| **翻译** | `gt` | Bing + 有道词典翻译，选中即译 |
| **SQL** | `sqlformat` | SQL 格式化 |
| **终端** | `eshell-toggle` | 切换 Eshell 弹出终端 |
| **图标** | `nerd-icons` | Nerd Fonts 图标支持 |
| **文件管理** | `dired` | 自定义 ls 参数、目标窗口智能选择 |
| | `nerd-icons-dired` | Dired 文件名图标 |
| | `dired-sidebar` | 侧边栏文件树（固定宽度、nerd-icons 主题） |
| **AI 助手** | `agent-shell` | AI Shell 集成 |

### 5. lisp/key.el — 按键绑定 (Evil)

| 类别 | 功能 | 说明 |
|------|------|---------|
| **核心** | `evil` | Vim 键绑定引擎，配置撤销系统、增量搜索等 |
| **Space 前缀** | `SPC SPC` | `M-x` 执行命令 |
| | `SPC RET` | `consult-bookmark` |
| | `SPC m` | 临时激活当前 major mode 键位图 |
| | `SPC 0` | 切换文件树侧边栏 |
| | `SPC u` | `universal-argument` |
| | `SPC '` | `vertico-repeat` |
| | `SPC x` | `ctl-x-map` (C-x 前缀) |
| | `SPC a` | `agent-shell` (AI 助手) |
| **Buffer** | `SPC bb` | `consult-buffer` 切换缓冲区 |
| | `SPC bi` | `ibuffer` |
| | `SPC bd` | 删除缓冲区 |
| | `SPC bl` | 切换回上个缓冲区 |
| | `SPC br` | 重载当前缓冲区 |
| | `SPC bx` | 切换到 \*scratch\* |
| **窗口** | `SPC wd` / `ww` / `wm` | 删除/切换/最大化窗口 |
| | `SPC wh/j/k/l` | 方向导航窗口 |
| | `SPC wu/wr` | 窗口布局撤销/重做 |
| | `SPC w>/<` | 水平调整窗口宽度 |
| **文件** | `SPC ff` | `find-file` |
| | `SPC fd` | `consult-fd` 快速搜索文件 |
| | `SPC fs` | 保存文件 |
| | `SPC fr` | 最近文件列表 |
| **搜索** | `SPC ss` | `consult-line` 搜索当前缓冲区 |
| | `SPC sd/sp/sf` | `color-rg` 按范围搜索 |
| | `SPC si` | `consult-imenu` |
| | `SPC so` | `consult-outline` |
| | `SPC sm` | `consult-mark` 跳转到标记 |
| | `SPC st` | `gt-translate` 翻译 |
| **代码** | `SPC ce` | `consult-flymake` 检查错误 |
| | `SPC cf` | `eglot-format` 格式化代码 |
| | `SPC cr` | `eglot-rename` 重命名 |
| | `SPC ca` | `eglot-code-actions` 代码操作 |
| **Git** | `SPC gg` | `magit-status` |
| | `SPC gL` | 当前文件 Git 日志 |
| | `SPC gp/gn` | 当前文件前后版本对比 |
| **跳转** | `SPC jj` | `avy-goto-word-1` 跳转到可视单词 |
| | `SPC jl` | `avy-goto-line` 跳转到行 |
| | `SPC ji` | `eglot-find-implementation` |
| **项目** | `SPC pp` | 切换项目 |
| | `SPC pk` | 关闭项目所有缓冲区及标签页 |
| | `SPC pf` | 项目内查找文件 |
| | `SPC pv` | 项目 vc-dir |
| | `SPC pe` | 项目 eshell |
| | `SPC pb` | 项目内切换缓冲区 |
| | `SPC ps` | 项目内 ripgrep 搜索 |
| **标签页** | `SPC tt` | 最近使用的标签页 |
| **打开** | `SPC oe` | 切换 eshell-toggle 终端 |
| | `SPC oo/of` | 在浏览器中打开目录/文件 |
| | `SPC od` | `dired-jump` |
| **帮助** | `SPC hk/hf/hv/hm/hp` | 描述键/函数/变量/模式/包 |
| | `SPC h?` | 显示当前模式键位图 |
| **退出** | `SPC qr` | 重启 Emacs |
| | `SPC qq` | 退出 Emacs |
| **增强绑定** | `C-a` | `embark-act` (Normal 态) |
| | `RET` | `embark-dwim` (编程/Org/Markdown 模式) |
| | `gh/gl` | 跳到行首/行尾非空字符 |
| | `gr` | `xref-find-references` |
| | `M-,` / `C-M-,` | 向后/向前跳转 |
| **文本对象** | `ig` / `ag` | 选择整个缓冲区 |
| | `iq` / `aq` | 选择单引号内容 |
| **Dired** | `<backspace>` | 上级目录 |
| | `i` | 展开/折叠子目录 (`dired-subtree`) |
| **Eshell** | `C-r` | `consult-history` (Insert 态) |
| | `C-w` | 删除前一个单词 |
| | `C-u` | 清除整行输入 |
| | `<escape>` | 关闭 eshell-toggle |
| **辅助包** | `evil-textobj-line` | 行文本对象 |
| | `evil-surround` | `ys`/`ds`/`cs` 环绕编辑 |
| | `evil-visualstar` | 可视模式选中后 `*`/`#` 搜索 |
| | `evil-anzu` | 搜索时显示匹配计数 |
| | `evil-multiedit` | 多光标编辑 |
| | `evil-mc` | 多光标支持（`gz` 前缀） |
| | `mwim` | `<home>`/`<end>` 智能行首/行尾 |

### 6. lisp/mavc.el — 版本控制增强

| 功能 | 说明 |
|------|------|
| **VC 后端** | 仅启用 Git |
| **文件导航** | `TAB` / `S-TAB` 在 vc-dir 中自动跳到有变更的下一/上一个文件并显示 diff |
| **快速提交** | `c` 标记所有已跟踪的已修改/新增/删除文件并进入提交界面 |
| **快捷键** | `e` → `vc-ediff`，`d` → `vc-diff`，`k` → `vc-revert`，`F` → `vc-pull` |

---

## 安装与使用

1. **要求**：Emacs 30+ （建议使用最新稳定版）
2. **字体**：推荐安装 [Maple Mono NF CN](https://github.com/subframe7536/maple-font) 以获得最佳显示效果
3. **首次启动**：
   ```bash
   git clone <仓库地址> ~/.emacs.d
   emacs --init-directory=~/.emacs.d
   ```
   首次启动时 `use-package` 会自动安装所有声明的包。

4. **包管理命令**：
   - `M-x list-packages` 查看/管理包
   - 新包声明方式：`(use-package <包名> :ensure t)`

---

## 核心设计理念

- **模块化**：将配置拆分为 `base`（基础）、`dev`（开发）、`key`（按键）、`mavc`（版本控制）四个独立模块
- **现代补全栈**：`vertico` + `orderless` + `marginalia` + `embark` + `consult` 提供一体化补全与搜索体验
- **Vim 中心**：以 Evil 为核心操作范式，Space leader key 体系组织快捷键
- **开箱即用**：最小化手动配置，LSP、Git、搜索、项目管理等开发工具预集成
