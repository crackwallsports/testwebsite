(ql:quickload :cl-who)

(defpackage Xt3.Page.Renascence
  (:use :cl :cl-who)
  (:nicknames :3Renascence)
  (:export :export-html)
  )
(in-package :Xt3.Page.Renascence)

(defun ->file (path str)
  (with-open-file (stream path
                          :direction :output
                          :if-exists :supersede
                          :external-format :utf-8)
    (format stream str)))

(defun export-html ()
  (setf (html-mode) :html5)
  (->file "articles/Renascence/Renascence.html" (site-html)))

(defun site-html ()
  (with-html-output-to-string (s nil :indent 2 :prologue t)
    (:html :lang "en"
           (:head (:meta :charset "utf-8")
                  ;;(:link :rel "stylesheet" :href "/testwebsite/css/style.css")
                  (:link :rel "stylesheet" :href "style.css"))
           (:body (site-header s)
                  (site-main s)
                  (site-footer s)
                  ))))

(defun site-header (stream)
  (with-html-output (s stream :indent 2)
    (:header :class "side-header"
             (:a :class "logo" :href "/testwebsite/index.html"
                 (:img :src "/testwebsite/resource/carrot.PNG")))))

(defun site-main (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "content"
          (3Rabbit s)
          :br)))


(defun site-footer (stream)
  (with-html-output (s stream :indent 2)
    (:footer :class "side-footer"
             (:div :class "contact"
                   (:a :href "https://gettr.com/user/xt333"
                       "Gettr: 3Rabbit @Xt333")
                   (:br)
                   (:a :class "twitter" :href "https://twitter.com/iamnotXt3"
                       "Twitter: @iamnotXt3")
                   (:br)
                   (:a :class "email" :href "mailto:crackwallsports@gmail.com"
                       "crackwallsports@gmail.com")
                   (:br)
                   (:a :class "github" :href "https://github.com/crackwallsports"
                       "Github: crackwallsports"))
             (:p :class "copyright" "All content copyright © 2017 Xt3"))))

(defun node-templete ()
  '(r-node s "2021.time" (node-id) "keys"
    (:li "Title"
     (link s "")
     (:small "Ref")
     (:q (:pre "
Content
")))))

(defun node-id ()
  (format nil "@~a" (get-universal-time)))

(defun node-keys (stream keys)
  (format stream "#{~a}" keys))


;; (defparameter *r-stream* nil)

(defun link (stream link &optional title)
  (let ((tle (if title title link)))
    (with-html-output (s stream :indent 2)
      (:a :href link (str tle)))))

(defmacro r-node (stream timestamp id keys &rest content)
  `(with-html-output (s ,stream :indent 2)
     (:ul :class "r-node"
          (:small :class "node-ctime" (str ,timestamp))
          (:small :class "node-id" (str ,id))
          (:small :class "node-keys" (node-keys s ,keys))
          ,@content)))




(defun 3Rabbit (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "topic" "3Rabbit 测试 : 兔子 所言 所思 所看 所听 所得"
          (r-node s "2021.07.05" "" ""
                  (:li "Info : " (:br)
                       (:ul
                        (:li "中英文对照: "
                             (link s "Xi100/Xi100.html"
                                   "在庆祝中国共产党成立100周年大会上的讲话 (Speech at a Ceremony Marking the Centenary of the  Communist Party of China)" )))))
          (r-node s "2021.01.28 (Update: 2021.07.15"   "@3820827124" "关注信息源"
                  (:li "Follow : " (:br)
                       (:ul
                        (:li "Gettr" (link s "https://gettr.com/" ))
                        (:li "G|TV" (link s "https://gtv.org/" ))
                        (:li "GNEWS" (link s "https://gnews.org/zh-hans/"))
                        (:li "郭文贵"
                             (:ul (:li (link s "https://gettr.com/user/miles")
                                       (:small "Gettr: MILES GUO @Miles"))
                                  (:li (link s "https://gtv.org/user/5e596957357cc612d35a8044")
                                       (:small "G|TV: 郭文贵MILES"))))
                        ;; (:li "路德"
                        ;;      (:ul
                        ;;       (:li
                        ;;        (link s "https://gtv.org/user/5e890397490f470e21d37b24")
                        ;;        (:small "G|TV: 路德时评"))
                        ;;       (:li
                        ;;        (link s "https://www.youtube.com/channel/UCm3Ysfy0iXhGbIDTNNwLqbQ/featured")
                        ;;        (:small "Youtube: 路德社LUDE Media"))))
                        )))
          
          (r-node s "2021.01.19 (Update: 2021.07.15)" "@3820050169" "CCP病毒"
                  ;; (:li "Know : " (:br)
                  ;;      (link s "ccp-virus.html" "CCP病毒"))
                  (:li "See : " (:br)
                       (:ul ;; (:li (link s "https://twitter.com/DrLiMengYAN1"
                            ;;            "闫丽梦博士 Twitter: Dr. Li-Meng YAN @DrLiMengYAN1"))
                            (:li (link s "https://gnews.org/zh-hans/category/ccpvirus-cn/"
                                       "GNEWS : CCP病毒"))
                            (:li  (link s "https://pandemic.warroom.org/"
                                        "War room : Pandemic")
                                  (:ul (:li (link s "https://gtv.org/user/5ed199be2ba3ce32911df7ac"
                                                  "秘密翻译组")
                                            (:small "(包含 班农战斗室 中文同声翻译)"))))
                            ;; (:li (link s "https://www.youtube.com/channel/UCJwXLE6A7WomYVlTHMHgMuQ"
                            ;;            "上天造灭疫组"))
                            ))))))
