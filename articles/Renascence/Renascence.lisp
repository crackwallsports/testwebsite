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
                  (:style (str (site-css))))
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



(defun site-css () nil "
html {
  font-size: 90%;
}
body {
margin: 0;
font-family: -apple-system,BlinkMacSystemFont,\"Segoe UI\",Roboto,\"Helvetica Neue\",Arial,sans-serif,\"Apple Color Emoji\",\"Segoe UI Emoji\",\"Segoe UI Symbol\",\"Noto Color Emoji\";
font-size: 1rem;
font-weight: 400;
line-height: 1.5;
text-align: left;
}
.side-header .contact {
 font-size: 130%}
.btn-link {
 color: black
}
.btn-link:hover {
 text-decoration:none
}
.topic cite {
 font-size: 88%
}
.topic q {
 border-left: 5px rgb(210, 212, 212) solid;
 display: block;
 padding: 5px 10px 5px 10px;
 text-align: justify;
}
 .topic q::before, q::before {
 display: block;
 content: \"\";
}
.topic li pre {
 display: inline;
 margin: 0;
 white-space: pre-wrap;
}
.topic li q {
 margin-left: 16px;
}

.content{
 padding-left: 10%
}
.content .topic {
  border: 1px dashed black;
  padding: 3px;
}
small {
#  font-size: 80%;
}

")

(let ((next 30000000000))
  (defun gen-id ()
    (incf next)))

(defun node-id (stream)
  (format stream "@~a" (get-universal-time)))

(defun node-keys (stream keys)
  (format stream "#{~a}" keys))


;; (defparameter *r-stream* nil)

(defun link (stream link &optional title)
  (let ((tle (if title title link)))
    (with-html-output (s stream :indent 2)
      (:a :href link (str tle)))))

(defmacro r-node (stream timestamp keys content)
  `(with-html-output (s ,stream :indent 2)
     (:ul :class "r-node"
          (:small :class "node-ctime" (str ,timestamp))
          (:small :class "node-id" "@" (str (gen-id)))
          (:small :class "node-keys" (node-keys s ,keys))
          ,content)))

(defun 3Rabbit (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "topic" "3Rabbit 测试 : 兔子 所言 所思 所看 所听 所得"
          (r-node s "2021.01.04" "路德社"
                  (:li "Video: " (link s "https://youtu.be/X6wQ4zzRs7U")
                       (:small "Youtube:路德社LUDE Media")
                       (:q (:pre "
1/3/2021 路德时评（路博艾冠谈）：
美国家安全副顾问博明正式告诉英国官员病毒来自中共实验室意味着什么？
新华社副社长熊向晖之女怎么说？
更多议员宣布支持克鲁兹的1月6日声明意味着什么？
"))))
          (r-node s "2021.01.04" "郭文贵"
                  (:li "Getter (Video) : "
                       (link s "https://gtv.org/getter/5ff1d5fd87fabe2daf2fdc75")
                       (:small "GTV:郭文贵MILES")
                       (:q (:pre "
2021年1月3号：爆料革命又为美国做出了巨大贡献。唯真不破就是爆料革命百战百胜的法宝……爆料革命的跟随者将如海啸般的爆发，一切都已经开始！
"))))
          (r-node s "2021.01.03" "兔语"
                  (:li "X tooo: "
                       (:q (:pre "
兔子 新年问候 😄
愿人生平等 望众生平安
希望")))))))
