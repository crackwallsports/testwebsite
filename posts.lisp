;; (Date Ref Title Intro)
(("2019 2 12"
  "/testwebsite/articles/News.html"
  "News 新鲜事"
  (p ()
     (div ()
          (span () "郭文贵")
          (span (:class "badge badge-success") "每日追踪-2.12")
          (pre ()
               (small () "法治基金")
               (small () "王健之死")
               ))))
 ("2019 1 30"
  "/testwebsite/articles/box-common-lisp-note.html"
  "Common Lisp Note - 笔记整理 (草稿)"
  (div ()
       ""
       ;; (span (:class "badge badge-success") " 更新-1.10")
       ))
 ("2019 1 8"
  "/testwebsite/articles/box-ImageMagick-note.html"
  "ImageMagick Note - 笔记整理 (草稿)"
  (div ()
       ""
       (span (:class "badge badge-success") " 更新-1.10")))
 ("2018 11 7"
  "/testwebsite/articles/box-emacs-note.html"
  "Emacs Note - 笔记整理 (草稿)"
  (div ()
       "Emacs - 基础 - Edit(编辑) - Other "
       (span (:class "badge badge-success") " 更新-2019.2.7")))
 ("2018 10 27"
  "/testwebsite/articles/box-learn-c.html"
  "学习 C 语言 - 笔记整理 (草稿)"
  (div ()
     (span (:class "badge badge-success") "更新-2019.2.7")
     (pre () "
C 语言学习的笔记整理 不是单纯的修剪笔记 而是 重构
重新思考 如何一点点引导 将整个知识串接在一起
目前只是试验阶段 
")))
 ("2017 7 22"
  "/testwebsite/articles/2017/7/box-web-learn-nodeexpress.html"
  "Web 开发学习笔记 - SbyS: Node.js Express MongoDB"
  "手把手向导 学习Web开发 从 Node.js Express MongoDB 开始 走向人生巅峰 拥有自己的网站"))


;;  (span (:class "badge badge-success") "新")
;; (span (:style "display: inline-block; text-align: center;")
;;       (span (:style "font-size: 50%;") "译文")
;;       (span (:style "display: grid;")
;;             "原文"))

;; #.(->html '(span (:style "display: inline-block; text-align: center; line-height: 1em")
;;             (span (:style "font-size: 50%;") "Learn C Programming Note")
;;               (span (:style "display: grid;")
;;                "学习 C语言 笔记")))
