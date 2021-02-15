(in-package :twb)

;; (defvar *news-topics* (make-hash-table :test 'equal))
;; (defun news-set-topic (topic value)
;;   (setf (gethash topic *news-topics*) value))
;; (defun news-get-topic (topic)
;;   (gethash topic *news-topics*))


(defparameter *news-topics* nil)
(defun news-add-topic (topic)
  (push topic *news-topics*))

(let ((show t))
  (defun news-topic (title time &rest content)
    (let ((id (format nil "collapse~a" (random 10000))))
      `(div (:class "topic card")
            (div (:class "card-header d-flex w-100 justify-content-between")
                 (button (:class ,(concat "btn btn-link" (if show
                                                             ""
                                                             " collapsed"))
                                 :type "button"
                                 :data-toggle "collapse"
                                 :data-target ,(concat "#" id))
                         (h2 () ,title))
                 (small () ,(format nil "更新时间: ~a" time)))
            (div (:class ,(concat "collapse"
                                  (if show
                                      (progn (setf show nil)
                                             " show")
                                      ""))
                         :id ,id
                         :data-parent "#topic-accordion")
                 (div (:class "card-body")
                      ,@content))))))


;; (defun news-to-topic (title time &rest content)
;;   (news-set-topic title (->html (apply #'news-topic title time content))))

(defun news-to-topic (title time &rest content)
  (news-add-topic (->html (apply #'news-topic title time content))))

(defun @ (link &optional title)
    (let ((tle (if title title link))) 
        `(a (:href ,link) ,tle)))

(defun u (&rest rest)
  `(ul () ,@rest))

(defun :- (&rest rest)
  `(li () ,@rest))

(defun news-index ()
  (->html
   (layout-template
    nil
    :title "News 新鲜事"
    :links `((link (:rel "stylesheet" :href "/testwebsite/css/bootstrap.min.css"))
             (link (:rel "stylesheet" :href "/testwebsite/css/font-awesome.min.css"))
             (link (:rel "stylesheet" :href "/testwebsite/css/style.css")))
    :head-rest `((style () "
.btn-link {color: black }
.btn-link:hover {text-decoration:none}
cite {
font-size: 88% }
q {
border-left: 5px rgb(210, 212, 212) solid;
display: block;
padding: 5px 10px 5px 10px;
text-align: justify;
}
q::before, q::before {
display: block;
content: \"\";
}
li pre {
display: inline;
margin: 0;
white-space: pre-wrap;
}
li q {
margin-left: 16px;
}

.zoom {      
-webkit-transition: all 0.35s ease-in-out;    
-moz-transition: all 0.35s ease-in-out;    
transition: all 0.35s ease-in-out;     
cursor: -webkit-zoom-in;      
cursor: -moz-zoom-in;      
cursor: zoom-in;  
}     
.zoom:hover,  
.zoom:active,   
.zoom:focus {
-ms-transform: scale(7);    
-moz-transform: scale(7);  
-webkit-transform: scale(7);  
-o-transform: scale(7);  
transform: scale(7);    
position:relative;      
z-index:100;  
}
"))
    :content
    `(,(site-header)
       (main (:class "content")
             ;; 
             (div (:class "accordion" :id "topic-accordion"
                          :style "font-size: 140%")
                  ;; ,@(loop for v being the hash-values of *news-topics*
                  ;;      collect v)
                  ,@(nreverse *news-topics*)))
       ,(site-footer))
    :scripts `((script (:src "/testwebsite/js/jquery-3.2.1.min.js"))
               (script (:src "https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
                             :integrity "sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
                             :crossorigin "anonymous"))))))

(defparameter *news-topics-guo* nil)

(push
 (u (:- (@ "/testwebsite/articles/2019/9/guo-news-201909.html" "2019.9 (-5 7-9 23-) ")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2019/8/guo-news-201908.html" "-2019.8.29")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2019/7/guo-news-201907.html" "2019.7.14-")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2019/6/guo-news-201906.html" "2019.6.-16")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2019/5/guo-news-201905.html" "2019.5")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2019/4/guo-news-201904.html" "2019.4")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2019/3/guo-news-201903.html" "2019.3")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2019/2/guo-news-201902.html" "2019.2")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2019/1/guo-news-201901.html" "2019.1")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2018/12/guo-news-201812.html" "2018.12")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2018/11/guo-news-201811.html" "2018.11")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2018/10/guo-news-201810.html" "2018.10")))
 *news-topics-guo*)

(news-to-topic
 "郭文贵"     ;; (twb::human-date (get-universal-time))
 "2020.01.31 16:27:23"
 (u (:- "信息源"
        (u (:- "GNews : " (@ "https://gnews.org/zh-hans/miles-guo/" "郭文贵"))
           ;; (:- "郭媒体 : " (@ "https://www.guo.media/milesguo" "@milesguo"))
           (:- "LiveStream : " (@ "https://livestream.com/accounts/27235681/events/8197481" "郭文贵中文直播"))
           (:- "Youtube : " (@ "https://www.youtube.com/channel/UCO3pO3ykAUybrjv3RBbXEHw/featured" "郭文贵"))
           (:- "Instagram : " (@ "https://www.instagram.com/guowengui/" "guowengui"))))
    (:- "郭七条"
        (u (:- "反对 以黑治国 以警治国 以贪反贪 以黑反贪")
           (:- "不反国家 不反民族 不反习主席")
           (:- '(span (:class "badge badge-secondary") "修改增加: ") "反对以假治国")))
    (:- "蓝金黄 3F美国计划")
    (:- "海航 王健之死")
    (:- "关注 香港 台湾 新疆 西藏")
    (:- "关注 疫情")
    (:- "法治基金"
        (u (:- `(cite () "RULE OF LAW FOUNDATION "
                      ,(@ "https://rolfoundation.org")))
           (:- `(cite () "RULE OF LAW SOCIETY "
                      ,(@ "https://rolsociety.org")))
           (:- `(cite () "法治基金常問問題 "
                      ,(@ "https://rolfoundation.org/faq-chinese.php")))))
    (apply #':- "主要内容跟踪" (nreverse *news-topics-guo*))))

(news-to-topic
 "中美" ;; (human-date (get-universal-time))
 "2018.12.04 20:10:20"
 (u (:- '(small () "2018.11.30-12.1")
        "G20 (2018 G20 Buenos Aires summit)")
    (:- '(small () "2018.11.14")
        (@ "https://www.washingtontimes.com/news/2018/nov/14/inside-the-ring-remove-chinese-missiles/"
           "Trump demands China remove missiles in the South China Sea")
        '(small () "The Washington Times")
        '(q () (pre () "
The Trump administration is demanding that China remove all advanced missiles deployed on disputed islands in the South China Sea, the first time such a demand has been made public.")))
    (:- '(small () "2018.11.9")
        (@ "https://youtu.be/g3rxjaOPQD4"
           "Economic Security as National Security: A Discussion with Dr. Peter Navarro")
        '(small () "Youtube"))
    (:- '(small () "2018.11.7")
        (@ "https://cn.wsj.com/articles/CN-BGH-20181105071808"
           "美国正式重启对伊制裁 中国入豁免名单")
        '(small () "华尔街日报")
        '(q  () (pre () "周一美国实施了对伊朗石油的禁令，同时对700多家伊朗银行、公司和个人进行了制裁，正式启动了其最大施压行动的第二阶段。但中国、印度、意大利、希腊、日本、韩国、台湾和土耳其得到豁免，可暂时继续进口伊朗原油。"))
        (u (:- '(pre () "(我: 我还以为要豁免中共犯下的一切罪行呢 😝)"))))
    (:- '(small () "2018.11.1")
        "Attorney General Jeff Sessions Announces New Initiative to Combat Chinese Economic Espionage"
        '(small () " -U.S. DOJ : ")
        (@ "https://www.youtube.com/watch?v=zHi1iTjQ_FQ&feature=youtu.be"
           "视频")
        " "
        (@ "https://www.justice.gov/opa/speech/attorney-general-jeff-sessions-announces-new-initiative-combat-chinese-economic-espionage"
           "文本")
        '(q () (pre () "
As the cases I’ve discussed have shown, Chinese economic espionage against the United States has been increasing—and it has been increasing rapidly.

We are here today to say: enough is enough.  We’re not going to take it anymore.

It is unacceptable.  It is time for China to join the community of lawful nations.  International trade has been good for China, but the cheating must stop. And we must have more law enforcement cooperation; China cannot be a safe haven for criminals who run to China when they are in trouble, never to be extradited. China must accept the repatriation of Chinese citizens who break U.S. immigration law and are awaiting return.
...
This Department of Justice—and the Trump administration—have already made our decision: we will not allow our sovereignty to be disrespected, our intellectual property to be stolen, or our people to be robbed of their hard-earned prosperity.  We want fair trade and good relationships based on honest dealing.  We will enforce our laws—and we will protect America’s national interests."))
        (u (:- `(cite () "中文参考: "
                      ,(@ "https://www.voachinese.com/a/chinese-criminal-20181101/4638912.html?utm_source=dlvr.it&utm_medium=twitter"
                          "针对中国经济间谍活动美司法部长宣布新行动")))))
    (:- '(small () "2018.10.26")
        (@ "https://www.state.gov/secretary/remarks/2018/10/286926.htm"
           "Interview With Hugh Hewitt of the Hugh Hewitt Show")
        (u (:- "中文参考: " (@ "https://www.voachinese.com/a/pompeo-china-2018-10-26/4631048.html"
                               "蓬佩奥：中国的每一个挑衅都会得到美国强有力的回应")
               '(small () "2018.10.27 VOA"))))
    (:- '(small () "2018.10.22")
        (@ "https://freebeacon.com/national-security/u-s-warships-transit-taiwan-strait/"
           "U.S. Warships Transit Taiwan Strait")
        '(p () (small () "Two Navy warships transited the Taiwan Strait on Monday in a show of force in Pentagon efforts to push back against China's expansive claims to control waters near the communist mainland.")))
    (:- '(small () "2018.10.12")
        (@ "https://freebeacon.com/national-security/bolton-warns-chinese-military-halt-dangerous-naval-encounters/"
           "Bolton Warns Chinese Military to Halt Dangerous Naval Encounters")
        '(p () (small () "White House National Security Adviser John Bolton says Navy rules allow response to threatening Chinese actions")))
    (:- '(small () "2018.10.11")
        "首次 中共国 情报官员 被引渡至 美国 公开受审"
        (u (:- "源自: "
               (@ "https://www.justice.gov/opa/pr/chinese-intelligence-officer-charged-economic-espionage-involving-theft-trade-secrets-leading"
                  "DOJ: Chinese Intelligence Officer Charged with Economic Espionage Involving Theft of Trade Secrets from Leading U.S. Aviation Companies"))
           (:- "中文参考: " (@ "https://www.bbc.com/zhongwen/simp/world-45819520"
                               "BBC: 涉嫌盗取美国航空业机密　中国籍男子面临“间谍”检控"))
           (:- '(pre () "美司法部: 以经济间谍罪起诉 涉嫌窃取美国航空和航天公司商业机密的 中国情报官员 Xu Yanjun"))
           (:- '(pre () "4.1 在比利时被捕"))
           (:- '(pre () "10.9 被引渡至美国"))
           (:- '(pre () "10.10 起诉书被正式公开"))))
    (:- '(small () "2018.10.8")
        "美国国务卿 蓬佩奥 访问中共国")
    (:- '(small () "2018.10.4")
        "美国副总统 彭斯 哈德逊研究所演讲"
        (u (:- "全文"
               (u (:- "英:" (@ "https://www.whitehouse.gov/briefings-statements/remarks-vice-president-pence-administrations-policy-toward-china/"
                               "Remarks by Vice President Pence on the Administration’s Policy Toward China"))
                  (:- "中:" (@ "https://www.voachinese.com/a/pence-speech-20181004/4600329.html"
                               "彭斯副总统有关美国政府中国政策讲话全文翻译"))))
           (:- "视频(中文同传):" (@ "https://youtu.be/i8DtP3PB-gc"
                                    "彭斯副总统有关美国政府中国政策讲话(中文同传)"))
           (:- "重点 (由于全文 基本上都可以说是重点 所以我只列出一些大意)"
               (u (:- "中共 对外"
                      (u (:- "前所未有的 使用各种手段 影响 美国制度和政策 来获利")
                         (:- "偷盗美国的技术 强迫美企技术转让 利用美国的技术壮大其军事力量")
                         (:- "违背承诺 将南海军事化 同时 侵犯美自由航行的舰只")
                         (:- "债务外交 通过烂贷 获取 经济和军事利益 (我: 最后都肥了各国盗国贼)")
                         (:- "威胁台湾")
                         (:- "干预美国中期选举 影响舆论")
                         (:- "要求某美国大公司公开反对美国关税政策 否则取消其营业执照")
                         (:- "要求合资公司 设立党支部 对决策进行影响 甚至否决")
                         (:- "影响 广播等媒体 记者 大学 研究机构 智库 好莱坞 等等 为其唱赞歌 或 消除负面报道"
                             '(q () (pre () "
说的就是 郭文贵先生去年在 哈德逊的演讲被取消
After you offered to host a speaker Beijing didn’t like, your website suffered a major cyberattack, originating from Shanghai. The Hudson Institute knows better than most that the Chinese Communist Party is trying to undermine academic freedom and the freedom of speech in America today.")))))
                  (:- "中共 对内"
                      (u (:- "人权问题恶化 压迫自己的人民")
                         (:- "成为监视型的国度 监视方法更具侵略性 且 是使用美国的技术做到的")
                         (:- "防火长城 阻碍信息自由交流")
                         (:- "信用评分 将严重的干预和限制人们的生活 (我: 这种超乎法律之上的系统 对于中共国这种国家 极易并滥用)"
                             '(q () (pre () "
And by 2020, China’s rulers aim to implement an Orwellian system premised on controlling virtually every facet of human life — the so-called “Social Credit Score.” In the words of that program’s official blueprint, it will “allow the trustworthy to roam everywhere under heaven, while making it hard for the discredited to take a single step.”")))
                         (:- "限制 宗教发展 下架圣经 烧十字架 打压西藏佛教徒 在新疆监禁百万伊斯兰教信众进行洗脑 (我: 中共打击一切它们不允许的信仰 更限制任何组织的发展 尤其是具有极大凝聚力的宗教)")))
                  (:- "美国 态度"
                      (u (:- "过去几十年 美国帮助中国发展壮大 并期许其走向自由文明 但现在 美国意识到 中共对 民主自由等等承诺 都是空谈")
                         (:- "通过相应行动做出了回应 并 寻求 公平 互惠 尊重主权 关系")
                         (:- "美国优先")
                         (:- "会继续奉行一个中国的政策 但相信台湾对民主的拥抱 为所有的中国人 提供了一条更好的道路 ")
                         (:- "并不希望中共国经济受损 而是希望其繁荣 但希望中共的贸易政策是 自由 互惠 公平  并且 不仅仅停留在嘴上")
                         (:- "应对外国媒体宣传 要求注册外国代理人")
                         (:- "让其停止强迫技术转让 保护美国企业的私人财产的利益")
                         (:- "简化国际开发和融资计划 为外国提供 更透明公正的另一个选择 而不用依赖中共国")
                         (:- "相信会看到 更多的 企业 学者 媒体 等 会在 价钱和价值 间做出更好的选择")
                         (:- "在中共真正改变 而不是打口炮 并对美国表示尊重之前 美国不会放弃或松懈 ")
                         (:- "平等对待"
                             '(q () (pre () "
The great Chinese storyteller Lu Xun often lamented that his country, and he wrote, “has either looked down at foreigners as brutes, or up to them as saints,” but never “as equals.” ")))
                         (:- "长远 (我: 只看自己 认为人不会死 故作死, 你看 要死了吧)"
                             '(q () (pre () "
“Men see only the present, but heaven sees the future.”")))))))))))

(news-to-topic
 "美国" ;; (human-date (get-universal-time))
 "2019.02.09 19:45:51"
 (u (:- '(small () "2019.2.7") "美国总统 川普 美国时间2月五日晚 在国会 发表 国情咨文演说"
        (u (:- `(cite ()
                      ,(@ "https://www.youtube.com/watch?v=fpf1IYU0poY"
                          "President Trump Delivers the State of the Union Address")
                      (small () "2019.2.5 Youtube : The White House")))
           (:- `(cite ()
                      ,(@ "https://www.youtube.com/watch?v=RwrnbSC32sw"
                          "美国总统特朗普国情咨文特别节目")
                      (small () "2019.2.5 Youtube : 美国之音 (中文同声传译)")))))
    (:- '(small () "2018.11.7") "Midterm elections 2018 美国中期选举"
        '(q () (pre () "
    结果      | Republican 共和党 | Democratic 民主党 |
Senate 参议院 |  Win:  51        |         43       |
House  众议院 |       193        |   Win: 219       |
")))
    (:- '(small () "2018.10.23")
        "德州大学基金 引领 新规则 将从被美国制裁的实体中撤资"
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=aCdDjXTrgTQ"
                           "Watch CNBC's full interview with Hayman Capital's Kyle Bass"))
           (u (:- `(pre () "中文跟译: " ,(@ "https://www.youtube.com/watch?v=sQ4Yrj6tISw"
                                            "啸天英语读报点评第21期 20181023--郭式隔山打牛亮招CNBC;同步翻译解读Kyle Bass（德州大学基金 UTIMCO)如何带头打击中共并隔空取钱-期限180天！")))))
        (u (:- "相关"
               (u (:- '(samll () "2018.10.23")
                      (@ "https://www.zerohedge.com/news/2018-10-23/kyle-bass-trump-has-strongest-negotiating-position-weve-ever-had-against-china"
                         "Kyle Bass: Trump Has \"Strongest Negotiating Position We've Ever Had\" Against China")
                      (u (:- "中文翻译: " (@ "https://littleantvoice.blogspot.com/2018/10/kyle-bass-trump-has-strongest.html?m=1"
                                             "翻译：凯尔巴斯：特朗普有和中国谈判的最强“筹 码”")))))
               (u (:- '(samll () "2018.10.23")
                      (@ "https://www.bloombergquint.com/markets/university-of-texas-to-impose-new-rules-as-iran-sanctions-loom#gs.cQuj904"
                         "University of Texas Endowment to Impose New Rules for Iran Ties")))))
        (u (:- "补充"
               (u (:- "Kyle Bass"))
               (u (:- "UTIMCO 德州大学基金")))))
    (:- '(small () "2018.10.19")
        (@ "https://www.dni.gov/index.php/newsroom/press-releases/item/1915-joint-statement-from-the-odni-doj-fbi-and-dhs-combating-foreign-influence-in-u-s-elections"
           "Joint Statement from the ODNI, DOJ, FBI and DHS: Combating Foreign Influence in U.S. Elections")
        (u (:- "中文参考: " (@ "https://www.voachinese.com/a/joint-statement-from-odni-doj-fbi-dhs-us-election-20181019/4621623.html?utm_source=dlvr.it&utm_medium=twitter"
                               "美执法部门联合声明 共同对抗外国渗透美国选举"))))
    (:- '(small () "2018.9.26")
        "美国 川普总统 联合国大会演讲"
        (u
         (:- "全文(英文): "
             (@ "https://www.vox.com/2018/9/25/17901082/trump-un-2018-speech-full-text"
                "Read Trump’s speech to the UN General Assembly"))
         (:- "视频(中文字幕): "
             (@ "https://www.youtube.com/watch?v=xm6BnLaFD3I"
                "特朗普在联合国大会的演讲|全程字幕"))
         (:- "视频(VOA中文同传): "
             (@ "https://youtu.be/aw-lwGoeH4A"
                "特朗普总统在73届联合国大会发表讲话"))
         (:- "重点 (我的主观判断 主要是与中美未来相关的): "
             '(q () (pre () "
独立 自主 协作 捍卫自己国民的利益(人民为主人) 尊重各自的文化
We believe that when nations respect the rights of their neighbors, and defend the interests of their people, they can better work together to secure the blessings of safety, prosperity, and peace.
...
I honor the right of every nation in this room to pursue its own customs, beliefs, and traditions. The United States will not tell you how to live or work or worship.
We only ask that you honor our sovereignty in return.


贸易需要公平对等 中共国破坏了规则(倾销 补助 操纵汇率 强迫技术转让 盗窃知识产权 等) 滥用了美国的开放政策 以及当下世贸体制 不能再被容忍 这需要改变
America’s policy of principled realism means we will not be held hostage to old dogmas, discredited ideologies, and so-called experts who have been proven wrong over the years, time and time again.
...
We will no longer tolerate such abuse.
...
America will never apologize for protecting its citizens.
...
I have great respect and affection for my friend, President Xi, but I have made clear our trade imbalance is just not acceptable. China’s market distortions and the way they deal cannot be tolerated.


拒绝全球主义 拥抱爱国主义 (注意 这里并不同于 全球化 globalization, 对爱国主义的概念 中共国人有不同的认知 不能先入为主 )
.. We will never surrender America’s sovereignty to an unelected, unaccountable, global bureaucracy.

America is governed by Americans. We reject the ideology of globalism, and we embrace the doctrine of patriotism.

Around the world, responsible nations must defend against threats to sovereignty not just from global governance, but also from other, new forms of coercion and domination.


外国想再继续干涉美国内政 没门
Here in the Western Hemisphere, we are committed to maintaining our independence from the encroachment of expansionist foreign powers.

It has been the formal policy of our country since President Monroe that we reject the interference of foreign nations in this hemisphere and in our own affairs. The United States has recently strengthened our laws to better screen foreign investments in our country for national security threats, and we welcome cooperation with countries in this region and around the world that wish to do the same. You need to do it for your own protection.


社会主义和共产主义悲剧 主要提到的是委内瑞拉 但是 你懂的
Ultimately, the only long-term solution to the migration crisis is to help people build more hopeful futures in their home countries. Make their countries great again.
...
Virtually everywhere socialism or communism has been tried, it has produced suffering, corruption, and decay. Socialism’s thirst for power leads to expansion, incursion, and oppression. All nations of the world should resist socialism and the misery that it brings to everyone.


对外援助政策转变 非诚勿扰
The United States is the world’s largest giver in the world, by far, of foreign aid. But few give anything to us. That is why we are taking a hard look at U.S. foreign assistance. That will be headed up by Secretary of State Mike Pompeo. We will examine what is working, what is not working, and whether the countries who receive our dollars and our protection also have our interests at heart.

Moving forward, we are only going to give foreign aid to those who respect us and, frankly, are our friends. And we expect other countries to pay their fair share for the cost of their defense.


促进联合国改革 各尽其能 (至少美国暂时不会直接退出了)
The United States is committed to making the United Nations more effective and accountable.
...
Only when each of us does our part and contributes our share can we realize the U.N.’s highest aspirations. We must pursue peace without fear, hope without despair, and security without apology.


同一个世界 同一个问题: 我们想要的的未来是?
It is the question of what kind of world will we leave for our children and what kind of nations they will inherit.
...
Many countries are pursuing their own unique visions, building their own hopeful futures, and chasing their own wonderful dreams of destiny, of legacy, and of a home.

The whole world is richer, humanity is better, because of this beautiful constellation of nations, each very special, each very unique, and each shining brightly in its part of the world.

In each one, we see awesome promise of a people bound together by a shared past and working toward a common future.


美国想要的未来: 坚持一种 自由 独立 法治 家庭 信仰 传统 爱国 和平 安全 的文化, 并捍卫它
As for Americans, we know what kind of future we want for ourselves. We know what kind of a nation America must always be.
...
So together, let us choose a future of patriotism, prosperity, and pride. Let us choose peace and freedom over domination and defeat. And let us come here to this place to stand for our people and their nations, forever strong, forever sovereign, forever just, and forever thankful for the grace and the goodness and the glory of God.
(我: 这段很鼓舞 建议自己去看看)


谢谢 (我: 同时也希望 中国不用再 CCP bless us)
Thank you. God bless you. And God bless the nations of the world.")))))))

(news-to-topic
 "事件" ;; (human-date (get-universal-time) )
 "2019.03.11 16:23:24"
 (u (:- '(small () "2018.10.4-") " "
        (@ "/testwebsite/articles/2018/10/ChinaTinyChip.html"
           "中共国 供应链 恶意芯片植入 事件") " "
        '(span (:class "badge badge-success") "状态: 未决"))))

(news-to-topic
 "我兔" ;; (human-date (get-universal-time) )
 "2019.03.14 20:40:41"
 (u (:- "未来"
        (u (:- '(small () "2019.3.26")
               (@ "https://www.apple.com/apple-events/"
                  "Apple Special Event")
               '(small () " The Steve Jobs Theater in Cupertino. March 25, 2019, at 10:00 a.m."))))
    (:- "思"
        (u (:- "人权"
               (u (:- `(cite () ,(@ "https://www.state.gov/secretary/remarks/2019/03/290320.htm"
                                    "Remarks on the Release of the 2018 Country Reports on Human Rights Practices")
                             (small () "2019.3.13  U.S. Department of State"))
                      (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=4Pkzo3mf83U"
                                           "Release of the 2018 Country Reports on Human Rights Practices")
                                    (small () "Youtube")))
                         (:- `(cite () ,(@ "https://china.usembassy-china.org.cn/zh/remarks-on-the-release-of-the-2018-country-reports-on-human-rights-practices/"
                                           "发布《2018年度各国人权报告》的讲话")
                                    (small () "2019.3.14 美国驻华大使馆和领事馆")))
                         (:- `(cite () ,(@ "http://www.state.gov/j/drl/rls/hrrpt/humanrightsreport/index.htm?year=2018&dlid=289037"
                                           "Country Reports on Human Rights Practices for 2018 - China (includes Tibet, Hong Kong, and Macau)")
                                    (small () "2019.3.13 U.S. Department of State")))))
                  (:- '(pre () "中共国 有 针对 美国 的人权记录   由于不太规范 很麻烦 顾 感兴趣的自己去搜寻整理吧 我就不浪费时间了"))
                  (:- "我的看法"
                      '(q () (pre () "
美国的人权问题也很严重 不过 世界上就没有完美的国家
对于我来说 中共国的人权问题关乎我的切身利益 所以 更关心

面对已经存在的问题 真正关键的是如何去解决
美国人如何去解决他们的人权问题呢?
在中共国 我们又有什么方法去解决呢?

在中共国 通过 媒体 游行 运动 等 获得社会关注 引发公众 讨论 思考 行动  可行? 如何做呢?
在中共国 游说人大代表 推动立法 这可能吗?

你知道吗 中共国的人权问题 主要就是
政府对自由言论 媒体 社会运动的打压
司法不公 肆意执法 打压人权律师
新疆西藏 宗教信仰的迫害
等等
所以 想要通过正常途径 维护自己的权利 非常困难
这种矛盾 真是很逗  本应维护人权的 却是对人权迫害最严重的

中共国的人权问题恶化的主要因素 就是 中共极权政府(立法 司法 执法 宣传 等 都是它们说了算)
美国的人权问题 他们国内国外都以大大方方的讨论和批评
然而 中共国 国内难以公开自由的讨论 国外谈论就成了干预内政
内部不能制衡 外部的压力也不起作用 
")))))))
    (:- "知"
        (u (:- "5G"
               (@ "https://www.youtube.com/watch?v=GEx_d0SjvS0"
                  "Everything You Need to Know About 5G")
               '(small () "2017.2.6 Youtube"))))
    (:- "视"
        (u (:- '(small () "2019.3.10")
               "埃塞俄比亚客机坠毁"
               (u (:- `(cite () ,(@ "https://cn.nytimes.com/world/20190312/boeing-737-max-which-airlines/"
                                    "哪些航空公司使用波音737 Max执飞航线？")
                             (small () "2019.3.12 纽约时报中文网")))
                  (:- `(cite () ,(@ "https://cn.nytimes.com/business/20190311/boeing-737-max/"
                                    "埃航坠机波音再受质疑，中国航空公司停飞737 Max")
                             (small () "2019.3.11 纽约时报中文网")))
                  (:- `(cite () ,(@ "https://www.bbc.com/zhongwen/simp/world-47517133"
                                    "埃塞俄比亚客机坠毁157人遇难 机上确认有8名中国公民")
                             (small () "2019.3.10 BBC中文")))
                  (:- "其它"
                      (u (:- `(cite ()
                                    ,(@ "https://www.nytimes.com/interactive/2018/12/26/world/asia/lion-air-crash-12-minutes.html"
                                        "In 12 Minutes, Everything Went Wrong - How the pilots of Lion Air Flight 610 lost control.")
                                    (small () "2018.12.26 The New York Times"))))))))
        (u (:- '(small () "2019.3.6")
               "Tim "
               (u (:- `(cite () "Donald J. Trump @realDonaldTrump : "
                             ,(@ "https://twitter.com/realDonaldTrump/status/1105109329290686464")
                             (small () "2019.3.11 Twitter"))
                      '(q () (pre () "
At a recent round table meeting of business executives, & long after formally introducing Tim Cook of Apple, I quickly referred to Tim + Apple as Tim/Apple as an easy way to save time & words. The Fake News was disparagingly all over this, & it became yet another bad Trump story!")))
                  (:- '(pre () "(3.8) 媒体过于娱乐化了 川普总统 说 ”... Tim Apple” 的语境 更可能的意思是 “Tim and Apple”"))
                  (:- `(cite () "(26:50) \".. We apprecite it very much, Tim Apple.\" "
                             ,(@ "https://www.youtube.com/watch?v=b3hT5AUa57A"
                                 "President Trump Participates in an American Workforce Policy Advisory Board Meeting")
                             (small () "2019.3.6 Youtube: The White House")))
                  (:- '(pre () "(3.8) 库克参加的这次会议(美国劳工政策顾问委员会) 是关于美国劳工的 帮助他们提升技能和教育 应对自动化和编程等 新环境"))
                  (:- `(cite () ,(@ "https://www.commerce.gov/sites/default/files/2019-03/AdvisoryBoardGoals.pdf"
                                    "American Workforce Policy Advisory Board Mission and Goals")
                             (small () "PDF: U.S. Department of Commerce")))
                  (:- `(cite () ,(@ "https://www.commerce.gov/americanworker/american-workforce-policy-advisory-board"
                                    "American Workforce Policy Advisory Board")
                             (small () "U.S. Department of Commerce")))
                  (:- `(cite () ,(@ "https://www.whitehouse.gov/pledge-to-americas-workers/"
                                    "Pledge to America’s Workers")
                             (small () "The White House")))
                  (:- `(cite () ,(@ "https://www.whitehouse.gov/presidential-actions/executive-order-establishing-presidents-national-council-american-worker/"
                                    "Executive Order Establishing the President’s National Council for the American Worker")
                             (small () "2018.7.19 The White House")))))))))
