(ql:quickload :cl-who)
(in-package :cl-user)
(defpackage new64
  (:use :cl :cl-who)
  ;; (:nicknames :)
  (:export :generate)
  )
(in-package :new64)

(setf (html-mode) :html5)

(defun generate ()
  (->file "articles/六四.html" (site-html)))

(defun ->file (path str)
  (with-open-file (stream path
                          :direction :output
                          :if-exists :supersede
                          :external-format :utf-8)
    (format stream str)))

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
}"))
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
                    (:li (:a :href "https://twitter.com/iamnotXt3" "Twitter"))
                    (:li (:a :href "mailto:crackwallsports@gmail.com" "Email")))))))

(defun site-main (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "content"
          (flag s)
          :br
          (declaration s)
          :br
          (music s)
          :br)))

(defun flag (stream)
  (with-html-output (stream nil :indent 2)
    (:div :class "topic" :style " text-align: center"
          "旗帜"
          (:ul (:img :src "resource/new-flag.jpg"  :style "width: 754; height: 506;")))))

(defun declaration (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "topic" "六四宣言"
          (:ul "文本"
               (:li "中英文版本 : "
                    (:a :href "./resource/【中_英】新中国联邦宣言_Declaration of the New Federal State of China.pdf"
                        "【中_英】新中国联邦宣言_Declaration of the New Federal State of China"))
               (:li "其他语言版本 : "
                    (:a :href "https://drive.google.com/drive/folders/1cy5E3aRaOMKIHvzkyQWHvUqBYmYi-sZA"
                        "文本文件/Text file")
                    (:small "via Google Drive: 6/4直播内容/Live broadcast on June 4")))
          (:ul "视频"
               (:li "中文宣言(郝海东先生朗读) : "
                    (:a :href "https://www.youtube.com/watch?v=MthU_7buFGU"
                        "2020年6月4日直播4: 郝海东先生朗读宣言")
                    (:small "via Youtube: 上天造灭疫组"))
               (:li "英文宣言(班农先生朗读) : "
                    (:a :href "https://www.youtube.com/watch?v=qA6TdysBuXI"
                        "2020年6月4日直播6：班农先生朗读英文版宣言")
                    (:small "via Youtube: 上天造灭疫组"))))))

(defun music (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "topic" "音乐"
          (:ul "音乐"
               (:li ""
                    (:a :href "https://www.youtube.com/watch?v=PEqnV-YJw84&feature=youtu.be"
                        "郝海东之后--唐平第一首歌--喜马拉雅自由之巅 ")
                    (:small "via Youtube: 战友之家Voice of Guo Media"))
               (:li ""
                    (:a :href "https://www.youtube.com/watch?v=dBmL5ZBQ3TA&feature=youtu.be"
                        "班农之后---唐平的第二首歌--香港耶路撒冷 ")
                    (:small "via Youtube: 战友之家Voice of Guo Media"))
               (:li ""
                    (:a :href "https://www.youtube.com/watch?v=DmI1YDlQmP0&feature=youtu.be"
                        "采访郝海东夫妇之后--唐平第三首歌----wind of change twins ")
                    (:small "via Youtube: 战友之家Voice of Guo Media"))
               (:li ""
                    (:a :href "https://www.youtube.com/watch?v=w1LrTDC--zg&feature=youtu.be"
                        "参访班农之后--唐平第四首歌---自由")
                    (:small "via Youtube: 战友之家Voice of Guo Media"))
               ))))
