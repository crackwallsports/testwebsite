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
 (u (:- '(small () "2019.1.3")
        (u (:- "郭文(Snow 短视频 照片): "
               (@ "https://www.guo.media/posts/167120")
               (@ "https://www.guo.media/posts/167106")
               '(q () (pre () "风中的Snow"))
               (u (:- '(pre () "(我: 风中的棉花糖)"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/167085")
               '(q () (pre () "
尊敬的战友们：这是我们正式起诉 BSF 律师事务所 Josh Schiller 的起诉书！Josh. 不管你是谁，不管你是什么背景，我们不接受任何人的威胁！🔥我们崇敬的美国法律一定会给我们尊严和安全！💪💪💪"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.1.2")
        (u (:- "郭文(短视频 照片): "
               (@ "https://www.guo.media/posts/166929")
               (@ "https://www.guo.media/posts/166922")
               '(q () (pre () "
2019年1月1日：上一个视频问题的答案在这里……这是我花了6个小时为战友准备的这个视频并回答上一个郭文问题！ 这是关于天才乔布斯与他带有神秘色彩的设计的游艇的东方理念来源有关！ 从这一个极少极少人知道的设计理念来源来看．乔布斯．他绝对是上天赐予我们人类的礼物……与天造之才！由于我的船同时同厂建造……我才有幸看到维纳斯在船厂建造之时进去参观．并目睹了天才一系列的设计理念的过程与图纸！可惜的是乔布斯没有等到船建造完成！也没有使用过一次这个船！后来他的妻子接受这艘完美的独一无二的海上艺术品！使用至今！

2019年1月1日：尊敬的战友们猜猜这几张照片是什么意思……有什么理念蕴含其中！"))
               (u (:- '(pre () "乔布斯的游艇\"维纳斯号\"设计理念"))))
           (:- "郭文(报平安视频): " (@ "https://www.guo.media/posts/166888")
               '(q () (pre () "
2019年1月1日：文贵报平安视频！尊敬的战友们好！你们健身了吗！ 一切都是刚刚开始！以法灭共开始倒计时……🙏🙏🙏🙏🙏🙏🙏🙏🙏✊✊✊😍😍😍😘😘😘😘😘😘🦅🦅🦅")))
           (:- "视频: 郭先生视角 "
               (@ "https://www.youtube.com/watch?v=N3VLi6mbLa8"
                  "2019年1月1日文贵接受木兰小姐访问，什么时候放91号文件，刘承杰他爹到底是谁，共产党会怎样灭亡，2019我们做什么。")
               '(small () "Youtube")
               (u (:- `(cite () "木蘭訪談 视角: "
                             ,(@ "https://www.youtube.com/watch?v=6idLehYSRRA"
                                 "2019年元旦卡丽熙采访郭文贵先生，新年贺词和展望，重要的一年战友们一起打击CCP，新的开端新的决胜阶段！")
                             ,(@ "https://www.youtube.com/watch?v=DxezJ2AiC9c"
                                 "高清版")
                             (small () "Youtube")))
                  (:- '(pre () "新年贺词"))
                  (:- '(pre () "如何能够付出更少的代价来完成这场革命 ?: 依法治国 安全 信仰自由 心安 和平不扩张 正道主义"))
                  (:- '(pre () "欺民賊上台执政的可能性 ?: 完全没有 这些人没有这种能力 海外欺民贼无德无能 不配 (我: 海外这些恶心人 敢参加民主选举? 哈哈哈 把它们这几年恶心人的文字视频一放 你还会选它们吗!)"))
                  (:- '(pre () "盗国贼盗取 如此庞大的财富 是否有更深的动机 ?: 从这个体制中成长的它们 充满了矛盾和恐惧 只相信实力 能够用权力财富保自己安全 没有那么深的层次 ")
                      (u (:- '(pre () "什么是贵族"))
                         (:- '(pre () "贪嗔痴慢疑")
                             `(cite () ,(@ "https://zh.wikipedia.org/zh-cn/五盖"
                                           "五盖")))))
                  (:- '(pre () "王岐山下的了手杀忠心的王健 ? 中共没有敢不敢 只有需不需要")
                      (u (:- '(pre () "陈峰 出行住飞机上 以及与王健的矛盾嫉妒"))
                         (:- '(pre () "问党内官员和国内企业家问题: 没选择 上面都有人照着你 请问你 你会不会成为王健? 上面的人会不会担心你有一天会威胁到他 他什么情况下会让你变王健? 你能一辈子安全吗? 中共国的房地产泡沫超量印钞对外扩张 你们作为实施者 外国警醒时 谁会是王健?  不想变成王健的下场 你该怎么做?"))))
                  (:- '(pre () "2019 国内经济 人们如何准备?")
                      (u (:- '(pre () "中美 中西方 的 意识形态的对抗"))
                         (:- '(pre () "美国在宗教信仰自由方面的动作 达赖喇嘛"))
                         (:- '(pre () "2019 是上天的惩罚年"))
                         (:- '(pre () "股票 房子 债务 甚至局部战争"))
                         (:- '(pre () "平安 健康 高兴 能活着就不错了"))))
                  (:- '(pre () "宗教信仰自由 中共互联网管理办法")
                      (u (:- '(pre () "中国大陆反基督教最严厉的时期 ? 1890 义和团")
                             `(cite () ,(@ "https://zh.wikipedia.org/zh-cn/海外基督使團"
                                           "海外基督使團")))
                         (:- '(pre () "每逢 对 宗教巨大打击的时期 就是 完结的时候"))
                         (:- '(pre () "对 台湾 双全制 经济和民意完全控制"))
                         (:- '(pre () "谈教必谈政 宗教为政治服务"))
                         (:- '(pre () "基督教被反的原因 : 普世价值 人人平等"))
                         (:- '(pre () "恶政 毁人心"))))
                  (:- '(pre () "刘呈杰 的 爹 ? 是打开 潘多拉盒子之前的一个小礼物 会提供可信的证据")
                      (u (:- '(pre () "郭先生 在国内没有任何微信微博 国内所谓郭文贵号召大家反习近平 是假的 语音是伪造的"))
                         (:- '(pre () "郭先生的目标 不是它们个人 而是中共 中共这个体制 体制不变 谁上谁下都不会改变 甚至更糟"))
                         (:- '(pre () "仅仅告诉大家 刘的父母是谁 不会对我们的目标有多大帮助 大家要高智慧 不要被一时一事所迷惑"))
                         (:- '(pre () "郭先生 背后的图是 西藏 十八罗汉图 战友就是十八罗汉 战友护法 辨真假 追求喜马拉雅"))
                         (:- '(pre () "我们要让全世界人 更多的知道 中共这些妖魔鬼怪的恶行 知道真相"))))
                  (:- '(pre () "政事小哥视频"))
                  (:- '(pre () "2019 展望")
                      (u (:- '(pre () "2018 超额完成 即在意料之中 也有意料之外"))
                         (:- '(pre () "2019 让国际战场发生实质性转变 让世界各国和我们一起 只反共 不反中 更不能反中国人 更多意识到中共的影响和威胁 团结一起 消灭中共 "))
                         (:- '(pre () "更多的传播爆料 让国人能够清醒过来 和我们一起 迎接阳光照耀大地"))))
                  (:- '(pre () "对CCP政权说的话 (我: 我也没听出来啊 看到路德说才发现 郭先生的藏头诗 \"回头是岸\")"))
                  (:- '(pre () "盗二代没有回炉的可能性 中国有太多能人能够管理国家 不用操心 让我们消灭中共 改变中国 让真正的能人能够真正管理国家 这些人现在就在屏幕前看着我们的视频"))
                  (:- '(pre () "没有中共 中国不会乱")
                      (u (:- '(pre () "问过曾经的最高领导人四次 中共没了 中国会不会乱 会不会军阀割据 他第四次时回答了我 (我: 这人应该是 胡)"))
                         (:- '(pre () "反问: 中国改朝换代 什么时候造成过长期的动乱?"))
                         (:- '(pre () "没有 因为国人的两个有点 温饱不思变 和 最不好战"))
                         (:- '(pre () "只要解决中南海那几个人 就能改变"))))
                  (:- '(pre () "陈氏兄弟为了他们的安全现在不便说太多 孟晚舟事件看加拿大")
                      (u (:- '(pre () "最后会妥协 引渡可能性不大"))
                         (:- '(pre () "加拿大 蓝金黄程度 洗钱 官员家人 赖昌星被遣返是标志性事件 华人团体和媒体"))
                         (:- '(pre () "加拿大是蓝金黄美国的桥头堡 北部大平台 南方是巴哈马(大使馆面积 监听监控美国的潜水艇 F20F35的训练) "))
                         (:- '(pre () "加拿大将反击中共"))
                         (:- '(pre () "法治基金 太多人要捐钱 看到了CCP的威胁"))))
                  (:- '(pre () "香港 的 核心问题 : 法治的丧失  金融市场 房地产 危机  香港人要站起来自救"))
                  (:- '(pre () "(2:07:0) 91号文件的公布计划 2019年底 条件需要 相关人安全有保证  会在多国同时爆出 因涉及到被蓝金黄的各国  同时 与国内的有良知有勇气的人一起发起 要中共要真相要交待的运动 等 一系列的信息被公布"))
                  (:- '(pre () "关注爆料革命 (我: 2019 醒过来吧 别在猪年继续猪拱猪 只为吃喝拉撒睡而活着)"))
                  (:- '(pre () "法治基金 捐款的问题 想捐款的人太多 郭先生只想做捐助者 董事和主席的问题 独立的团队 帮助受中共迫害的所有人"))
                  (:- '(pre () "祈福"))
                  (:- '(pre () "2019 不平凡 中国到了不变就死 非变不可的时代 在自己安全的情况下 参与到爆料革命中来"))
                  (:- '(pre () "感谢所有人的付出")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.1.1")
        (u (:- "郭文: "
               (@ "https://www.guo.media/posts/166743")
               (@ "https://www.guo.media/posts/166620")
               '(q () (pre () "
Official Statement of Guo Wengui Regarding the Trial of Chinas Former Deputy Minister of State Security, Ma Jian

关于中国国家安全部原副部长马建先生被判无期徒刑与郭文贵关系的严肃声明"))
               (u (:- '(pre () "郭文内容: 声明的文档照片 英中文版"))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/166596")
               '(q () (pre () "
2018年12月31日尊敬的战友们好，你们健身了吗，一切都是刚刚开始！提醒大家明天看木兰访谈迎阳历年2019，同时在郭媒体、木兰访谈直播，纽约时间1号上午10点，北京时间晚上10点。2019年新年卡丽熙采访郭文贵先生新年贺词和展望，敬请关注➕纽约时间2019年1月一日10点整，北京时间23点整，youtube.com/channel/UCkU5h…"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=jSnRcdAi7aU"
                                    "郭文视频"))
                      '(small () "Youtube"))
                  (:- '(pre () "花生岛 大概6,7个月前立弃牌子不让靠近 加强了安保"))
                  (:- '(pre () "川普总统越加的意识到 CCP是人类的威胁 信仰宗教人性的威胁")))))))
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
 "郭文贵"  ;; (twb::human-date (get-universal-time))
 "2019.01.03 19:53:21"
 (u (:- "信息源"
        (u (:- "郭媒体 : " (@ "https://www.guo.media/milesguo" "@milesguo"))
           (:- "Youtube : " (@ "https://www.youtube.com/channel/UCO3pO3ykAUybrjv3RBbXEHw/featured" "郭文贵"))
           (:- "Instagram : " (@ "https://www.instagram.com/guowengui/" "guowengui"))))
    (:- "郭七条"
        (u (:- "反对 以黑治国 以警治国 以贪反贪 以黑反贪")
           (:- "不反国家 不反民族 不反习主席")
           (:- '(span (:class "badge badge-secondary") "修改增加: ") "反对以假治国")))
    (:- "蓝金黄 3F计划")
    (:- "海航王健事件"
        (u (:- "王健之死 与 海航集团背后的真相 发布会"
               (u (:- "时间: 2018年11月20日 美国东部时间 早上10-12点")
                  (:- "地点: 纽约"
                      (@ "https://www.thepierreny.com" "The Pierre Hotel")
                      `(small () (span (:class "badge badge-light" :style "position: absolute;")
                                       ,(@ "https://en.wikipedia.org/wiki/The_Pierre" "Wiki"))))))
           (:- '(small () "2018.11.19")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/147483")
                      '(q () (pre () "
11月18日：律师又要求修改文件．全部加班呢……以法治国．的确让人很累．很花钱．但是我感觉很幸福很开心！因为能让我感觉我是在一个安全的公平的环境里生存！一切都是刚刚开始！")))))
           (:- '(small () "2018.11.18")
               (u (:- "视频: " (@ "https://www.youtube.com/watch?v=D9ggVuylclY"
                                  "2018年11月17日：11月20号的新闻发布会进展报告，遇到了巨大的困难，但是一定会照常进行。"))
                  (:- "郭文(照片和视频): "
                      (@ "https://www.guo.media/posts/147013")
                      ".."
                      (@ "https://www.guo.media/posts/147016")
                      '(q () (pre () "
11月17日：凯琳在为她们翻译．她们说王健百分之百的是没有自拍．不是……警察封锁了一切真相！威胁人们不要讲话……

11月17日：他来了．她也来了．太不容易了！凯琳正在翻译！")))))
           (:- '(small () "2018.11.16")
               (u (:- "视频: " (@ "https://www.youtube.com/watch?v=cqjWOczCby0" "2018．11月15日：11月20日在纽约举行巜王健之死．海航背后的真相发布会》的正式公告！"))))
           (:- '(small () "2018.11.15")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/145989")
                      '(q () (pre () "
11月14日：尊敬的战友们好！我刚刚收到律师团队的通知！明天中午前才能得到法院最后的批准！ 所以会议是19号还是20号．要等到明天中午12点前才能决定！文贵再次致以万分的歉意！")))
                  (:- "视频: " (@ "https://www.youtube.com/watch?v=0VE05drVdz8"
			                      "2018．11月19号的王健之死的发布会．可能导致股市波动．及其他重大政治事件！要从19号改至20号！"))))
           (:- '(small () "2018.11.6")
               (u (:- "郭文(多条 照片): " (@ "https://www.guo.media/posts/143276")
                      '(q () (pre () "
11月5日：11月19日．将是一个什么样的结果！什么样的情况！一个又一个的威胁向我冲来……我现在收到的劝说！利诱……前所没有！我现在正在向有关人介绍发布会的情况！")))))
           (:- '(small () "2018.11.1")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/141318")
                      '(q () (pre () "
我们是王健先生被杀案的独立调查者．花钱．时间．人力．承担风险最大的调查团队！这个荒唐的王健一人独立的爬墙死！是对全世界人民的智商的侮辱 ... 上神．不会放过一个做恶欺天的人！")))))
           (:- '(small () "2018.10.30")
               "最新法国官方调查结果"
               (u (:- (@ "https://freebeacon.com/national-security/french-court-rules-chinese-tycoon-died-accident/" 
                         "French Court Rules Chinese Tycoon Died in Accident")
                      '(small () "2018.10.30 FreeBeacon"))
                  (:- "中文翻译: " (@ "https://littleantvoice.blogspot.com/2018/10/bill.html?m=1"
                                      "翻译：自由灯塔Bill 法国法院裁定中国大亨死于意外 海航联合创始人王建的死亡之谜")
                      '(small () "2018.10.30 战友之声") )))
           (:- '(small () "2018.10.29")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/140349")
                      '(q () (pre () "
10月28日：关于王健被谋杀……法国阿尼翁地方法法院的判决近日将公布……然后…… 他们一个一个的公布！ 为的就是挑战我们的发布会！ 他们将为他们无知付出巨大代价！ 他们要先下手为强！ 但是他们不了解我们拥有什么样的力量！ 我要的就是这个结果！ 按这样一剧情发展！ 我们将会将发布会变成王岐山的送葬会！天助我也……一切都是刚刚开始！ 我们的新闻发布会将是一场空前的法律大战！反黑反谋杀的大战！目前为止已经有223家世界级的媒体要求参加……我们可能只能允许30家媒体到现场了！有关部门已经正式告知我们！已经获得准确信息！CCP将不惜一切代价！阻止新闻发布会举行！但是我告诉他们！我们即使付出生命的代价都不会放弃！天塌地陷我们也不会放弃！✊️✊️✊️")))
                  (:- "郭文(短视频): " (@ "https://www.guo.media/posts/140293")
                      '(q () (pre () "
10月28日：法国司法部决定．高院和普罗旺死法院里昂法院联合做出一个判决．王健被杀案很多关键的事实否定．并通过法院来坐实建属于自己杀自己．自己找死……法院判决结果！并没有任何证人和杀手在现场！法国版的大连法院审判！一切都是刚刚开始！")))
                  (:- "视频: " (@ "https://www.youtube.com/watch?v=1O8D-gWQD7o"
                                  "战友之声 20181028 郭文贵直播（完整版） 中美将进入全面金融贸易战 新疆集中营问题将得到国际社会的关注，法国内政部被绿了？")
                      (u (:- '(pre () "(32:00) 王健之死的进展 法国新的调查报告 中共为掩盖事实的无耻行径 法国蓝金黄的程度可见一斑"))
                         (:- '(pre () "(46:50) 官方人说: 孟宏伟被抓 很大程度上与王健之死有关 因为孟被抓 好几人中共国人也在法国消失"))
                         (:- '(pre () "(52:00) 王健之死新闻发布会 会 异常的精彩 异常的平淡 也会..."))))))
           (:- '(small () "2018.10.28")
               "郭文: " (@ "https://www.guo.media/posts/140047")
               '(q () (pre () "
10月27日：当我今天看到法国内政部．及关于王健之死调查小组的调查报告．更新版时！我极为的兴奋与激动．似乎我所有担心的事情都发生了！更加印证了．我获得的情报的准确性😹关于王健之死与裴楠楠．王岐山和以及法国的华镔等沉默的力量的勾结！的细节！以及在法国蓝金黄力量的强大！例如其中的很多细节的陈述和前几个月前的调查报告完全相反！我不能一一在此列举！如报告中……（王建之死没有任何人在场……是他自己跳下去的！更不存在助跑．自拍……)😇😇😇这和前几版调查总结和报告．及中国官方．海航的公告……完全相反！这更加坐实了是他们一起谋杀了王健先生！而且对王建先生所见的人名单很多人被剔除……资产转让协议的事情这次报告更详细了！……虽然他们想再一次的瞒天过海……但我深信这又是上天赐给我们的一个大礼物．一切都是刚刚开始！🙏🙏🙏🙏🙏🙏
")))
           (:- '(small () "2018.10.9")
               "郭文: " (@ "https://www.guo.media/posts/134471")
               '(q () (pre () "王岐山已经做了放弃陈峰．和＂必须搞回王健夫人儿子．弟弟王伟的决定！＂而且是要求不惜一切代价不限任何方式！")))))
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
 "中共国" ;; (human-date (get-universal-time) )
 "2018.10.30 12:02:11"
 (u (:- "事件"
        (u (:- '(small () "2018.10.20")
               "澳门中联办主任 郑晓松 死亡"
               (u (:- '(pre () "郭文贵: 是被杀 他与孟宏伟是好哥们"))
                  (:- '(pre () "中共官方: 中央人民政府驻澳门特别行政区联络办公室主任 郑晓松同志 因患抑郁症 于2018年10月20日晚 在其澳门住所 坠楼身亡")))))
        (u (:- "孟宏伟")))
    (:- "国外"
        (u (:- '(small () "2018.10.26")
               (@ "https://www.cbc.ca/news/politics/mcccallum-china-trade-human-rights-1.4878455"
                  "Canada prepared to stall trade deal with China until its behaviour is 'more reasonable'")
               '(small () "CBC"))))))

(news-to-topic
 "美国" ;; (human-date (get-universal-time))
 "2018.11.07 17:37:40"
 (u (:- '(small () "2018.11.7") "Midterm elections 2018 美国中期选举"
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
 "中共国 供应链 恶意芯片植入 事件" ;; (human-date (get-universal-time))
 "2018.10.24 12:51:54"
 (u (:- "主"
        (u (:- '(small () "2018.10.22")
               (@ "https://www.reuters.com/article/us-china-cyber-super-micro-comp/super-micro-to-review-hardware-for-malicious-chips-idUSKCN1MW1GK?feedType=RSS&feedName=technologyNews&utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+reuters%2FtechnologyNews+%28Reuters+Technology+News%29"
                  "Super Micro to review hardware for malicious chips")
               '(q () (pre () "
“Despite the lack of any proof that a malicious hardware chip exists, we are undertaking a complicated and time-consuming review to further address the article,” the server and storage manufacturer said in a letter to its customers, dated Oct. 18.
...
Super Micro denied the allegations made in the report.

The company said the design complexity makes it practically impossible to insert a functional, unauthorized component onto a motherboard without it being caught by the checks in its manufacturing and assembly process.
"))))
        (u (:- '(small () "2018.10.19")
               (@ "https://www.buzzfeednews.com/article/johnpaczkowski/apple-tim-cook-bloomberg-retraction"
                  "Apple CEO Tim Cook Is Calling For Bloomberg To Retract Its Chinese Spy Chip Story")
               '(q () (pre () "
“There is no truth in their story about Apple,” Cook told BuzzFeed News in a phone interview. \"They need to do that right thing and retract it.\"
...
“We turned the company upside down,” Cook said. “Email searches, data center records, financial records, shipment records. We really forensically whipped through the company to dig very deep and each time we came back to the same conclusion: This did not happen. There’s no truth to this.”
"))))
        (u (:- '(small () "2018.10.9")
               (@ "https://www.bloomberg.com/news/articles/2018-10-09/new-evidence-of-hacked-supermicro-hardware-found-in-u-s-telecom?srnd=premium"
                  "New Evidence of Hacked Supermicro Hardware Found in U.S. Telecom")
               '(q () (pre () "
The security expert, Yossi Appleboum, provided documents, analysis and other evidence ...
...
Unusual communications from a Supermicro server and a subsequent physical inspection revealed an implant built into the server’s Ethernet connector, a component that's used to attach network cables to the computer, Appleboum said.
") )))
        (u (:- '(small () "2018.10.4")
               (@ "https://aws.amazon.com/blogs/security/setting-the-record-straight-on-bloomberg-businessweeks-erroneous-article/"
                  "Setting the Record Straight on Bloomberg BusinessWeek’s Erroneous Article")
               '(q () (pre () "
At no time, past or present, have we ever found any issues relating to modified hardware or malicious chips in SuperMicro motherboards in any Elemental or Amazon systems. Nor have we engaged in an investigation with the government.
"))))
        (u (:- '(small () "2018.10.4")
               (@ "https://www.apple.com/newsroom/2018/10/what-businessweek-got-wrong-about-apple/"
                  "What Businessweek got wrong about Apple")
               '(q () (pre () "
Apple has never found malicious chips \“hardware manipulations\” or vulnerabilities purposely planted in any server. Apple never had any contact with the FBI or any other agency about such an incident. We are not aware of any investigation by the FBI, nor are our contacts in law enforcement."))))
        (u (:- '(small () "2018.10.4")
               (@ "https://www.bloomberg.com/news/features/2018-10-04/the-big-hack-how-china-used-a-tiny-chip-to-infiltrate-america-s-top-companies"
                  "The Big Hack: How China Used a Tiny Chip to Infiltrate U.S. Companies")
               '(q () (img (:class "zoom" :src "/testwebsite/articles/resource/thebighack.jpg" :width "50px")) "The Big Hack!"))))
    (:- "相关"
        (u (:- '(small () "2018.10.22")
               (@ "https://www.servethehome.com/investigating-implausible-bloomberg-supermicro-stories/"
                  "Investigating Implausible Bloomberg Supermicro Stories")))
        (u (:- '(small () "2018.10.11")
               (@ "https://www.macrumors.com/2018/10/11/kaspersky-lab-questions-supermicro-allegations/"
                  "Kaspersky Lab Says Report Claiming China Hacked Apple's Former Server Supplier is Likely 'Untrue'")
               '(q () (pre () "
The stories published by Bloomberg in October 2018 had a significant impact. For Supermicro, it meant a 40% stock valuation loss. For businesses owning Supermicro hardware, this can be translated into a lot of frustration, wasted time, and resources. Considering the strong denials from Apple and Amazon, the history of inaccurate articles published by Bloomberg, including but not limited to the usage of Heartbleed by U.S. intelligence prior to the public disclosure, as well as other facts from these stories, we believe they should be taken with a grain of salt."))))
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
                   ,(@ "https://www.servethehome.com/investigating-implausible-bloomberg-supermicro-stories/"
                      "Investigating Implausible Bloomberg Supermicro Stories")
                   (small () "2018.10.22"))
               `(p ()
                   ,(@ "https://www.lawfareblog.com/china-supermicro-hack-about-bloomberg-report"
                       "The China SuperMicro Hack: About That Bloomberg Report")
                   (small () "2018.10.4")))))))

(news-to-topic
 "当前关注自媒体" ;; (human-date (get-universal-time) )
 "2018.11.21 13:29:22"
 '(p () "这只是部分 我将 增量补充 未来我看了新的视频时 再加入" )
 (u (:- "Youtube"
        (u (:- (@ "https://www.youtube.com/channel/UCm3Ysfy0iXhGbIDTNNwLqbQ/featured"
                  "路德社"))
           (:- (@ "https://www.youtube.com/channel/UCNKpqIqrErG1a-ydQ0D5dcA/featured"
                  "战友之声"))
           (:- (@ "https://www.youtube.com/channel/UCQT2Ai7hQMnnvVTGd6GdrOQ"
                  "政事直播(政事小哥)"))
           (:- (@ "https://www.youtube.com/channel/UCkU5hWnORzZMZf9SkFmjF6g"
                  "木蘭訪談"))
           (:- (@ "https://www.youtube.com/channel/UCF8iFfXnkbYIUqykN_xpy8g"
                  "南十字星"))
           (:- (@ "https://www.youtube.com/channel/UCyDCC5CcIqMqBbzMVENoKVQ"
                  "赵岩"))
           (:- (@ "https://www.youtube.com/channel/UCA3-DEkClR3G1DG1cq8YbeQ"
                  "Inty"))))))
