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

(defun gen-id ()
  (get-universal-time))

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
line-height: 1.8;
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
 margin-left: 13px;
}
ul li {
padding-left: 6px;
}
.content{
 padding-left: 3%;
 padding-right: 3%

}
.content .topic {
  border: 1px dashed black;
  padding: 3px;
}
.content .topic li::before {
  padding-right: 2px;
}

small {
#  font-size: 80%;
}

.news {
margin: 10px 0px
}
")

(defun node-id ()
  (format nil "@~a" (get-universal-time)))

(defun link (stream link &optional title)
  (let ((tle (if title title link)))
    (with-html-output (s stream :indent 2)
      (:a :href link (str tle)))))

(defun link-str (link &optional title)
  (let ((tle (if title title link)))
    (with-html-output-to-string (s nil :indent 2)
      (:a :href link (str tle)))))

(defun 3Rabbit (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "topic"
          (:small "补充说明: 兔子不是专业人士 目的只是想从一个普通人角度 搞明白相关信息, 对造成的任何理解偏差和后果 兔子当然是不负责任哆啦")
          (:ul "CCP病毒 (一语双关)"
               (:li "别名: 武汉病毒, 新型冠状病毒, SARS-CoV-2, COVID-19")
               (:li "时间线: " (link s "" "待整理...") 
                    (virus-time-line s))
               (:li "关键点"
                    (:ul (:li (:small "2020.01.19")
                              "Video: "
                              (link s "https://youtu.be/CLTjg03CPEs"
                                    "1/19/2020 路安艾时评：重磅！")
                              (:small "Youtube:路德社LUDE Media")
                              (:small " {20200119V1}")
                              (:q (:pre "
为什么财新胡舒立要一再否认武汉SARS病毒和舟山蝙蝠病毒的关联性？
为什么该病毒已经进化具备人传人大爆发强变异？
为什么中共要不断隐瞒确诊案例？")))
                         (:li (link s ""))))
               (dr-yan s)
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
               (:li "中共 与 病毒"
                    (:ul (:li "中共 隐瞒 拖延 欺骗")
                         (:li "病毒来源")))
               (:li "中共 与 WHO"
                    (:ul (:li (link s ""))))))))

(defun Dr-Yan (stream)
  (with-html-output (s stream :indent 2)
    (:li "闫丽梦博士团队 论文"
         (:ul
          (:li "闫丽梦博士 " (link s "https://twitter.com/DrLiMengYAN1" "Twitter: Dr. Li-Meng YAN @DrLiMengYAN1"))
          (:li (:small "2020.9.14")
               "Unusual Features of the SARS-CoV-2 Genome Suggesting Sophisticated Laboratory Modification Rather Than Natural Evolution and Delineation of Its Probable Synthetic Route"
               (:ul (:li "获得: "
                         (link s "https://zenodo.org/record/4028830")
                         (:small "Zenodo"))
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
                         (:small "Zenodo"))))
          (:li (:small "2021.03.31")
               "The Wuhan Laboratory Origin of SARS-CoV-2 and the Validity of the Yan Reports Are Further Proved by the Failure of Two Uninvited \"Peer Reviews\""
               (:ul (:li "获得: "
                         (link s "https://zenodo.org/record/4650821")
                         (:small "Zenodo"))))))))



;; (:li "引文: " (:q (:pre "
;; The evidence shows that SARS-CoV-2 should be a laboratory product created by using bat coronaviruses ZC45 and/or ZXC21 as a template and/or backbone.


;; As a coronavirus, SARS-CoV-2 differs significantly from other respiratory and/or zoonotic viruses: it attacks multiple organs; it is capable of undergoing a long period of asymptomatic infection; it is highly transmissible and significantly lethal in high-risk populations; it is well-adapted to humans since the very start of its emergence1; it is highly efficient in binding the human ACE2 receptor (hACE2), the affinity of which is greater than that associated with the ACE2 of any other potential host2,3.


;; The existing scientific publications supporting a natural origin theory rely heavily on a single piece of evidence – a previously discovered bat coronavirus named RaTG13, which shares a 96% nucleotide sequence identity with SARS-CoV-218. However, the existence of RaTG13 in nature and the truthfulness of its reported sequence are being widely questioned6-9,19-21. It is noteworthy that scientific journals have clearly censored any dissenting opinions that suggest a non-natural origin of SARS-CoV-28,22. Because of this censorship, articles questioning either the natural origin of SARS-CoV-2 or the actual existence of RaTG13, although of high quality scientifically, can only exist as preprints5-9,19-21 or other non-peer- reviewed articles published on various online platforms10-13,23. Nonetheless, analyses of these reports have repeatedly pointed to severe problems and a probable fraud associated with the reporting of RaTG136,8,9,19- 21. Therefore, the theory that fabricated scientific data has been published to mislead the world’s efforts in tracing the origin of SARS-CoV-2 has become substantially convincing and is interlocked with the notion that SARS-CoV-2 is of a non-natural origin.


;; 1. Has SARS-CoV-2 been subjected to in vitro manipulation?
;;  We present three lines of evidence to support our contention that laboratory manipulation is part of the history of SARS-CoV-2:
;;  i. The genomic sequence of SARS-CoV-2 is suspiciously similar to that of a bat coronavirus discovered by military laboratories in the Third Military Medical University (Chongqing, China) and the Research Institute for Medicine of Nanjing Command (Nanjing, China).
;;  ii. The receptor-binding motif (RBM) within the Spike protein of SARS-CoV-2, which determines the host specificity of the virus, resembles that of SARS-CoV from the 2003 epidemic in a suspicious manner. Genomic evidence suggests that the RBM has been genetically manipulated.
;;  iii. SARS-CoV-2 contains a unique furin-cleavage site in its Spike protein, which is known to greatly enhance viral infectivity and cell tropism. Yet, this cleavage site is completely absent in this particular class of coronaviruses found in nature. In addition, rare codons associated with this additional sequence suggest the strong possibility that this furin-cleavage site is not the product of natural evolution and could have been inserted into the SARS-CoV-2 genome artificially by techniques other than simple serial passage or multi-strain recombination events inside co-infected tissue cultures or animals.


;; Although 100% identity on the E protein has been observed between SARS-CoV and certain SARS-related bat coronaviruses, none of those pairs simultaneously share over 83% identity on the Orf8 protein32. Therefore, the 94.2% identity on the Orf8 protein, 100% identity on the E protein, and the overall genomic/amino acid-level resemblance between SARS-CoV-2 and ZC45/ZXC21 are highly unusual. Such evidence, when considered together, is consistent with a hypothesis that the SARS-CoV-2 genome has an origin based on the use of ZC45/ZXC21 as a backbone and/or template for genetic gain-of-function modifications.")))

(defun virus-time-line (stream)
  (with-html-output (s stream :indent 2)
    (:ul
     (:li "注"
          (:ul (:li (:small "时间 来源于引文中 可能因为时区等原因 会不准确"))
               (:li (:small "静态内容的呈现 兔子为了自己方便 目前不是按时间序列呈现 而是有层级关系"))
               (:li (:small "兔子 很懂中文 英文马马虎虎 其它国家语言基本都不懂 所以其它语言信息出错 不要惊讶"))))
     (:li (:small "202 . . ")
          ": "
          (link s "")
          (:small "")
          (:q (:pre "")))
     (:li "...最早...")
     ;; 2020.1.19
     (:li (:small "2020.01.19")
          "Video: "                     ; V1
          (link s "https://youtu.be/CLTjg03CPEs"
                "1/19/2020 路安艾时评：重磅！")
          (:small "Youtube:路德社LUDE Media")
          (:small " {20200119V1}")
          (:q (:pre "
为什么财新胡舒立要一再否认武汉SARS病毒和舟山蝙蝠病毒的关联性？
为什么该病毒已经进化具备人传人大爆发强变异？
为什么中共要不断隐瞒确诊案例？")))
     ;; 2020.9.14
     (:li (:small "2020.09.14")
          "Article" (:small "(Report): ") ; A1
          (link s "https://zenodo.org/record/4028830"
                "Unusual Features of the SARS-CoV-2 Genome Suggesting Sophisticated Laboratory Modification Rather Than Natural Evolution and Delineation of Its Probable Synthetic Route")
          (:small "Zenodo")
          (:small " {20200914A1}"))
     ;; 2020.10.8
     (:li (:small "2020.10.08")
          "Article" (:small "(Report): ") ; A1
          (link s "https://zenodo.org/record/4073131"
                "SARS-CoV-2 Is an Unrestricted Bioweapon:
A Truth Revealed through Uncovering a Large-Scale, Organized Scientific Fraud")
          (:small "Zenodo")
          (:small " {20201008A1}")
          (:ul (:li (:small "2020.10.08")
                    "Video: "           ; V1
                    (link s "https://youtu.be/VAKlS2oM9EU"
                          "10/8/2020 路德时评（路博艾冠康胡谈）")
                    (:small "Youtube:路德社LUDE Media")
                    (:small " {20201008V1 20201008A1}")
                    (:q (:pre "
闫丽梦博士首次用中文解释第二份报告的来龙去脉,揭露中共病毒的超限战生物武器的本质！")))))
     ;; 2020.11.21
     (:li (:small "2020.11.21")
          "Article" (:small "(Report): ") ; A1
          (link s "https://zenodo.org/record/4283480"
                "CNN Used Lies and Misinformation to Muddle the Water on the Origin of SARS-CoV-2")
          (:small "Zenodo")
          (:small " {20201121A1}"))
     ;; 2021.1.19
     (:li (:small "2021.01.19")
          "Article" (:small "(Report): ") ; A1
          (link s "https://zenodo.org/record/4448499"
                "Call for the WHO Team to Investigate the Pangolin Coronaviruses and the RmYN02 Bat Coronavirus")
          (:small "Zenodo")
          (:small " {20210119A1}"))
     ;; 2021.1.29
     (:li (:small "2021.01.29")
          "Article" (:small "(Report): ") ; A1
          (link s "https://zenodo.org/record/4477081"
                "A Bayesian analysis concludes beyond a reasonable doubt that SARS-CoV-2 is not a natural zoonosis but instead is laboratory derived")
          (:small "Zenodo")
          (:small " {20210129A1}"))
     ;; 2021.2.9
     (:li (:small "2021.02.09")
          "Video: "                     ; V1
          (link s "https://youtu.be/UmoUdW5r5fU"
                "2/9/2021 路德时评（路博艾冠谈嘉宾闫博士）")
          (:small "Youtube:路德社LUDE Media")
          (:small " {20210209V1}")
          (:q (:pre "
川普弹劾案参议院通过不违宪投票；
美国蓬佩澳以及白宫对中共联合世卫的溯源报告纷纷否定意味着什么？
军事科学院出版的教材揭露一切真相！"))
          (:ul
           (:li "Book: "
                "非典非自然起源和人制人新种病毒基因武器"
                (:small "主编: 徐德忠 李锋 出版: 军事医学科学出版社 2015.8"))
           (:li (:small "2021.02.10")
                "Video: "               ; V1
                (link s "https://youtu.be/a4oIAEQveOg"
                      "2/10/2021路德时评（路安墨谈）")
                (:small "Youtube:路德社LUDE Media")
                (:small " {20210210V1 20210209V1}")
                (:q (:pre "
世卫组织顾问揭露世卫所谓调查内幕；
再次深入解读2015年出版中共军事科学院出版的教材了第2期；")))
           (:li (:small "2021.02.10")
                "Video: "               ; V2
                (link s "https://youtu.be/V10SKiS1vpc"
                      "2/10/2021路德时评（路博艾冠谈）")
                (:small "Youtube:路德社LUDE Media")
                (:small " {20210210V2 20210209V1}")
                (:q (:pre "
拜登和习近平最快今晚通电话会勾兑哪些？
继续深入挖中共军事科学院教材的内容揭示众多真相（第三期）；")))))
     ;; 
     (:li "WHO 武汉之旅")
     ;; 2021.2.10
     (:li (:small "2021.02.10")
          "Article: "                   ; A1
          (link s "https://thenationalpulse.com/exclusive/who-investigators-ccp-covid-ties/"
                "CONFLICT OF INTEREST: WHO’s COVID Investigator Is Recipient Of Chinese Communist Cash, Worked With Wuhan Lab For 18 Years.")
          (:small "The National Pulse.")
          (:small " {20210210A1}"))
     ;; 2021.2.12
     (:li (:small "2021.02.12")
          "Article: "                   ; A1
          (link s "https://mediamanipulation.org/case-studies/cloaked-science-yan-reports"
                "CLOAKED SCIENCE: THE YAN REPORTS")
          (:small "The Media Manipulation Case Book")
          (:small " {20210212A1}")
          ;; 2021.2.13
          (:ul
           (:li (:small "2021.02.13")
                "Article: "             ; A1
                (link s "https://www.washingtonpost.com/technology/2021/02/12/china-covid-misinformation-li-meng-yan/"
                      "Scientists said claims about China creating the coronavirus were misleading. They went viral anyway.")
                (:small "The Washington Post")
                (:small " {20210213A1 20210212A1}"))
           (:li (:small "2021.02.13")
                "Video: "               ; V1
                (link s "https://youtu.be/Bp-zly4svfk"
                      "2/12/2021 路德时评（路博冠康胡谈嘉宾闫博士）")
                (:small "Youtube: 路德社LUDE Media")
                (:small " {20210213V1 20210212A1}")
                (:q (:pre "怎么看同一天哈佛出报道攻击闫博士，华盛顿邮报出报道替闫博士说话？"))
                (:ul (:li (:small "2021.02.13")
                          "Article" (:small "(中文简述): ") ; A3
                          (link s "https://gnews.org/zh-hans/904991/"
                                "《路德时评》连线闫博士回击哈佛报告，及解读《华盛顿邮报》头版报道闫博士")
                          (:small "GNEWS")
                          (:small " {20210213A3 20210213V1}"))))
           (:li (:small "2021.02.13")
                "Article: "             ; A2
                (link s "https://thenationalpulse.com/exclusive/harvard-shorenstein-center-ccp-ties/"
                      "EXC: Harvard Center Attacking COVID Lab Theory Has Extensive Financial And Personnel Links With The Chinese Communist Party.")
                (:small "The National Pulse.")
                (:small " {20210213A2 20210212A1}")
                (:ul (:li (:small "2021.02.16")
                          "Article" (:small "(中文翻译): ") ; A1
                          (link s "https://gnews.org/zh-hans/909498/"
                                "探究哈佛大学中心与中共的渊源")
                          (:small "GNEWS")
                          (:small " {20210216A1 20210213A2}"))))))
     ;; 2021.2.14
     (:li (:small "2021.02.14")
          "Video: "                     ; V1
          (link s "https://youtu.be/Bp-zly4svfk"
                "2/14/2021路德时评（路安墨谈）")
          (:small "Youtube: 路德社LUDE Media")
          (:small " {20210214V1 20210212A1 20210213A2}")
          (:q (:pre "
攻击闫博士的哈佛该研究中心被美媒曝光就是中共资助在美大发酵，哈佛该中心彻底翻车！
世卫谭德塞首次发声不排除病毒起源任何假设意味着什么？")))
     ;; 2021.2.15
     (:li (:small "2021.02.15")
          "Article: "                   ; A1
          (link s "https://thenationalpulse.com/news/exc-who-covid-investigator-is-chinese-cdc-advisor-who-accepted-ccp-research-grants/"
                "EXC: WHO COVID ‘Investigator’ Is Chinese CDC Advisor Who Accepted CCP Research Grants.")
          (:small "The National Pulse.")
          (:small " {20210215A1}"))
     ;; 2021.2.16
     
     (:li (:small "2021.02.16")
          "Article: "                   ; A1
          (link s "https://cz.citymedia.network/prague/features/czech-cardinal-calls-coronavirus-chinese-biological-weapon/"
                "Czech cardinal calls coronavirus “Chinese biological weapon”")
          (:small "CityMedia : PragueLife! Magazine")
          (:small " {20210216A1 20210216A2}")
          (:q (:pre "
Dominik Duka, cardinal at the Roman Catholic Church and the 36th Arch Bishop of Prague, believes coronavirus is a biological weapon and that the military knows about it. "))
          (:ul (:li (:small "2021.02.19")
                    "Article: " (:small "(中文简述): ") ; A1
                    (link s "https://gnews.org/zh-hans/917024/"
                          "捷克红衣主教称中共病毒为“中共生物武器”")
                    (:small "GNEWS")
                    (:small " {20210219A1 20210216A1}"))
               (:li (:small "2021.02.16")
                    "Article: " (:small "(捷克语): ") ; A2
                    (link s "https://cnn.iprima.cz/duka-koronavirus-je-cinska-biologicka-zbran-vojaci-o-tom-vedi-ale-mlci-19260?utm_source=www.seznam.cz&utm_medium=sekce-z-internetu#dop_ab_variant=520010&dop_source_zone_name=hpfeed.sznhp.box&dop_req_id=iO74E7p52JV-202102161031y"
                          "Duka: Koronavirus je čínská biologická zbraň. Vojáci o tom vědí, ale nic neřeknou")
                    (:small "CNN Prima News : Czech")
                    (:small " {20210216A2}"))
               (:li (:small "2021.02.18")
                    "Article: " (:small "(中共回应): ") ; A1
                    (:small " {20210218A1 20210216A2}")
                    (:ul (:li (link s "https://www.globaltimes.cn/page/202102/1215871.shtml"
                                    "Czech Cardinal Dominik Duka’s ‘Chinese biological weapon’ remarks groundless slander: embassy")
                              (:small "Global Times"))
                         (:li 
                          (link s "https://world.huanqiu.com/article/41ykMcBTpZW"
                                "捷克主教声称新冠是中国的“生物武器”，我使馆：立即纠正错误！")
                          (:small "环球网"))))))
     ;; 2021.2.19
     
     (:li (:small "2021.02.19")
          "Article: "                   ; A2
          (link s "https://gnews.org/zh-hans/917482/"
                "德国汉堡大学：中共病毒来自武汉病毒研究所实验室！")
          (:small "GNEWS")
          (:small " {20210219A2 20210218A2}")
          (:ul (:li (:small "2021.02.18")
                    "Article: " (:small "(德国汉堡大学原文 德文): ")
                    (link s "https://www.uni-hamburg.de/newsroom/presse/2021/pm8.html"
                          "Studie zum Ursprung der Coronavirus-Pandemie veröffentlicht")
                    (:small "Universität Hamburg")
                    (:small " {20210218A2 20210215A2}"))
               (:li (:small "2021.02.15")
                    "Article" (:small "(Report): ") ; A2
                    (link s "https://www.researchgate.net/publication/349302406_Studie_zum_Ursprung_der_Coronavirus-Pandemie"
                          "Studie zum Ursprung der Coronavirus-Pandemie")
                    (:small "ResearchGate")
                    (:small " {20210215A2}")
                    (:ul (:li (:small "2021.02.21")
                              "Article: " (:small "(中文翻译): ")
                              (:small " {20210221A1 20210215A2}")
                              (:ul (:li (link s "https://gnews.org/zh-hans/924152/"
                                              "德国汉堡大学罗兰-维森丹格教授：冠状病毒大流行的起源研究（中文译文）第一部分")
                                        (:small "GNEWS")
                                        (:small "2021.02.21"))
                                   (:li (link s "https://www.gnews.org/zh-hans/927337/"
                                              "德国汉堡大学罗兰-维森丹格教授：冠状病毒大流行的起源研究（中文译文）第二部分")
                                        (:small "GNEWS")
                                        (:small "2021.02.22"))))))))
     ;; 2021.2.20
     (:li (:small "2021.02.20")
          "Video: " (:small "(): ")     ; V1
          (link s "https://youtu.be/-HucSkjWxjs"
                "2/20/2021路德时评（路博艾冠谈）")
          (:small "Youtube: 路德社LUDE Media")
          (:small " {20210220V1 20210219A3 20210220A2 20210220T1}")
          (:q (:pre "
德国最大报纸图片报关于病毒来源让中共必须回答五个问题；
中共外交部立马表明严正立场回应；"))
          (:ul (:li (:small "2021.02.20")
                    "Article: " (:small "(路德社节目简述): ") ; A1
                    (link s "https://gnews.org/zh-hans/923455/"
                          "《路德时评》重磅解读德国最大报纸质问中共五个致命问题，及再爆中共长年从事中共病毒研究铁证")
                    (:small "GNEWS")
                    (:small " {20210220A1 20210220V1}"))
               (:li (:small "2021.02.19")
                    "Article: " (:small "(德文 德国图片报): ") ; A3
                    (link s "https://www.bild.de/politik/ausland/politik-ausland/herkunft-von-corona-diese-fuenf-fragen-muss-china-jetzt-beantworten-75476194.bild.html#fromWall"
                          "Diese fünf Fragen MUSS China jetzt beantworten!")
                    (:small "Bild")
                    (:small " {20210219A3}")
                    (:q (:pre "
Frage1 : Geben Sie Zu, dass das Corona-Virus durch einen Labor-Unfall in die Welt kam? 您同意新冠病毒是从实验室传到世界上的这种说法吗?
Frige2 : Warum haben Sie die Welt nicht früher gewarnt? 您为什么没有早一点警告这个世界?
Frige3 : Warum experimentierte China überhaupt mit Corona-Viren? 为什么中国要试验新冠病毒?
Frige4 : Wann lassen Sie unabhängige Experten in das Labor in Wuhan? 您觉得应该什么时候让外界专家进驻武汉?
Frige5 : Wie will China die Welt für Corona entschädigen? 中国应该怎么补偿这个世界?")))
               (:li (:small "2021.02.20")
                    "Article: " (:small "(中共回应): ") ; A2
                    (link s "http://de.china-embassy.org/chn/sgyw/t1855406.htm"
                          "驻德国使馆就德《图片报》再次散布炒作新冠病毒来源等阴谋论表明我严正立场")
                    (:small "中华人民共和国驻德意志联邦共和国大使馆")
                    (:small " {20210220A2 20210219A3}")
                    (:q (:pre "
...
《图片报》引用的所谓“报告”并非严谨科学的研究报告，甫一发布即受到德学术界、媒体和民众广泛质疑和批评。

武汉病毒研究所P4实验室具有严格的防护设施和措施。在2019年12月30日接收新冠肺炎患者的首批检测试样前，该所完全没有接触过、研究过或者保存过新冠病毒。

世卫组织派出国际专家组于2021年1月至2月在武汉与中方专家组成联合专家组，共同开展全球溯源中国部分工作。联合专家组对新冠病毒从自然宿主直接传播和通过冷链食品、中间宿主、实验室等四种引入人类途径的可能性进行了科学评估，认为新冠病毒“比较可能”经中间宿主引入人类，也“可能”直接传播或者通过冷链食品引入人类，“极不可能”通过实验室引入人类。

在已经被世界上几乎所有顶级科学家和疾控专家公开否定的情况下，该报仍热衷于散布所谓的“武汉病毒所泄露病毒”等谣言，并在此基础上煞有其事、厚颜无耻地提出所谓“中国应回答的五个问题”，实在令人不齿。
...")))
               (:li "项目: " "重要病毒跨种间感染与传播致病的分子机制研究"
                    (:small "中共国CDC负责人高福 2011年申请的基金标书")
                    (:small " {20110101X3823589705}" )
                    (:ul (:li (:small "2021.02.20")
                              "Twitter: " (:small "(含标书图片): ") ; T1
                              (link s "https://twitter.com/jsdfposjpqyuee1/status/1363237028712747008?s=20")
                              (:small "Twitter: 火来2号 @jsdfposjpqyuee1")
                              (:small " {20210220T1 20110101X3823589705}")
                              (:q (:pre "
@DrLiMengYAN1
 
高福的基金标书2011CB504700，石正丽的研究获得这个基金的支持。研究内容包括（不限于）
1 对病毒目的基因进行定点突变
2 获得目的重组病毒
3 确定影响病毒致病性和传播性的关键基因位点
")))
                         (:li (:small "2021.02.07")
                              "Article: " (:small "(含标书内容): ") ; T1
                              (link s "https://gnews.org/zh-hans/935149/"
                                    "中共用国家基金资助顶级科学家制造跨种间传播，高传染性、高致病性的新型病毒")
                              (:small "GNEWS")
                              (:small " {20210227A3823589593 20110101X3823589705}"))))))
     ;; 2021.2.22
     (:li (:small "2021.02.22")
          "Video: "                     ; V1
          (link s "https://www.cbsnews.com/video/former-deputy-national-security-adviser-matt-pottinger-on-face-the-nation/"
                "Former deputy national security adviser Matt Pottinger on \"Face the Nation\"")
          (:small "CBS News")
          (:small " {20210222V1}"))
     ;; 2021.2.23
     (:li (:small "2021.02.23")
          "Article: "                   ; A1
          (link s "https://www.wsj.com/articles/chinas-reckless-labs-put-the-world-at-risk-11614102828"
                "China’s Reckless Labs Put the World at Risk")
          (:small "The Wall Street Journal")
          (:small " {20210223A1}")
          (:q (:pre "
Beijing is obsessed with viruses, but not biosafety. We are paying a high price for its lapses."))
          (:ul (:li (:small "2021.02.23")
                    "Article: " (:small "(中文翻译): ") ; A2
                    (link s "https://gnews.org/zh-hans/929695/"
                          "迈克·蓬佩奥发新闻 中共病毒来自“武毒所”")
                    (:small "GNEWS")
                    (:small " {20210223A2 20210223A1 }"))
               (:li (:small "2021.02.23")
                    "Video: "           ; V1
                    (link s "https://youtu.be/a1ST79I19LE"
                          "2/23/2021路德时评（路博艾冠谈）")
                    (:small "Youtube: 路德社LUDE Media")
                    (:small " {20210223V1 20210223A1 }")
                    (:q (:pre "
华尔街日报刊登一篇蓬佩澳和余茂春先生的重磅文章，暗示的很多情报信息和内容与闫博士报告相吻合；")))))
     (:li (:small "2021.02.23")
          "Article: " 
          (link s "https://www.washingtontimes.com/news/2021/feb/23/facebooks-false-fact-check-protected-a-viable-sour/"
                "Facebook's false fact check protected a viable source of COVID-19: Wuhan Institute of Virology")
          (:small "The Washington Times")
          (:small " {20210223A3823590255}" )
          (:ul (:li (:small "2021.02.26")
                    "Article: " (:small "(中文翻译): ")
                    (link s "https://gnews.org/zh-hans/934228/"
                          "比尔·戈茨：脸书的虚假事实检查保护了武汉病毒研究")
                    (:small "GNEWS")
                    (:small " {20210226A3823590382 20210223A3823590255}" ))))
     (:li (:small "2021.02.23")
          "Article: " 
          (link s "https://www.commdiginews.com/politics-2/hydroxychloroquine-approved-preventative-treatment-covid-19-128426/"
                "Hydroxychloroquine now approved as a preventative treatment for COVID-19 (Update)")
          (:small "Communities Digital News")
          (:small " {20210227A3823591004}" )
          (:ul (:li (:small "2021.02.27")
                    "Article: " (:small "(中文翻译): ")
                    (link s "https://gnews.org/zh-hans/937012/"
                          "羟氯喹获批成为COVID-19的预防治疗方案")
                    (:small "GNEWS")
                    (:small " {20210223A3823591136 20210227A3823591004}"))))
     (virus-time-line-202103 s))))

(defparameter *news-list* nil)

(defun news (&key id rid time type title (link "") source quote child)
  (push
   (list :time time
         :type type
         :title title
         :link link
         :source source
         :id id
         :rid rid
         :quote quote
         :child child)
   *news-list*)
  nil)

(defun text-news ()
  '(news
    :time ""
    :type ""
    :title nil
    :link ""
    :source ""
    :id (gen-id)
    :rid (list)
    :quote ""
    :child (list )))


(defun news-to-html (stream)
  (loop for news in (reverse *news-list*)
        do (with-html-output (s stream :indent 2)
             (:li :class "news"
                  (:small :class "news-time" (str (getf news :time)) " ")
                  ;; TYPE ():
                  ;; Article, Video, Getter, Tweet, ...
                  (:small :class "news-type" (str (getf news :type)) ": ")
                  (:span :class "news-title" (str (link s (getf news :link)
                                                        (getf news :title)))
                         (:small :class "news-source" (str (getf news :source))))
                  (:small :class "news-id"
                          (str (format nil " {~a | ~{~a ~}} "
                                       ;; (remove-if (lambda (x) (char= #\. x)) (getf news :time))
                                       (getf news :id)
                                       (getf news :rid)
                                       )))
                  (if (getf news :quote)
                      (htm (:q :class "news-q" (:pre (str (getf news :quote))))))))))

;; (format nil "{~{~a ~}}" (list 1 2 3 4 5))

(defun virus-time-line-202103 (stream)
  (with-html-output (s stream :indent 2)
    (:li (:small "2021.03.01")
         "Article: " 
         (link s "https://www.judicialwatch.org/press-releases/emails-who-terms/?utm_source=twitter&utm_medium=social&utm_campaign=press_release"
               "Judicial Watch: New Emails Detail WHO/NIH Accommodations to Chinese Confidentiality ‘Terms’")
         (:small "Judicial Watch")
         (:small " {20210301A3823764202}"))
    (:li (:small "2021.03.01")
         "Article: " 
         (link s "https://www.thegatewaypundit.com/2021/03/exclusive-new-evidence-shows-u-s-government-american-scientific-establishment-involved-cover-covid-19s-origin/"
               "EXCLUSIVE: New Evidence Shows U.S. Government and the American Scientific Establishment Involved in Cover Up of COVID-19’s Origin")
         (:small "The Gateway Pundit")
         (:small " {20210301A3823764583}")
         (:ul (:li (:small "2021.03.05" " " "Article (中文):" )
                   (link s "https://gnews.org/zh-hans/952285/"
                         "多方机构参与了对COVID-19起源的掩盖")
                   (:small "GNEWS")
                   (:small " {202103053824112393 20210301A3823764583}"))
              (:li (:small "2021.03.02" " " "Article: ")
                   (link s "https://www.thegatewaypundit.com/2021/03/u-s-scientific-establishment-conducted-de-facto-covid-19-briefings-chinese-military-may-2020/"
                         "The U.S. Scientific Establishment Conducted De Facto COVID-19 Briefings for the Chinese Military in May 2020")
                   (:small "The Gateway Pundit")
                   (:small " {202103023824283275 20210301A3823764583}")
                   (:ul (:li (:small "2021.03.06" " " "Article (中文翻译):")
                             (link s "https://gnews.org/zh-hans/954326/"
                                   "与军方有关联的中方学者参与中美疫情电话交流会")
                             (:small "GNEWS")
                             (:small " {202103063824283352 202103023824283275}"))))
              (:li (:small "2021.03.04")
                   "Article: "
                   (link s "https://www.thegatewaypundit.com/2021/03/overwhelming-evidence-origin-covid-19-pandemic-covered-us-government-officials-us-scientific-authorities-chinese-counterparts/"
                         "The Overwhelming Evidence of the Origin of the COVID-19 Pandemic Was Covered Up by US Government Officials, US Scientific Authorities and Their Chinese Counterparts")
                   (:small "The Gateway Pundit")
                   (:small " {20210304A3824096896 20210301A3823764583}")
                   (:ul (:li (:small "2021.03.07")
                             "Article " (:small "(中文翻译):")
                             (link s "https://gnews.org/zh-hans/955995/"
                                   "美国政府官员，美国科学机构和中共国有关部门掩盖了COVID-19大流行病起源的大量证据")
                             (:small "GNEWS")
                             (:small " {20210307@3824097025 20210304A3824096896}"))))))
    (:li (:small "2021.03.02")
         "Article: " 
         (link s "https://www.reuters.com/article/us-health-coronavirus-russia-poll/over-60-of-russians-dont-want-sputnik-v-vaccine-see-coronavirus-as-biological-weapon-reuters-poll-idUSKBN2AT2XK"
               "Over 60% of Russians don't want Sputnik V vaccine, see coronavirus as biological weapon: Reuters poll")
         (:small "Reuters")
         (:small " {20210302A3823764715}")
         (:ul (:li (:small "2021.03.03")
                   "Article " (:small "(中文翻译):") 
                   (link s "https://gnews.org/zh-hans/944760/"
                         "超过60％的俄罗斯人认为冠状病毒就是人造的生物武器")
                   (:small "GNEWS")
                   (:small " {20210303A3823765831 20210302A3823764715}"))))
    (:li (:small "2021.03.02")
         "Video: " 
         (link s "https://youtu.be/hl-v5jp9vxQ"
               "3/1/2021路德时评（路博艾冠谈嘉宾闫丽梦博士）")
         (:small "Youtube: 路德社LUDE Media")
         (:small " {20210301V3823765281 20210302A3823764715 20210301A3823764583}")
         (:q (:pre "
蓬佩奥再谈全世界必须与中共脱钩；美议员要求拜登指定中共为跨国犯罪组织？美媒体揭露攻击闫博士的都是受中共指使；布林肯再次对中共强硬；")))
    (:li (:small "2021.03.02")
         "Video: " 
         (link s "https://rumble.com/veanff-dr.-navarro-fears-the-ccp-virus-is-a-bioweapon.html"
               "Dr. Navarro fears the CCP virus is a bioweapon")
         (:small "Rumble: Bannons War Room")
         (:small " {20210302V3823765393}")
         (:ul (:li (:small "2021.03.03")
                   "Tweet: " 
                   (link s "https://twitter.com/RealPNavarro/status/1366844639974719493?s=20")
                   (:small "Twitter: Peter Navarro @RealPNavarro")
                   (:small " {20210303@3823767219 20210302V3823765393}")
                   (:q (:pre "
The #CCPVirus could be a bioweapon - mutations of the virus upsets the whole concept of herd immunity. This is exactly why the Chinese Communist Party needs to be investigated to figure out what exactly happened. Gain of function research? Bioweapon?
https://rumble.com/veanff-dr.-navarro-fears-the-ccp-virus-is-a-bioweapon.html")))))
    (:li (:small "2021.03.02")
         "Video: " 
         (link s "https://youtu.be/1YCVPv_07fg"
               "3/2/2021路德时评（路安墨谈）")
         (:small "Youtube: 路德社LUDE Media")
         (:small " {20210302V3823767880}")
         (:q (:pre "
果不其然，闫博士前上司Malik被出来回归港大巴斯德研究所任荣誉所长；纳瓦罗评论拜登政府是否会延续川普灭共政策？"))
         (:ul (:li (:small "2021.03.03")
                   "Article " (:small "(简述):")
                   (link s "https://gnews.org/zh-hans/943369/"
                         "《路德时评》重磅解读Malik就任港大巴斯德研究中心名誉所长，及大灭共时代全面加速")
                   (:small "GNEWS")
                   (:small " {20210303A3823767991 20210302V3823767880}"))))
    
    (:li (:small "2021.03.02" " " "Article:")
         (link s "https://www.thesun.co.uk/news/14147270/wuhan-lab-database-hidden-china-covid-smoking-gun/amp/"
               "WU-DUNNIT Wuhan lab’s mysterious dark database hidden by China could be Covid cover-up smoking gun, study claims")
         (:small "The Sun")
         (:small " {202103023-824113406}")
         (:ul (:li (:small "2021.03.04" " " "Article (中文):")
                   (link s "https://gnews.org/zh-hans/949070/"
                         "研究爆出武汉实验室刻意隐瞒中共病毒关键数据")
                   (:small "GNEWS")
                   (:small " {20210304-3824113519 202103023-824113406}"))))
    (:li (:small "2021.03.04")
         (:small "Article:")
         (link s "https://www.nytimes.com/interactive/2021/03/04/us/covid-origins-letter.html"
               "Letter Seeking International Inquiry Into Origins of the Coronavirus")
         (:small "The New York Times")
         (:small " {20210304A3824111025 20210304-3824111190}")
         (:q (:pre "Some scientists are calling for an investigation independent of that under way by a team of scientists and the World Health Organization into the source of the novel coronavirus outbreak in China."))
         (:ul (:li (:small "2021.03.04" " PDF (Open Letter):")
                   (link s "https://int.nyt.com/data/documenttools/covid-origins-letter/5c9743168205f926/full.pdf"
                         "Call for a Full and Unrestricted International Forensic Investigation into the Origins of COVID-19")
                   (:small " {20210304-3824111190}"))
              (:li (:small "2021.03.07" " " "Article (公开信 中文翻译): ")
                   (link s "https://gnews.org/zh-hans/954606/"
                         "呼吁对COVID-19的起源进行全面和无限制的国际法医调查的公开信")
                   (:small "GNEWS")
                   (:small " {20210307-3824111509 20210304-3824111190}"))))

    
    (:li (:small "2021.03.07" " " "Article: ")
         (link s "https://nypost.com/2021/03/07/another-failed-who-whitewash-of-chinas-covid-guilt/"
               "Another failed WHO whitewash of China’s COVID guilt")
         (:small "New York Post")
         (:small " {202103073824282577}")
         (:ul (:li (:small "2021.02.09" " " "Article: ")
                   (link s "https://nypost.com/2021/02/09/whos-latest-china-virus-whitewash/"
                         "WHO’s latest China-virus whitewash")
                   (:small "New York Post")
                   (:small " {202102093824282663}"))))
    (:li (:small "2021.03.06" " " "Video: ")
         (link s "https://pandemic.warroom.org/2021/03/06/dr-li-meng-yan-covid-19-is-an-unrestricted-bioweapon/"
               "Dr. Li Meng Yan: Covid-19 is an ‘Unrestricted’ Bioweapon")
         (:small "War Room Pandemic")
         (:small " {202103063824282939}"))
    (:li (:small "2021.03.08" " " "Article: ")
         (link s "https://www.politico.com/news/magazine/2021/03/08/josh-rogin-chaos-under-heaven-wuhan-lab-book-excerpt-474322"
               "In 2018, Diplomats Warned of Risky Coronavirus Experiments in a Wuhan Lab. No One Listened.")
         (:small "Politico")
         (:small " {202103083824283563}")
         (:ul (:li (:small "2021.03.09" " " "Article (含中文翻译):")
                   (link s "https://gnews.org/zh-hans/960753/"
                         "【以毒灭共】闫丽梦“女神节”的两则推特")
                   (:small "GNEWS")
                   (:small " {202103093824283689 202103083824283563}"))))
    (:li (:small "2021.03.10" " " "Article:")
         (link s "https://www.washingtonexaminer.com/news/biden-team-gives-nod-trump-state-department-fact-sheet-wuhan-lab?_amp=true"
               "Biden team gives nod to Trump State Department fact sheet on Wuhan lab")
         (:small "Washington Examiner")
         (:small " {202103103824695914}"))

    (:li (:small "2021.03.12" " " "Tweet:")
         (link s "https://twitter.com/mikepompeo/status/1370076192703922177?s=20")
         (:small "Twitter: Mike Pompeo @mikepompeo")
         (:small " {202103123824696052}")
         (:q (:pre "
The CCP knows where this virus came from and they don’t want us to know the truth. They must be held accountable — the American people are counting on it.")))

    (:li (:small "2021.03.13" " " "Article:")
         (link s "https://www.foxnews.com/world/top-state-official-coronavirus-bioweapon-accident"
               "Former top State Dept investigator says COVID-19 outbreak may have resulted from bioweapons research accident")
         (:small "Fox News")
         (:small " {202103133824696667}")
         (:ul (:li (:small "2021.03.14" " " "Article (中文翻译):")
                   (link s "https://gnews.org/zh-hans/973871/"
                         "前美国政府官员：中共病毒爆发来自实验室生物武器研究")
                   (:small "GNEWS")
                   (:small " {202103143824696791 202103133824696667}"))))

    (:li (:small "2021.03.12" " " "Article:")
         (link s "https://www.washingtonexaminer.com/news/who-origins-investigator-defends-wuhan-lab-blames-lack-access-anti-china-political-rhetoric"
               "WHO origins investigator defends Wuhan lab and blames lack of access on ‘anti-China political rhetoric’")
         (:small "Washington Examiner")
         (:small " {202103123824697114}")
         (:ul (:li (:small "2021.03.12" " " "Article (含中文翻译):")
                   (link s ""
                         "彼得·达扎克博士的无耻的行为和中共一模一样")
                   (:small "GNEWS")
                   (:small " {202103123824697428 202103123824697114}"))))

    (:li (:small "2021.03.09" " " "Article:")
         (link s "https://www.wsj.com/articles/wuhan-lab-theory-a-dark-cloud-on-china-11615332235"
               "Wuhan Lab Theory a Dark Cloud on China")
         (:small "The Wall Street Journal")
         (:small " {202103093824697357}"))

    (:li (:small "2021.03.13" " " "Article:")
         (link s "https://thenationalpulse.com/news/daszak-slams-bannon-reveals-database-lies/"
               "CORRUPT: WHO Inveastigator On CCP Payroll Blasts Bannon & Media For Asking Inconvenient Questions… Admits He Refused To Look At Wuhan Lab Data.")
         (:small "The National Pulse.")
         (:small " {202103133824697594}"))

    ;; T
    
    (:li :class "news"
         (:small :class "news-time"
                 "2021.03.17" " ")
         (:small :class "news-type"
                 "Article: ")
         (:span :class "news-title"
                (link s
                      "https://www.wsj.com/articles/who-china-hunt-covid-origins-11616004512?mod=e2tw"
                      "How the WHO’s Hunt for Covid’s Origins Stumbled in China")
                (:small :class "news-source"
                        "The Wall Street Journal"))
         (:small :class "news-id"
                 " {202103173825405632} "))
    
    ;; 
    
    (news-to-html s)))

(news
 :time "2021.03.19"
 :type "Article"
 :title "EXCLUSIVE: Pompeo casts doubt on WHO-China coronavirus origins inquiry and defends Wuhan lab intelligence"
 :link "https://www.washingtonexaminer.com/news/pompeo-casts-doubt-who-china-covid-origins-inquiry"
 :source "Washington Examiner. "
 :id 3825490666
 :child (list 3825491637))
    
(news
 :time "2021.03.23"
 :type "Article (中文)"
 :title "蓬佩奥质疑世卫组织中共病毒起源调查"
 :link "https://gnews.org/zh-hans/1004207/"
 :source "GNEWS"
 :id 3825491637
 :rid (list 3825490666))
    
(news
 :time "2021.03.21"
 :type "Video"
 :title "Wuhan Institute of Virology 'highly probably' the source of COVID-19"
 :link "https://youtu.be/YBq-LV3Jm1M"
 :source "Youtube: Sky News Australia"
 :id 3825491465)
    
(news
 :time "2021.03.26"
 :type "Video"
 :title "Former CDC director believes virus came from lab in China"
 :link "https://www.cnn.com/videos/health/2021/03/26/sanjay-gupta-exclusive-robert-redfield-coronavirus-opinion-origin-sot-intv-newday-vpx.cnn"
 :source "CNN"
 :id 3826098803
 :child (list 3826098806))

(news
 :time "2021.03.26"
 :type "Article"
 :title "Ex-CDC Director Robert Redfield believes COVID-19 came from Wuhan lab"
 :link "https://nypost.com/2021/03/26/ex-cdc-director-believes-covid-19-came-from-wuhan-lab/?utm_campaign=SocialFlow&utm_source=NYPTwitter&utm_medium=SocialFlow"
 :source "New York Post"
 :id 3826098806
 :rid (list 3826098803))

(news
 :time "2021.03.27"
 :type "Article"
 :title "China’s deception over COVID-19’s origins gets more outrageous every day"
 :link "https://nypost.com/2021/03/27/chinas-deception-over-covid-origins-more-outrageous-every-day/"
 :source "New York Post"
 :id 3826099699
 :rid (list ))

(news
 :time "2021.03.30"
 :type "Report (PDF)"
 :title "WHO-convened global study of origins of SARS-CoV-2: China Part"
 :link "https://www.who.int/publications/i/item/who-convened-global-study-of-origins-of-sars-cov-2-china-part"
 :source "World Health Organization"
 :id 3826182484)

(news
 :time "2021.03.30"
 :type "Article"
 :title "Joint Statement on the WHO-Convened COVID-19 Origins Study"
 :link "https://www.state.gov/joint-statement-on-the-who-convened-covid-19-origins-study/"
 :source "U.S.DEPARTMENT of STATE"
 :id 3826182464
 :rid (list 3826182484))

(news
 :time "2021.03.30"
 :type "Tweet"
 :title nil
 :link "https://twitter.com/mikepompeo/status/1376885317232386050?s=20"
 :source "Twitter: Mike Pompeo @mikepompeo"
 :id 3826183717
 :rid (list 3826182484)
 :quote "
The WHO report is a sham continuation of the CCP-WHO disinformation campaign. It’s why I recommended we leave WHO. Dr. Tedros collaborated with Xi to hide human to human transmission at a CRITICAL juncture. WIV remains the most likely source of the virus — and WHO is complicit.")

(news
 :time "2021.03.31"
 :type "Report"
 :title "The Wuhan Laboratory Origin of SARS-CoV-2 and the Validity of the Yan Reports Are Further Proved by the Failure of Two Uninvited \"Peer Reviews\"" 
 :link "https://zenodo.org/record/4650821#.YGW-22QzaAT"
 :source "Zendo"
 :id 3826269674)
