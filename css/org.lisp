
;; Org-mode Style
(->file
 #P"./org.css" 
 #'->css
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
   ( "a:focus" (:outline "thin dotted"))
   (h1 (:font-size "2em"))
   ("ul, li" (:list-style "none"))))
