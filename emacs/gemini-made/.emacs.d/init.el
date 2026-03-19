;; -*- lexical-binding: t; -*-


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Emacs Native-First Configuration
;;
;; 哲学：此配置旨在最大限度地利用 Emacs 内置功能，避免第三方依赖，
;; 以实现最快的速度、最高的稳定性，并深入体验 Emacs 的核心能力。
;;
;; Philosophy: This configuration aims to maximize the use of built-in
;; Emacs features, avoiding third-party dependencies for maximum speed,
;; stability, and a deep dive into Emacs's core capabilities.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 1. 核心 UI 与外观 (Core UI & Appearance)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; English: Disable GUI elements for a minimal interface.
(menu-bar-mode -1)      ;; Hide the menu bar
(tool-bar-mode -1)      ;; Hide the toolbar
(scroll-bar-mode -1)    ;; Hide the scroll bars
;; English: Disable the mode-line (the status bar at the bottom).
(setq-default mode-line-format nil)


;; English: Don't show the splash screen, we will define a custom startup screen later.
(setq inhibit-startup-screen t)

;; English: Make the cursor solid (don't blink).
(blink-cursor-mode 0)

;; English: Set frame transparency. Works on most Linux WMs and Windows.
(set-frame-parameter (selected-frame) 'alpha '(95 . 85))
(add-to-list 'default-frame-alist '(alpha . (95 . 85)))

;; English: Load a theme. `load-theme` is the native way to do this.
;;(load-theme 'eziam t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 2. 字体配置 (Font Configuration)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; English: Font settings that adapt to Windows and Linux.
(defvar my-cjk-font-name
  (cond ((eq system-type 'windows-nt) "wqy-microhei") ;; Font for Windows
        ((eq system-type 'gnu/linux) "wqy-microhei")      ;; Font for Linux
        (t "FZYouSong"))                                ;; A fallback font
  "The font family name for CJK characters based on the OS.")

;; English: Set the default font face for English text.
(set-face-attribute 'default nil :family "Fira Code" :height 130)

;; English: Set a specific font for CJK characters to ensure readability.
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font t charset (font-spec :family "simfang")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 3. 原生编辑体验增强 (Native Editing Enhancements)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --- 基础编辑设置 (Basic Editing Settings) ---
(setq select-enable-clipboard t)    ;; Integrate with system clipboard.
(delete-selection-mode t)          ;; Typing deletes the selected region.
(show-paren-mode t)                ;; Highlight matching parentheses.
(electric-pair-mode t)             ;; Auto-insert matching pairs.
(fset 'yes-or-no-p 'y-or-n-p)      ;; Use y/n instead of yes/no.
(setq column-number-mode t)         ;; Show column number in the mode line.

;; --- 行号 (Line Numbers) ---
;; English: Use the modern, built-in display-line-numbers-mode.
(setq display-line-numbers-width 3)
(global-display-line-numbers-mode 1)

;; --- 缩进 (Indentation) ---
;; English: Configure indentation to use 4 spaces instead of tabs.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)

;; --- 历史记录 (History) ---
;; English: Remember minibuffer history between Emacs sessions.
(savehist-mode 1)
;; English: Remember recently opened files.
(recentf-mode 1)

(setq recentf-max-menu-items 25)

;; --- 文件备份 (Backup Files) ---
;; English: A clean setup for automatic backups in a dedicated directory.
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)
(setq version-control t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 4. 迷你缓冲区补全 (Minibuffer Completion)
;;
;; Emacs 28+ 提供了 Fido 模式，这是一个非常好的、内置的补全 UI。
;; 它替代了 Vertico/Ivy/Helm 等第三方包。
;; English: Emacs 28+ provides Fido mode, an excellent built-in completion UI.
;; It serves as a native alternative to Vertico, Ivy, or Helm.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fido-vertical-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 5. 原生项目管理 (Native Project Management)
;;
;; Emacs 内置了 `project.el` 用于项目管理，可以识别 Git/SVN 仓库。
;; 它是 Projectile 的原生替代品。所有命令都以 `C-x p` 开头。
;; - `C-x p f`: 在项目中查找文件 (project-find-file)
;; - `C-x p g`: 在项目中搜索 (project-find-regexp)
;; - `C-x p s`: 在项目中运行 shell 命令 (project-shell-command)
;;
;; English: Emacs has built-in project management with `project.el`. It's the
;; native alternative to Projectile. All commands are on the `C-x p` prefix.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (No configuration needed, just use the C-x p commands.)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 6. 原生编程支持 (Native Programming Support)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --- LSP (语言服务器协议) via Eglot ---
;; Emacs 29+ 已内置 Eglot，无需安装。它为编程提供了 IDE 级别的功能。
;; 注意：你仍需为你的语言安装 Language Server, 如 `clangd` (C++) 或 `pylsp` (Python)。
;;
;; English: Eglot is built into Emacs 29+, providing IDE-like features.
;; Note: You still need to install language servers like `clangd` or `pylsp`.

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)

;; --- 代码补全 (Code Completion) ---
;; Emacs 的原生补全功能是 `completion-at-point`。当 Eglot 运行时，它会自动
;; 提供来自 Language Server 的智能补全建议。
;; 默认快捷键是 `M-TAB` 或 `C-M-i`。
;;
;; English: Emacs's native completion is `completion-at-point`, which is
;; automatically powered by Eglot when active. Default key is `M-TAB` or `C-M-i`.
;; (No configuration needed, just use the keybinding in a programming buffer.)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 7. 自定义函数与快捷键 (Custom Functions & Keybindings)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; English: Kill the current buffer without asking for confirmation.
(defun kill-this-buffer ()
  "Kill the current buffer without confirmation."
  (interactive)
  (kill-buffer (current-buffer)))

;; English: A unified compile function using native `compile`.
(defun my-compile-buffer ()
  "Compile the current buffer based on its file extension."
  (interactive)
  (when (buffer-file-name)
    (save-buffer)
    (let* ((file (buffer-file-name))
           (extension (file-name-extension file))
           (base-name (file-name-base file))
           (cmd
            (cond
             ((member extension '("c" "cpp"))
              (let ((compiler (if (equal extension "c") "gcc" "g++")))
                (format "%s -g -Wall -o %s %s" compiler base-name file)))
             ((equal extension "java") (format "javac -g %s" file))
             ((equal extension "py") (format "python3 %s" file))
             (t nil))))
      (if cmd
          (compile cmd)
        (message "Don't know how to compile .%s files" extension)))))

;; --- Global Keybindings ---
(global-set-key (kbd "C-t") 'shell)
(global-set-key (kbd "C-x C-w") 'eww)
(global-set-key (kbd "C-x g") 'vc-dir) ; Use native Git status screen (alternative to Magit)
(global-set-key (kbd "C-x v v") 'vc-next-action) ; The primary command for native Git
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "<f9>") #'my-compile-buffer)
(global-set-key (kbd "<f11>") 'toggle-frame-fullscreen)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 8. 自定义启动页 (Custom Startup "Dashboard")
;;
;; 我们不使用第三方包，而是自定义 `initial-scratch-message` 来创建一个
;; 简单但实用的启动页面。
;; English: Instead of a third-party package, we customize the scratch message
;; to create a simple but functional "dashboard".
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; English: Set the initial buffer to be the *scratch* buffer, which now acts as our dashboard.
;;(setq initial-buffer-choice (lambda () (get-buffer-create "*scratch*")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Final message to show that the config has been loaded successfully.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Emacs native config loaded successfully!")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6313ec4a0eba2f6b2492447273f761332aaf7a2ab2864396cc2726af025895c3"
     default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; English: Set the initial frame size (width and height).
;; The width and height are specified in characters and lines, not pixels.
(add-to-list 'default-frame-alist '(width . 60))  ; 设置宽度为 120 个字符
(add-to-list 'default-frame-alist '(height . 25))   ; 设置高度为 30 行

(setq initial-scratch-message ":)   " )
