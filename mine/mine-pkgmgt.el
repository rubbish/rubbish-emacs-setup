(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max)) (eval-print-last-sexp))))

(setq el-get-user-package-directory "~/.emacs.d/init")

(setq el-get-sources '((:name enclose
                              :description "Enclose cursor within punctuation pairs"
                              :type elpa
                              :autoloads nil
                              :prepare (progn
                                         (autoload 'enclose-global-mode "enclose" nil t)
                                         (autoload 'enclose-mode "enclose" nil t)))
                       (:name zen-and-art-theme
                              :description "A port of the zen-and-art color theme using the new deftheme format."
                              :type elpa
                              :repo ("melpa" . "http://melpa.milkbox.net/packages/")
                              :post-init (progn
                                           (add-to-list 'custom-theme-load-path default-directory)))
                       (:name scala-mode2
                              :website "https://github.com/hvesalai/scala-mode2"
                              :type github
                              :pkgname "hvesalai/scala-mode2")
                       (:name sbt
                              :website "https://github.com/rubbish/sbt.el"
                              :description "support for running sbt in inferior mode."
                              :type github
                              :pkgname "rubbish/sbt.el"
                              :prepare (add-hook 'scala-mode-hook 'turn-on-sbt-mode))
                       (:name rcirc-color
                              :website "http://emacswiki.org/emacs/rcirc-color.el"
                              :description "color nicks in rcirc"
                              :type github
                              :pkgname "emacsmirror/rcirc-color"
                              :features (rcirc-color))
                       (:name rcirc-auto-away
                              :website "http://www.emacswiki.org/emacs/rcircAutoAway"
                              :type emacswiki)
                       (:name rcirc-notify
                              :website "https://github.com/nicferrier/rcirc-notify"
                              :type elpa
                              :repo ("marmalade" . "http://marmalade-repo.org/packages/")
                              :after (add-hook 'rcirc-mode-hook 'rcirc-notify-add-hooks))
                       (:name org
                              :website "http://orgmode.org/"
                              :description "Org-mode is for keeping notes, maintaining ToDo lists, doing project planning, and authoring with a fast and effective plain-text system."
                              :type elpa
                              :repo ("org" . "http://orgmode.org/elpa/"))))

(setq mine-pkgs-to-install
      (append
       '(;; lisp
         highlight-parentheses
         paredit

         ;; scala
         ;; scala-mode
         ;; ensime

         haskell-mode

         ;; markdown
         markdown-mode

         ;; organization
         deft
         todotxt

         ;; text editting
         ;; undo-tree
         wrap-region
         mark-multiple
         expand-region
         yasnippet

         ;; commands
         smex
         full-ack
         switch-window
         scratch
         gist
         magit
         htmlize)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync mine-pkgs-to-install)

(provide 'mine-pkgmgt)
