
;; Org-mode Style
(->file
 #P"./css/org.css" 
 (->css
  `(("article, aside, details, figcaption, figure, footer, header, hgroup, nav, section, summary"
     (:display "block"))
    ("audio, canvas, video" (:display "inline-block"))
    ("audio:not([controls])" (:display "none" :height 0))
    ("[hidden]" (:display "none"))
    ;;
    (html (:font-size "62.5%" :font-family "sans-serif"))
    (body (:margin 0))
    ;;
    (a (:text-decoration "none"))
    ("a:focus" (:outline "thin dotted"))
    (h1 (:font-size "2em"))
    ("ul, li" (:list-style "none"))
    ;;
    ("#content" (:margin auto))
    ;; code{padding:2px 5px;margin:auto 1px;border:1px solid #ddd;border-radius:3px;background-clip:padding-box;color:#333;font-size:80%}
    (code (:padding "2px 5px" :margin "auto"
                    :border "1px solid #ddd" :border-radius "3px"))
    )))
