(setq doom-font (font-spec :family "JetBrains Mono" :size 22))
(setq display-line-numbers-type 'relative)
(setq org-directory "~/notes/")
(setq org-agenda-files '("~/notes/"))
;; PDFs visited in Org-mode are opened in Okular (and not in the default choice) https://stackoverflow.com/a/8836108/789593
(add-hook 'org-mode-hook
      '(lambda ()
         (delete '("\\.pdf\\'" . default) org-file-apps)
         (add-to-list 'org-file-apps '("\\.pdf\\'" . "okular %s"))))
