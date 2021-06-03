(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
	     '("elpa" . "https//elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;;(package-refresh-contents)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(dracula))
 '(custom-safe-themes
   '("824d07981667fd7d63488756b6d6a4036bae972d26337babf7b56df6e42f2bcd" default))
 '(package-selected-packages '(writeroom-mode general which-key dracula-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; general - facilita o mapeamento de teclas
(use-package general
  :ensure t
  :config
(general-evil-setup t))

(nvmap :prefix "SPC"
       "b b"   '(ibuffer :which-key "Ibuffer")
       "b c"   '(clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
       "b k"   '(kill-current-buffer :which-key "Kill current buffer")
       "b n"   '(next-buffer :which-key "Next buffer")
       "b p"   '(previous-buffer :which-key "Previous buffer")
       "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
       "b K"   '(kill-buffer :which-key "Kill buffer"))

;; evil mode - modo de edição do vim
(use-package evil
             :ensure t  ;; install evil if not installed
             :init      ;; twerak evil's configuration before loading it
             (setq evil-want-integration t) ;; This is optional since it's already set to t by default
             (setq evil-want-keybinding nil)
             (setq evil-vsplit-window-right t)
             (setq evil-split-window-below t)
             (evil-mode))
(use-package evil-collection
             :after evil
             :ensure t
             :config
             (evil-collection-init))

(winner-mode 1)
(nvmap :prefix "SPC"
       ;; Window splits
       "w c"   '(evil-window-delete :which-key "Close window")
       "w n"   '(evil-window-new :which-key "New window")
       "w s"   '(evil-window-split :which-key "Horizontal split window")
       "w v"   '(evil-window-vsplit :which-key "Vertical split window")
       ;; Window motions
       "w h"   '(evil-window-left :which-key "Window left")
       "w j"   '(evil-window-down :which-key "Window down")
       "w k"   '(evil-window-up :which-key "Window up")
       "w l"   '(evil-window-right :which-key "Window right")
       "w w"   '(evil-window-next :which-key "Goto next window")
       ;; winner mode
       "w <left>"  '(winner-undo :which-key "Winner undo")
       "w <right>" '(winner-redo :which-key "Winner redo"))

;;By default in Emacs, we don’t have ability to select text, and then start typing and our new text replaces the selection.  Let’s fix that!
(delete-selection-mode t)

;; limpeza visual - elimina barras de menu e de scroll
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; linhas numeradas e truncadas (não continuam infinitamente até o enter ser pressionado
(global-display-line-numbers-mode 1)
(global-visual-line-mode t) 

;; zoom in and out
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
;;(global-set-key (kbd "C-0"'(lambda () (interactive) (text-scale-adjust 0)))

;; which key - indica os comandos possíveis
(use-package which-key
  :init
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.8
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit t
        which-key-separator " → " ))
(which-key-mode)

;; scrolling
(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; all the icons
(use-package all-the-icons)

;; writeroom-mode - elimina distrações da tela
(use-package writeroom-mode)
(nvmap :prefix "SPC"
       "g"   'writeroom-mode)

;; eshell
(nvmap :prefix "SPC"
       "e h"   '(counsel-esh-history :which-key "Eshell history")
       "e s"   '(eshell :which-key "Eshell"))
