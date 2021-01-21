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

(defun node-id ()
  (format nil "@~a" (get-universal-time)))

(defun link (stream link &optional title)
  (let ((tle (if title title link)))
    (with-html-output (s stream :indent 2)
      (:a :href link (str tle)))))


(defun 3Rabbit (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "topic"
          (:small "补充说明: 兔子不是专业人士 目的只是想从一个普通人角度 搞明白相关信息, 对造成的任何理解偏差和后果 兔子当然是不负责任哆啦")
          (:ul "CCP病毒 (一语双关)"
               (:li "别名: 武汉病毒, 新型冠状病毒, SARS-CoV-2, COVID-19")
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
                                       (:small "Zenodo"))
                                  (:li "引文: " (:q (:pre "
The evidence shows that SARS-CoV-2 should be a laboratory product created by using bat coronaviruses ZC45 and/or ZXC21 as a template and/or backbone.


As a coronavirus, SARS-CoV-2 differs significantly from other respiratory and/or zoonotic viruses: it attacks multiple organs; it is capable of undergoing a long period of asymptomatic infection; it is highly transmissible and significantly lethal in high-risk populations; it is well-adapted to humans since the very start of its emergence1; it is highly efficient in binding the human ACE2 receptor (hACE2), the affinity of which is greater than that associated with the ACE2 of any other potential host2,3.


The existing scientific publications supporting a natural origin theory rely heavily on a single piece of evidence – a previously discovered bat coronavirus named RaTG13, which shares a 96% nucleotide sequence identity with SARS-CoV-218. However, the existence of RaTG13 in nature and the truthfulness of its reported sequence are being widely questioned6-9,19-21. It is noteworthy that scientific journals have clearly censored any dissenting opinions that suggest a non-natural origin of SARS-CoV-28,22. Because of this censorship, articles questioning either the natural origin of SARS-CoV-2 or the actual existence of RaTG13, although of high quality scientifically, can only exist as preprints5-9,19-21 or other non-peer- reviewed articles published on various online platforms10-13,23. Nonetheless, analyses of these reports have repeatedly pointed to severe problems and a probable fraud associated with the reporting of RaTG136,8,9,19- 21. Therefore, the theory that fabricated scientific data has been published to mislead the world’s efforts in tracing the origin of SARS-CoV-2 has become substantially convincing and is interlocked with the notion that SARS-CoV-2 is of a non-natural origin.


1. Has SARS-CoV-2 been subjected to in vitro manipulation?
 We present three lines of evidence to support our contention that laboratory manipulation is part of the history of SARS-CoV-2:
 i. The genomic sequence of SARS-CoV-2 is suspiciously similar to that of a bat coronavirus discovered by military laboratories in the Third Military Medical University (Chongqing, China) and the Research Institute for Medicine of Nanjing Command (Nanjing, China).
 ii. The receptor-binding motif (RBM) within the Spike protein of SARS-CoV-2, which determines the host specificity of the virus, resembles that of SARS-CoV from the 2003 epidemic in a suspicious manner. Genomic evidence suggests that the RBM has been genetically manipulated.
 iii. SARS-CoV-2 contains a unique furin-cleavage site in its Spike protein, which is known to greatly enhance viral infectivity and cell tropism. Yet, this cleavage site is completely absent in this particular class of coronaviruses found in nature. In addition, rare codons associated with this additional sequence suggest the strong possibility that this furin-cleavage site is not the product of natural evolution and could have been inserted into the SARS-CoV-2 genome artificially by techniques other than simple serial passage or multi-strain recombination events inside co-infected tissue cultures or animals.


Although 100% identity on the E protein has been observed between SARS-CoV and certain SARS-related bat coronaviruses, none of those pairs simultaneously share over 83% identity on the Orf8 protein32. Therefore, the 94.2% identity on the Orf8 protein, 100% identity on the E protein, and the overall genomic/amino acid-level resemblance between SARS-CoV-2 and ZC45/ZXC21 are highly unusual. Such evidence, when considered together, is consistent with a hypothesis that the SARS-CoV-2 genome has an origin based on the use of ZC45/ZXC21 as a backbone and/or template for genetic gain-of-function modifications.")))
                                  (:li "问题:"
                                       (:ul (:li "? " (:small "Q@3820220472") ": " "ACE2, hACE2(受体), RBM(结合座) ?")
                                            (:li "? " (:small "Q@3820222342") ": " "RaTG13蝙蝠病毒 不存在?")
                                            (:li "? " (:small "Q@3820222660") ": " "以 蝙蝠冠状病毒 ZC45 和/或 ZXC21为模板和/或骨架 ? 为什么是 和/或, 二者差异?")
                                            (:li "? " (:small "Q@3820222676") ": " "弗林酶切位点(furin-cleavage site)是?")
                                            (:li "? " (:small "Q@3820223947") ": " "Orf8, MHC-1, 稳定性 ?")
                                            (:li "? " (:small "Q@3820224277") ": " "E蛋白, 耐受突变 ?")))))
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
                    (:ul (:li "病毒")
                         (:li "病毒相关知识"
                              (:ul (:li "冠状病毒, β类冠状病毒, 蝙蝠冠状病毒")
                                   (:li "SARS")
                                   (:li "? 病毒 学名解释")
                                   (:li "? 动物携带病毒")
                                   (:li "BLAST (Basic Local Alignment Search Tool)")))
                         (:li "生物化学相关知识")))
               (:li "治疗 预防 (药物 疫苗)"
                    (:ul (:li (link s ""))))
               (:li "病毒 与 中共"
                    (:ul (:li "中共 隐瞒 拖延 欺骗")
                         (:li "病毒来源")))
               (:li "WHO 与 中共"
                    (:ul (:li (link s ""))))))))
