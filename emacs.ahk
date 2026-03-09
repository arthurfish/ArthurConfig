; ====================================================================================
; ===                     Emacs 流畅文本编辑体验脚本 v1.3 (简化版)                   ===
; ===                      专为 Windows 设计 (AutoHotkey v2)                       ===
; ====================================================================================
;
; 设计目标 (简化后):
; 1. 提供核心的 Emacs 导航和编辑键位。
; 2. 快捷键在指定的应用程序 (如 IDE, 终端) 中自动禁用。
; 3. 代码清晰、易读、易于扩展。
;
; ====================================================================================
#Requires AutoHotkey v2.0+
#SingleInstance Force
Persistent

; ====================================================================================
; ===                        第一部分: 核心功能函数 (应用过滤)                         ===
; ====================================================================================

; ---
; 函数: IsAppExcluded()
; 作用: 检查当前活动的窗口是否属于我们想要禁用 Emacs 模式的应用程序。
; 返回: 如果是需要被排除的应用，返回 true；否则返回 false。
; ---
IsAppExcluded() {
    ; AHK 知识点: WinActive() 函数
    ; 这是在 #HotIf 中判断当前活动窗口的最可靠方法。
    ; "ahk_exe process_name.exe" 是一种特殊的 WinTitle 参数，
    ; 它会精确匹配程序的进程名，忽略窗口标题。
    
    excludedApps := [
        "code.exe",             ; VSCode
        "WindowsTerminal.exe",  ; Windows Terminal
        ;"bash.exe",             ; Git Bash (或其他 bash 环境)
        "idea64.exe",           ; IntelliJ IDEA
        "pycharm64.exe",        ; PyCharm
        "webstorm64.exe",       ; WebStorm
        "goland64.exe",         ; GoLand
        "clion64.exe",          ; CLion
        "datagrip64.exe",       ; DataGrip
        "rider64.exe"           ; Rider
    ]

    ; 遍历排除列表，检查是否有任何一个应用是当前活动的
    for app in excludedApps {
        if WinActive("ahk_exe " . app) {
            return true ; 只要找到一个匹配的，就立即返回 true
        }
    }

    ; 如果循环结束都没有找到匹配的，说明当前应用不在排除列表中
    return false
}


; ====================================================================================
; ===                 第二部分: Emacs 核心功能热键 (受应用过滤控制)                    ===
; ====================================================================================
;
; AHK 知识点:
; 这里的 #HotIf 是脚本的核心。它现在只包含一个条件: !IsAppExcluded()
; 这意味着 "当且仅当，当前的应用不是被排除的应用时"，下面的热键才会生效。
#HotIf !IsAppExcluded()

; --- 基础光标移动 ---
^f:: Send "{Right}"
^b:: Send "{Left}"
^p:: Send "{Up}"
^n:: Send "{Down}"

; --- 行内移动 ---
^e:: Send "{End}"

; --- 单词移动 ---
!f:: Send "^{Right}"
!b:: Send "^{Left}"

; --- 文本删除 ---
^d:: Send "{Delete}"
!d:: Send "^{Delete}"
!Backspace:: Send "^{Backspace}"

; --- 行删除 ---
^k:: Send "+{End}{Delete}"

; --- 文档级移动 ---
!<:: Send "^{Home}"
!>:: Send "^{End}"

^+f:: Send "^f"

; --- 特殊处理: C-a (单击移动到行首，双击全选) ---
^a:: HandleControlA()

HandleControlA() {
    static lastPressTime := 0
    currentTime := A_TickCount
    
    if (currentTime - lastPressTime < 300) {
        Send "^a"
        lastPressTime := 0
    } else {
        Send "{Home}"
        lastPressTime := currentTime
    }
}

; 结束 #HotIf 的作用域
#HotIf