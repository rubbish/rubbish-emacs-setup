;; ido-mode
(require 'ido)
(ido-mode t)

;; ido setup
(setq ido-enable-prefix nil
         ido-enable-flex-matching t
         ido-create-new-buffer 'always
         ido-use-filename-at-point t
         ido-max-prospects 10)

;; Setup Environmental Variables
(setq default-major-mode 'text-mode)
(setq inhibit-startup-message t)

;; Auto revert files
(global-auto-revert-mode 1)

;; Always use subwords to to move aroudn
(c-subword-mode t)

;; Use soft tabs
(setq-default indent-tabs-mode nil)

;; Don't make backups
(setq make-backup-files nil)
(setq version-control nil)

;; Misc Aliases
(defalias 'qrr 'query-replace-regexp)

;; Midnight mode to clean up old buffers
(require 'midnight)

;; Miscallaneous Things
(mouse-wheel-mode t)
(setq visible-bell t)

(provide 'mine-misc)