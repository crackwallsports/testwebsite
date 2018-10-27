(in-package :cl-user)
(defpackage test-website
  (:use :cl 
        :xt3.web.base)
  (:nicknames :twb)
  (:export :generate
           :gen-with-frame))
(in-package :test-website)

(defun generate ()
  (->file #P"./index.html" (index ()))
  (->file #P"./css/style.css" (css))
  (->file #P"./js/main.js" (js)))

(defun gen-with-frame (title path)
  (->file (merge-pathnames (concat "box-" (pathname-name path) ".html")
                           path)
          (->html
           (layout-template
            nil
            :title title
            :links `((link (:rel "stylesheet" :href "/testwebsite/css/bootstrap.min.css"))
                     (link (:rel "stylesheet" :href "/testwebsite/css/font-awesome.min.css"))
                     (link (:rel "stylesheet" :href "/testwebsite/css/style.css")))
            :content
            `(,(site-header)
               (main (:class "content" :style "display: flex")
                     (iframe (:src ,(merge-pathnames path
                                                     #P"/testwebsite/")
                                   :style "width:100%; border:none; box-shadow: 0px 0px 20px; border-radius: 20px;")))
               ,(site-footer))
            :scripts `((script (:src "/testwebsite/js/jquery-3.2.1.min.js"))
                       (script (:src "https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
                                     :integrity "sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
                                     :crossorigin "anonymous")))))))

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
      (li () (a (:href "https://www.guo.media/xt3") "GUO.MEDIA"))
      (li () (a (:href "https://twitter.com/iamnotXt3") "Twitter"))
      (li () (a (:href "mailto:crackwallsports@gmail.com") "Email"))))))

(defun site-footer ()
  '(footer (:class "side-footer")
    (a (:class "twitter" :href "https://twitter.com/iamnotXt3")
     (i (:class "fa fa-twitter" :aria-hidden "true") "@iamnotXt3")) (br)
    (a (:class "github" :href "https://github.com/crackwallsports")
     (i (:class "fa fa-github" :aria-hidden "true") "crackwallsports")) (br)
    (a (:class "email" :href "mailto:crackwallsports@gmail.com")
     (i (:class "fa fa-envelope" :aria-hidden "true") "crackwallsports@gmail.com")) (br)
    (p (:class "copyright") "All content copyright © 2017 Xt3")))

(defun index (args)
  (->html
    (layout-template
     args
     :title (or (getf args :title) "Xt3 Blog")
     :links `((link (:rel "stylesheet" :href "/testwebsite/css/bootstrap.min.css"))
              (link (:rel "stylesheet" :href "/testwebsite/css/font-awesome.min.css"))
              (link (:rel "stylesheet" :href "/testwebsite/css/style.css")))
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
     (body (:color "#3a4145" ;; :font-family "Georgia, STSong"
                   ))
     (a (:text-decoration "none"))
     ("ul, li" (:list-style "none"
                :padding-left "8px" :list-style-position "inside"))
     ;; Header
     (".side-header" (:position "fixed" :margin "20px auto"
                                :width "200px" :height "200px")
                     (".logo" (:position "relative" :left "30px"
                                         :display "block")
                              (img (:width "120px" :height "120px")))
                     (".contact" (:font-size "2rem"  :padding-left "20%")
                                 (li ()
                                     (a (:color "rgba(30, 30, 30, 0.92)")))))
     ;; Main-Content
     (".content" ( :padding-left "20%" :padding-right "10%" :padding-top "30px" :min-height "600px")
                 (".post" (:font-size "1.6rem"
                                      :width "80%"
                                      :margin-top "3rem" :margin-left "2rem"
                                      :padding-bottom "3rem"
                                      :border-bottom "#a7abb3 1px solid"
                                      :word-break "break-word"))
                 (".post-meta" (:display "block"
                                         :margin-bottom "1rem"
                                         :font-size "1.5rem"
                                         :color "#9eabb3"))
                 (".post-title a" (:color "black"))
                 (".post-title a:hover" (:color ,(css-color :indigo)))
                 (".post-excerpt p" (:margin "1.6rem 0" :font-size "1.5rem" :line-height "1.5em"))
                 ;; Topic

                 (".topic" ()
                           ("li p" (:padding-left "16px" :margin "auto"))
                           ("li::before" (:content "\"-\"" :padding-right "8px"))))
     ;; Footer
     (".side-footer" (:margin "4rem 0 0 0" :padding "3rem 0"
                              :text-align "center"
                              :color "#bbc7cc" :background-color "#f9f9f9"
                              :border-top "#ebf2f6 1px solid"
                              :font-size "1.6rem" :line-height "1.6em")
                     (".twitter, .email, .github" (:color "black"
                                                          :display "inline-block"))
                     ;; ("a:hover, span:hover" (:font-size "2rem"))
                     ))))

(defun js () "")
