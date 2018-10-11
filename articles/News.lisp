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

(news-to-topic
 "郭文贵" ;; (human-date (get-universal-time))
 "2018.10.12 00:02:18"
 (u (:- "信息源"
        (u (:- "郭媒体 : " (@ "https://www.guo.media/milesguo" "@milesguo"))
           (:- "Youtube : " (@ "https://www.youtube.com/channel/UCO3pO3ykAUybrjv3RBbXEHw/featured" "郭文贵"))
           (:- "Instagram : " (@ "https://www.instagram.com/guowengui/" "guowengui"))))
    (:- "郭七条"
        (u (:- "反对 以黑治国 以警治国 以贪反贪 以黑反贪")
           (:- "不反国家 不反民族 不反习主席")
           (:- '(span (:class "badge badge-secondary") "修改增加: ") "反对以假治国")))
    (:- "海航王健事件"
        (u (:- "王健之死发布会 时间地点: 2018.11.19 纽约曼哈顿 "
               (@ "https://www.thepierreny.com" "The Pierre Hotel")
               `(small () (span (:class "badge badge-light" :style "position: absolute;")
                                ,(@ "https://en.wikipedia.org/wiki/The_Pierre" "Wiki"))))
           (:- '(small () "2018.10.9")
               "郭文: " (@ "https://www.guo.media/posts/134471")
               '(q () (pre () "王岐山已经做了放弃陈峰．和＂必须搞回王健夫人儿子．弟弟王伟的决定！＂而且是要求不惜一切代价不限任何方式！")))))
    (:- "主要内容跟踪"
        (u (:- '(small () "2018.10.11")
               (u (:- "视频: "
                      (@ "https://www.youtube.com/watch?v=EDb7nJMyLGw"
                         "2018年10月11日：未来的三周将是文贵艰难的日子！盗国贼开始一系的疯狂抓捕审判我的员工及家人！拍卖公司资产！")
                      (u (:- '(pre () "郭媒体被攻击 暂时无法访问 会回来的"))
                         (:- '(pre () "强奸适应症 : 忘了 历史 和 伤痛"))
                         (:- '(pre () "美国 两党和国会 一致共识 : 反共 "))
                         (:- '(pre () "无欲名与利 同时 面对盗国贼的手段 放下 就会有 自由 愉悦 欢喜 才会战无不胜")))))
               (u (:- "郭文: " (@ "https://www.guo.media/posts/135228")
                      '(q () (pre () "
10月10日：刚刚一个重大重大的对CCP致命打击👊决定通过……这是历史上最好的最智慧的隔山打牛……近日将公布！必须的说伟大的智慧的美国是人类历史中最值的依赖的安全的国家！……港币人民币．港股．A股可能成为历史以来最大的垃圾！盗国贼的任何形式的海外资产都将回归人民！任何与盗国贼合作过的人都被史无前列的惩罚！记住10月10日这个伟大的日子吧亲爱的战友们！一切都是刚刚开始！
"))))
               (u (:- "视频: " 
                      (@ "https://www.youtube.com/watch?v=ZtUrFGN4ihM"
                         "10月10号：江．朱．王．等盗国贼们．正在疯狂的向海外洗钱！党内对国有化私人企业！产生巨大分歧！都在等上面出大事儿！")
                      (u (:- '(pre () "(4:20) 洗钱 : 国内 家族(江 朱 王 ...) 常委 等等 拼了命的往海外洗钱 用国内资产变换美元"))
                         (:- '(pre () "(8:25) 刘鹤说了啥 ?: 睡衣会 前后 两美国金融大佬(刘鹤等的多年朋友) 与 刘鹤等 私下沟通 : 搞不懂中共到底在搞什么")
                             (u (:- '(pre ()  "他们(刘鹤等) 说 他(习) 满脑子就像把中共国的企业国有化"))
                                (:- '(pre ()  "大佬们问 国有化 人民币会不会很快贬值 ?: 他们 不说话 只点头"))
                                (:- '(pre ()  "大佬们问 王岐山 是否 同意 ?: 他们 摇头"))
                                (:- '(pre ()  "大佬们问 你们 是否 同意 ?: 他们 摇头"))))
                         (:- '(pre () "(12:51) 早乐必早哀 早悲必早衰"))
                         (:- '(pre () "(14:00) 王健之死发布会时间地点 : 11.19 纽约曼哈顿 The Pierre Hotel"))
                         (:- '(pre () "(16:30) 文贵 强烈建议 让副总统彭斯去参加G20 当面问中共经济问题"))
                         )))))
        (u (:- '(small () "2018.10.10")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/134835")
                      '(q () (pre () "
10月9日：这几天文贵会爆刘鹤为什么告诉华尔街金融大佬＂中国正在走向……＂为什么他和周小川都认为XXX是危险的！而王是唯一能救中国的！并让他们小心江志诚！ 江泽民的身体健康不容乐观！"))))
               (u (:- "视频: \"10月9号：CCP如果攻击台湾美国会不会出兵为什么说港币和人民币会垮掉．保护台湾香港极为重要！\"" 
                      (@ "https://www.youtube.com/watch?v=rwttNTC0Izo" "P1(1h)")
                      (@ "https://www.youtube.com/watch?v=-uA5GXWsCnU" "P2(13m)")
                      (u (:- '(pre () "9.9 美国华尔街金融大佬 和 王岐山见面 细节 (睡衣会)")
                             '(span (:class "badge badge-info") "更正: 时间应为 9.16-18"))
                         (:- '(pre () "(P1 23:00) 彭斯 演讲 核心重点是 ?: 从 反恐 到 反共, 美国 不能反悔 否则失去国家信誉"))
                         (:- '(pre () "(P1 29:00) 南海 ?: 美国讨论内部怎么办 : 72小时必须移除军事设施"))
                         (:- '(pre () "(P1 31:00) 台湾 ?: 如果中共打台湾 台湾人民的选择 决定美国怎么介入"))
                         (:- '(pre () "(P1 38:10) 港币 ?: 做空 (隔空取钱)"))
                         (:- '(pre () "(P1 48:00) : 美国 2-3周内 对CCP会有更强硬的措施"))
                         (:- '(pre () "(P1 52:00) : 一段不能放的视频 关于 孟建柱下令杀 新疆抗议者"))
                         (:- '(pre () "(P1 54:00) : 我们是重要参与者 但不要邀功 吹牛美国改变对中共态度是个人的功劳"))
                         (:- '(pre () "(P1 58:00) CCP没了 文贵去干啥 ?: 归隐山林牧场"))
                         (:- '(pre () "(P2 04:00) : 问 \"共产党垮了 中国怎么办\" 这问题的 是有大问题的"))
                         (:- '(pre () "(P2 09:20) : 接下来 王健家人危险更近 更多大企业家被失踪 国内政法委更多人被抓 孙立军也被抓 孟建柱被杀或被抓"))
                         (:- '(pre () "(P2 10:40) : 太多消息没法回 少发无关信息 请给文贵更多时间去和CCP对抗"))))))))))

(news-to-topic
 "中美" ;; (human-date (get-universal-time))
 "2018.10.11 23:51:04"
 (u (:- '(small () "2018.11")
        "南海军演")
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
                                    "彭斯副总统有关美国政府中国政策讲话(中文同传)"))))))

(news-to-topic "中共国" "2018.10.08 20:55:26" "")

(news-to-topic
 "美国" ;; (human-date (get-universal-time))
 "2018.10.11 23:51:34"
 (u (:- '(small () "2018.9.26")
        "川普 联合国大会演讲"
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
 "中共国 供应链 恶意芯片植入 事件" "2018.10.10 12:08:17" 
 (u (:- "主"
        (u (:- '(small () "2018.10.9")
               (@ "https://www.bloomberg.com/news/articles/2018-10-09/new-evidence-of-hacked-supermicro-hardware-found-in-u-s-telecom?srnd=premium"
                  "New Evidence of Hacked Supermicro Hardware Found in U.S. Telecom")
               '(q ()
                 "The security expert, Yossi Appleboum, provided documents, analysis and other evidence ..." (br)
                 "..." (br)
                 "Unusual communications from a Supermicro server and a subsequent physical inspection revealed an implant built into the server’s Ethernet connector, a component that's used to attach network cables to the computer, Appleboum said.")))
        (u (:- '(small () "2018.10.4")
               (@ "https://www.apple.com/newsroom/2018/10/what-businessweek-got-wrong-about-apple/"
                  "What Businessweek got wrong about Apple")
               '(q () "Apple has never found malicious chips
\“hardware manipulations\” or vulnerabilities purposely planted in any server. Apple never had any contact with the FBI or any other agency about such an incident. We are not aware of any investigation by the FBI, nor are our contacts in law enforcement.")))
        (u (:- '(small () "2018.10.4")
               (@ "https://www.bloomberg.com/news/features/2018-10-04/the-big-hack-how-china-used-a-tiny-chip-to-infiltrate-america-s-top-companies"
                  "The Big Hack: How China Used a Tiny Chip to Infiltrate U.S. Companies")
               '(q () (img (:class "zoom" :src "/testwebsite/articles/resource/thebighack.jpg" :width "50px")) "The Big Hack!"))))
    (:- "相关"
        (u (:- '(small () "2018.10.8")
               (@ "https://9to5mac.com/2018/10/08/chinese-spy-chip-2/"
                  "Comment: Four more reasons it’s now inconceivable Apple lied about Chinese spy chips")
               (u (:- "Reasons:"
                      (u (:- "1. " (@ "https://9to5mac.com/2018/10/05/spy-chip/" "GCHQ statement"))
                         (:- "2. " (@ "https://9to5mac.com/2018/10/07/department-of-homeland-security-apple-spy-chip/"
                                      "Department Homeland Security echoed"))
                         (:- "3. " (@ "https://www.reuters.com/article/us-china-cyber-apple/apple-tells-congress-it-found-no-signs-of-hacking-attack-idUSKCN1MH0YQ"
                                      "Reuters reports"))
                         (:- "4. " (@ "https://krebsonsecurity.com/2018/10/supply-chain-security-is-the-whole-enchilada-but-whos-willing-to-pay-for-it/"
                                      "security researcher Brian Krebs said")))))))
        (u (:- '(small () "2017.2.23")
               (@ "https://www.theinformation.com/articles/apple-severed-ties-with-server-supplier-after-security-concern?jwt=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiYWR4dDNAZ21haWwuY29tIiwiZXhwIjoxNTcwMjIwNzkyLCJuIjoiR3Vlc3QiLCJzY29wZSI6WyJzaGFyZSJdfQ.ls8yD0SpK1SYLoC7TAaPBL8GPEu9Nd8mutWz0EEdU6o&unlock=ac889c2a9c7ed1fa"
                  "Apple Severed Ties with Server Supplier After Security Concern"))))
    (:- "补充"
        (u (:- '(small () "事件相关的 硬件骇客技术的 可能性和方法:")
               `(p ()
                   ,(@ "https://www.lawfareblog.com/china-supermicro-hack-about-bloomberg-report"
                       "The China SuperMicro Hack: About That Bloomberg Report")
                   (small () "2018.10.4")))))))
