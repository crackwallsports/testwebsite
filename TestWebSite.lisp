(in-package :cl-user)
(defpackage test-website
  (:use :cl 
        :xt3.web.base)
  (:nicknames :twb)
  (:export :generate))
(in-package :test-website)

(defun generate ()
  (->file #P"./index.html" (index ()))
  (->file #P"./css/style.css" (css))
  (->file #P"./js/main.js" (js)))

(defun human-date (date)
  (and date
       (multiple-value-bind
             (second minute hour day month year)
           (decode-universal-time date)
         (format nil "~4D.~2,'0D.~2,'0D ~2,'0D:~2,'0D:~2,'0D"
                 year month day hour minute second))))

(defun layout-template (args &key (title "标题") links head-rest content scripts)
  (declare (ignore args))
  `(,(doctype)
     (html (:lang "en")
           (head ()
                 (meta (:charset "utf-8"))
                 (meta (:name "viewport"
                              :content "width=device-width, initial-scale=1, shrink-to-fit=no"))
                 (meta (:name "description" :content "?"))
                 (meta (:name "author" :content "Xt3"))
                 (title nil ,title)
                 ,@links
                 ,@head-rest)
           (body ()
                 ,@content
                 ,@scripts))))

(defun site-header ()
  '(header (:class "side-header")
    (a (:class "logo" :href "/testwebsite/index.html")
     (img (:src "/testwebsite/resource/carrot.PNG")))
    (nav (:class "contact" :role "navigation")
     (ul ()
      (li () (a (:href "#") "Twitter"))
      (li () (a (:href "#") "Email"))))
    (hr (:class "divider"))))

(defun site-footer ()
  '(footer (:class "side-footer")
    (a (:class "twitter" :href "https://twitter.com/iamnotXt3")
     (i (:class "fa fa-twitter" :aria-hidden "true") "@iamnotXt3")) (br)
    (a (:class "github" :href "https://github.com/crackwallsports")
     (i (:class "fa fa-github" :aria-hidden "true") "crackwallsports")) (br)
    (span (:class "email")
     (i (:class "fa fa-envelope" :aria-hidden "true")
      "crackwallsports@gmail.com")) (br)
    (p (:class "copyright") "All content copyright © 2017 Xt3")))

(defun index (args)
  (->html
    (layout-template
     args
     :title (or (getf args :title) "Xt3 Blog")
     :links `((link (:rel "stylesheet" :href "./css/style.css"))
              (link (:rel "stylesheet" :href "./css/font-awesome.min.css")))
     :content
     `(,(site-header)
       (main (:class "content")
             ;; articles
             ,@(let ((posts (with-open-file (stream #P"posts.lisp")
                              (read stream))))
                 (loop for i in posts
                    collect (destructuring-bind (time ref title excerpt) i
                              `(article (:class "post")
                                        (header (:class "post-header")
                                                (span (:class "post-meta")
                                                      (time () ,time))
                                                (h2 (:class "post-title")
                                                    (a (:href ,ref) ,title)))
                                        (section (:class "post-excerpt")
                                                 (p () ,excerpt)))))))
        ,(site-footer)))))

(defun css ()
  (->css
   `((* ( ;; :border "1px dashed red"
         :box-sizing "border-box"
         :padding 0 :margin 0))
     (html (:font-size "62.5%"))
     (body (:color "#3a4145"))
     (a (:text-decoration "none"))
     ("ul, li" (:list-style "none"))
     ;; Header
     (".side-header" (:position "relative"
                                :width "100%" :height "130px"
                                :margin "20px auto" :padding-left "80px")
                     (".logo" (:position "absolute" :right "50%"
                                         :width "40%" :height "100%"
                                         :max-width "350px"
                                         :display "inline-block")
                              (img (:position "absolute"
                                              :width "120px" :height "120px"
                                              :vertical-align "middle"
                                              :bottom "3px"))) ;; :border-radius "50% 50%" :box-shadow "2px 3px 3px black"
                     (".contact" (:position "absolute" :left "50%" :bottom 0
                                            :display "inline-block"
                                            :width "40%" :max-width "350px"
                                            :font-size "2rem" :font-weight "bold" :text-align "right")
                                 (li (:display "inline" :margin-left "20px")
                                     (a (:color ,(css-color :grey)))))
                     (".divider" (:position "absolute" :bottom "-10px" :left "0px"
                                            :width "100%")))
     ;; Main-Content
     (".content" (:width "100%")
                 (".post" (:font-size "1.6rem"
                                      :width "80%" :max-width "700px" :margin "3rem auto" :padding-bottom "3rem"
                                      :border-bottom "#a7abb3 1px solid"
                                      :word-break "break-word"))
                 (".post-meta" (:display "block"
                                         :margin-bottom "1rem"
                                         :font-size "1.5rem"
                                         :color "#9eabb3"))
                 (".post-title a" (:color "black"))
                 (".post-title a:hover" (:color ,(css-color :indigo)))
                 (".post-excerpt p" (:margin "1.6rem 0" :font-size "1.5rem" :line-height "1.5em")))
     ;; Footer
     (".side-footer" (:margin "4rem 0 0 0" :padding "3rem 0"
                              :text-align "center"
                              :color "#bbc7cc" :background-color "#f9f9f9"
                              :border-top "#ebf2f6 1px solid"
                              :font-size "1.6rem" :line-height "1.6em")
                     (".twitter, .email, .github" (:color "black"
                                                          :display "inline-block"))
                     ("a:hover, span:hover" (:font-size "2rem"))))))

(defun js () "")
