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
                  (:link :rel "stylesheet" :href "/testwebsite/css/style.css")
                  (:style "
.content {
 padding: 10px;
}
.topic {
  border: 1px dashed black;
  padding: 3px;
}
small {
  font-size: 60%;
}
html {
  font-size: 90%;
}
li pre {
display: inline-flex;
white-space: pre-wrap
}
"))
           (:body (site-header s)
                  (site-main s)))))

(defun site-header (stream)
  (with-html-output (s stream :indent 2)
    (:header :class "side-header"
             (:a :class "logo" :href "/testwebsite/index.html"
                 (:img :src "/testwebsite/resource/carrot.PNG"))
             (:nav :class "contact" :role "navigation"
                   (:ul
                    (:li (:a :href "https://web.gtv1.org/web/#/UserInfo?id=5e85cf42ca963f510b635c44" "GTV"))
                    (:li (:a :href "mailto:crackwallsports@gmail.com" "Email"))
                    (:li (:a :href "https://twitter.com/iamnotXt3" "Twitter")))))))

(defun site-main (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "content"
          (3Rabbit s)
          :br)))

(defun 3Rabbit (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "topic" "3Rabbit"
          (:ul :class "r-node"
               (:li :class "node-create-time" "2021.01.03")
               (:li (:pre "
兔子 新年问候 😄
愿人生平等 望众生平安
希望"))))))
