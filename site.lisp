;; Base
;; 也许需要改变 slime的工作目录
(load "base")

;; html
;; -| layout
(defmacro layout-template
    (&key (title "Index") (links ()) (head-rest ()) (content ()) (scripts ()))
  `(let ((title ,title)
         (links ,links)
         (head-rest ,head-rest)
         (content ,content)
         (scripts ,scripts))
     `(,,(doctype)
         (html (lang= "en")
               (head ()
                     (meta (:charset "utf-8"))
                     (meta (:name "viewport"
                                  :content "width=device-width, initial-scale=1, shrink-to-fit=no"))
                     (meta (:name "description" :content "Blog"))
                     (meta (:name "author" :content "Xt3"))
                     (title nil ,title)
                     ,@links
                     ,@head-rest)
               (body () ,@content ,@scripts)))))


;; -| index.html
(->file
 #P"./index.html" 
 #'->html
 (layout-template
  :title "Xt3 Blog"
  :links `((link (:rel "stylesheet" :href "./css/style.css"))
           (link (:rel "stylesheet" :href "./css/font-awesome.min.css")))
  :scripts `() ;; (script (:src "./js/main.js"))
  :content
  `((header (:class "side-header")
            (div (:class "logo")
                 (img (:src "./resource/carrot.PNG")))
            (nav (:class "contact" :role "navigation")
                 (ul ()
                     (li () (a (:href "#") "Twitter"))
                     (li () (a (:href "#") "Email")))))
    (hr (:class "divider"))
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
                                              (p () ,excerpt))))))
          ;; pageination
          (nav (:class "pagination" :role "navigation")
               (span (:class "page-number") "Page 1 of 9")
               (a (:class "older-posts" :href "/page/2/") "时光倒流->")))
    (footer (:class "side-footer")
            (a (:class "twitter" :href "https://twitter.com/iamnotXt3")
               (i (:class "fa fa-twitter" :aria-hidden "true") "@iamnotXt3"))
            (a (:class "github" :href "https://github.com/crackwallsports")
               (i (:class "fa fa-github" :aria-hidden "true") "crackwallsports"))
            (span (:class "email")
                  (i (:class "fa fa-envelope" :aria-hidden "true")
                     "crackwallsports@gmail.com"))
            (p (:class "copyright") "All content copyright © 2017 Xt3")))))


;; -| style.css
;;
(->file
 #P"./css/style.css" 
 #'->css
 `((* (;; :border "1px dashed red"
       :box-sizing "border-box"
       :padding 0 :margin 0))
   (html (:font-size "62.5%"))
   (body (:color "#3a4145"))
   (a (:text-decoration "none"))
   ("ul, li" (:list-style "none"))
   ;; Header
   (".side-header" (:position "relative" :width "100%" :height "130px"
                              :margin "20px auto" :padding-bottom "20px")
                   (".logo" (:position "absolute" :right "50%"
                                       :width "40%" :height "100%" :max-width "350px"
                                       :display "inline-block")
                            (img (:position "relative" :width "120px" :height "120px"
                                            :position "absolute" :bottom "5px"))) ;; :border-radius "50% 50%" :box-shadow "2px 3px 3px black"
                   (".contact" (:position "absolute" :left "50%" :bottom 0
                                          :display "inline-block"
                                          :width "40%" :max-width "350px"
                                          :font-size "2rem" :font-weight "bold" :text-align "right")
                               (li (:display "inline" :margin-left "20px")
                                   (a (:color ,(css-color :grey))))))
   ;; Main-Content
   (".content" (:width "100%")
               (".post" (:font-size "1.6rem" :line-height "1.6rem"
                                    :width "80%" :max-width "700px" :margin "3rem auto" :padding-bottom "3rem"
                                    :border-bottom "#a7abb3 1px solid"
                                    :word-break "break-word"))
               (".post-meta" (:display "block"
                                       :margin-bottom "1rem"
                                       :font-size "1.5rem"
                                       :color "#9eabb3"))
               (".post-title a" (:color "black"))
               (".post-title a:hover" (:color ,(css-color :indigo)))
               (".post-excerpt p" (:margin "1.6rem 0" :font-size "1.5rem" :line-height "1.5em"))
               (".pagination" (:position "relative" :width "80%" :height "41px" :max-width "700px" :margin "4rem auto"
                                         :font-size "1.5rem" :color "#93abb3"
                                         :text-align "center")
                              (".page-number" (:position "relative"
                                                         :top "8px" :display "inline-block" :padding "5px"))
                              (".older-posts" (:position "absolute" :right 0 :padding "8px 15px"
                                                         :display "inline-block"
                                                         :border "#ebf2f6 2px solid" :border-radius "30px"
                                                         :color "#9eabb3"))
                              (".older-posts:hover" (:color "black" :border-color "black"))))
   (".side-footer" (:margin "4rem 0 0 0" :padding "3rem 0"
                            :text-align "center"
                            :color "#bbc7cc" :background-color "#f9f9f9"
                            :border-top "#ebf2f6 1px solid"
                            :font-size "1.6rem" :line-height "1.6em")
                   (".twitter, .email, .github" (:color "black"
                                                 :display "block"
                                                 ))
                   ("a:hover" (:font-size "2rem")))))


