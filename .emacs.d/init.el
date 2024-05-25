(setq mode-line-format nil);;Hide the mode Line!

(package-initialize)

(add-to-list 'load-path "~/.emacs.d/solarized-theme")
(add-to-list 'load-path "~/.emacs.d/color-theme")
(add-to-list 'load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;;(setq default-directory "~/code/")
(defun guicolor ()
  (load "oceanic.el"))
(defun tcolor ()
  (load "eziam.el"))

(if (display-graphic-p)
    (guicolor)
  (tcolor))

(if (display-graphic-p)(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
		    charset (font-spec :family "Fira Code"
				       :size 15))))
(set-face-attribute 'default nil :font "Fira Code 10")

(setq inhibit-splash-screen t)
(setq initial-scratch-message "")

(menu-bar-mode 0)
(tool-bar-mode 0);;Hide toolbar
(set-scroll-bar-mode nil)

;(setq frame-title-format " ")
(setq x-select-enable-clipboard t);;Ctrl-c&Ctrl-v

(setq linum-format "%3d")
(global-linum-mode 1)

(delete-selection-mode t)

(setq column-number-mode t);;Syntax on
(setq c-default-style "linux" c-basic-offset 4)
(setq default-indent-tabs-mode nil)
(setq default-tab-width 4)
(setq indent-tabs-mode t)
(setq default-tab-width 8)
(setq tab-width 8)
(setq tab-stop-list ())

(show-paren-mode t);;()Point
(fset 'yes-or-no-p 'y-or-n-p);;y/n

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))


(global-set-key (kbd "C-t") 'shell)
(global-set-key (kbd "C-x C-w") 'eww )
(global-set-key (kbd "C-x C-g") 'gdb )

(defun cppCompile()
  (interactive)
  (compile (format "g++ -g -Wall %s" (buffer-file-name))))

(defun cppRun()
  (interactive)
(compile (format "~/code/a.out")))
;;  (compile (format "java ~/gcxreader/gcxreader")))


(global-set-key (kbd "<f9>") #'cppCompile)
(global-set-key (kbd "<f10>") #'cppRun)

(defun fullscreen()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
;;(fullscreen)

(electric-pair-mode t)

;;BackUpSet
;;(setq backup-directory-alist (quote (("." . "~/.backups"))))
;(setq backup-directory-alist (quote "~/.backups"))
;(setq version-control t)
;(setq kept-old-versions 5)
;(setq kept-new-versions 5)
;(setq backup-directory-alist '(("." . "~/.backups")))
;(setq backup-by-copying t)

;;(set-frame-parameter (selected-frame) 'alpha (list 50 50))
;;(add-to-list 'default-frame-alist (cons 'alpha (list 50 50)))


;;(setq visible-cursor nil)
(blink-cursor-mode 0);;Cursor Not Flash

(setq-default mode-line-format nil);;Hide the mode Line!

(defun compile-buffer ()
;;  "Compile current buffer file."
  (interactive)
  (save-buffer)
  (let ((file (buffer-file-name)) base-name)
    (if (not file)
        (message "No file associated with this buffer!")
      (setq base-name (file-name-nondirectory file))
      (let ((extension (file-name-extension file)))
        (cond
         ((equal extension "cpp")
          (compile (format "g++ -g -Wall %s" file )))
         ((equal extension "c")
          (compile (format "gcc -g -Wall %s -o %s" file (file-name-base))))
         ((equal extension "java")
          (compile (format "javac -g %s" file)))
         ((equal extension "pl")
          (compile (format "perl -w %s" file)))
         ((equal extension "py")
          (compile (format "konsole -e python3 %s" file))))))))
(global-set-key (kbd "<f9>") #'compile-buffer)

(global-set-key (kbd "C-x k") 'kill-this-buffer);; Kill Buffer without asking

;;Set window transparent
(set-frame-parameter (selected-frame) 'alpha (list 90 90))
(add-to-list 'default-frame-alist (cons 'alpha (list 90 90)))
