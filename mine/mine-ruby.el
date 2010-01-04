;; Ruby Dependencies

(add-path "site-lisp/rinari/")

(require 'ruby-electric)
(require 'rdebug)
(require 'ruby-style)
(autoload 'ruby-mode "ruby-mode" "Major mode for editing Ruby code" t)
(autoload 'run-ruby "inf-ruby" "Runs an inferior ruby process")
(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")

;; Rinari setup
(require 'rinari)
(setq rinari-tags-file-name "TAGS")
(setq rinari-major-modes
      (list 'find-file-hook
            'mumamo-after-change-major-mode-hook
            'dired-mode-hook
            'shell-mode-hook))

;; autotest setup
(autoload 'autotest "autotest" "Run autotest" t)
(setq autotest-use-ui t)

(defun autotest-rspec ()
  "Runs autotest as rspec enabled"
  (interactive)
  (setq autotest-command "RSPEC=true autotest")
  (autotest)
  (setq autotest-command "autotest"))

(defun autotest-rspec-with-features ()
  "Runs autotest as rspec and cucumber features enabled"
  (interactive)
  (setq autotest-command "AUTOFEATURE=true RSPEC=true autotest")
  (autotest)
  (setq autotest-command "autotest"))

;; Use ruby-compmilation from rinari
;; (add-path "site-lisp/rinari/util/")
;; (require 'ruby-compilation-rspec)

;; File Types
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\config.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))

;; Hooks
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(add-hook 'ruby-mode-hook '(lambda() (inf-ruby-keys)))
(add-hook 'ruby-mode-hook '(lambda() (local-set-key "\r" 'ruby-reindent-then-newline-and-indent)))
(add-hook 'ruby-mode-hook '(lambda () (local-set-key (kbd "C-c C-a") 'autotest-switch)))
(add-hook 'ruby-mode-hook
          '(lambda ()
	     (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
		 (flymake-mode))
	     ))

;; Ri setup
(setq ri-repl-executable "ri_repl")

;; Misc
(defun run-jruby ()
  (interactive)
    (run-ruby "/usr/local/bin/jruby -S irb --inf-ruby-mode" "jruby"))

;; Flymake Flymake
(require 'flymake)
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")

;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
	 (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

;; Cucumber (perhaps not totally ruby related)
(add-path "site-lisp/cucumber-mode/")
(autoload 'feature-mode "feature-mode" "Major mode for editing plain text stories" t)
(add-to-list 'auto-mode-alist '("\\.feature\\'" . feature-mode))
(add-hook 'feature-mode-hook '(lambda () (local-set-key (kbd "C-c C-a") 'autotest-switch)))

(provide 'mine-ruby)
