;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(
     treemacs-projectile
     helm-projectile
     company
     flycheck
     flycheck-pos-tip
     yasnippet
     smartparens
     magit
     paredit
     multiple-cursors
     move-text
     markdown-mode
     restclient
     dockerfile-mode
     string-edit
     beginend
     guide-key
     js2-mode
     js2-refactor
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))


;; guide-key
(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8" "C-x +"))
(guide-key-mode 1)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)

;; Setup extensions
(eval-after-load 'org '(require 'setup-org))
(eval-after-load 'magit '(require 'setup-magit))
(require 'setup-hippie)
(require 'setup-yasnippet)
(require 'setup-html-mode)
(require 'setup-paredit)
(beginend-global-mode)

;; Default setup of smartparens
(require 'smartparens-config)
(setq sp-autoescape-string-quote nil)
(--each '(css-mode-hook
          restclient-mode-hook
          js-mode-hook
          java-mode
          ruby-mode
          markdown-mode
          groovy-mode
          scala-mode)
  (add-hook it 'turn-on-smartparens-mode))

;; Language specific setup files
(eval-after-load 'js2-mode '(require 'setup-js2-mode))
(eval-after-load 'ruby-mode '(require 'setup-ruby-mode))
(eval-after-load 'markdown-mode '(require 'setup-markdown-mode))

(eval-after-load 'flycheck '(require 'setup-flycheck))

;; Map files to modes
(require 'mode-mappings)

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

(require 'multiple-cursors)

;; Setup key bindings
(require 'key-bindings)

  ;; Conclude init by setting up specifics for the current user
(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))

