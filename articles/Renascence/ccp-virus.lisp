(ql:quickload :cl-who)

(defpackage Xt3.Page.ccpvirus
  (:use :cl :cl-who)
  (:nicknames :3ccpvirus)
  (:export :export-html)
  )
(in-package :Xt3.Page.ccpvirus)

(defun ->file (path str)
  (with-open-file (stream path
                          :direction :output
                          :if-exists :supersede
                          :external-format :utf-8)
    (format stream str)))

(defun export-html ()
  (setf (html-mode) :html5)
  (->file "articles/Renascence/ccp-virus.html" (site-html)))

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
                    (:li (:a :href "mailto:crackwallsports@gmail.com" "Email"))
                    (:li (:a :href "https://web.gtv1.org/web/#/UserInfo?id=5e85cf42ca963f510b635c44" "GTV"))
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
.side-header .contact li{
display: inline}
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
 padding-left: 3%;
 padding-right: 3%

}
.content .topic {
  border: 1px dashed black;
  padding: 3px;
}
small {
#  font-size: 80%;
}

")

(defun link (stream link &optional title)
  (let ((tle (if title title link)))
    (with-html-output (s stream :indent 2)
      (:a :href link (str tle)))))


(defun 3Rabbit (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "topic" 
          (:ul "CCP病毒"
               (:li "别名: 武汉病毒, 新型冠状病毒, COVID-19")
               (:li "时间线: " (link s "" "待整理...") "(以下为部分关键点)"
                    (:ul (:li (:small "2020.01.19")
                              "Video: "
                              (link s "https://youtu.be/CLTjg03CPEs")
                              (:small "Youtube:路德社LUDE Media")
                              (:q (:pre "1/19/2020 路安艾时评：重磅！
为什么财新胡舒立要一再否认武汉SARS病毒和舟山蝙蝠病毒的关联性？
为什么该病毒已经进化具备人传人大爆发强变异？
为什么中共要不断隐瞒确诊案例？")))
                         (:li (link s ""))))
               (:li"闫丽梦博士 论文"
                   (:ul (:li (:small "2020.9.14")
                             "Unusual Features of the SARS-CoV-2 Genome Suggesting Sophisticated Laboratory Modification Rather Than Natural Evolution and Delineation of Its Probable Synthetic Route"
                             (:ul (:li "获得: "
                                       (link s "https://zenodo.org/record/4028830")
                                       (:small "Zenodo"))))
                         (:li (:small "2020.10.8")
                              "SARS-CoV-2 Is an Unrestricted Bioweapon:
A Truth Revealed through Uncovering a Large-Scale, Organized Scientific Fraud"
                              (:ul (:li "获得: "
                                        (link s "https://zenodo.org/record/4073131")
                                        (:small "Zenodo"))))
                         (:li (:small "2020.11.21")
                              "CNN Used Lies and Misinformation to Muddle the Water on the Origin of SARS-CoV-2"
                              (:ul (:li "获得: "
                                        (link s "https://zenodo.org/record/4283480")
                                        (:small "Zenodo"))))
                         (:li (:small "2021.01.19")
                              "Call for the WHO Team to Investigate the Pangolin Coronaviruses and the RmYN02 Bat Coronavirus"
                              (:ul (:li "获得: "
                                        (link s "https://zenodo.org/record/4448499")
                                        (:small "Zenodo"))))))
               (:li "理解"
                    (:ul (:li "病毒机理")
                         (:li "病毒相关知识")
                         (:li "生物化学相关知识")))
               (:li "治疗 预防 (药物 疫苗)"
                    (:ul (:li (link s ""))))
               (:li "病毒 与 中共"
                    (:ul (:li "中共 隐瞒 拖延 欺骗")
                         (:li "病毒来源")))
               (:li "WHO 与 中共"
                    (:ul (:li (link s ""))))))))
