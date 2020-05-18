;; (Date Ref Title Intro)
(("2020 5 18"
  "/testwebsite/articles/Swift0to1.html"
  "从 Swift 开始"
  (div () ""))
 ("2020 1 31"
  "/testwebsite/articles/News.html"
  "News 新鲜事"
  (p ()
     (div ()
          (span () "郭文贵")
          (span (:class "badge badge-success") "每日追踪-2019.9.23")
          (pre ()
               (small () "法治基金")
               (small () "王健之死"))
          (span () "关注 香港 新疆 西藏 台湾") (br)
          (span () "关注 疫情 (中共国的信息可信度存疑 可能更严重)") (br)
          (span () "CDC 美国疾病控制与预防中心 : "
                (small ()
                       (a (:href "https://www.cdc.gov/coronavirus/2019-ncov/about/index.html")
                          "About 2019 Novel Coronavirus (2019-nCoV)"))))))
 ("2019 1 30"
  "/testwebsite/articles/box-common-lisp-note.html"
  "Common Lisp Note - 笔记整理 (草稿)"
  (div ()
       ""
       (span (:class "badge badge-success") " 更新-2019.3.26")))
 ("2019 1 8"
  "/testwebsite/articles/box-ImageMagick-note.html"
  "ImageMagick Note - 笔记整理 (草稿)"
  (div ()
       ""
       (span (:class "badge badge-success") " 更新-2019.1.10")))
 ("2018 11 7"
  "/testwebsite/articles/box-emacs-note.html"
  "Emacs Note - 笔记整理 (草稿)"
  (div ()
       (span (:class "badge badge-success") " 更新-2019.2.28")
       (pre () "Emacs - 基础")))
 ("2018 10 27"
  "/testwebsite/articles/box-learn-c.html"
  "学习 C 语言 - 笔记整理 (草稿)"
  (div ()
       (span (:class "badge badge-success") "更新-2019.2.25")
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
