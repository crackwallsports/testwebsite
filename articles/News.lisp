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
 "郭文贵"   ;; (human-date (get-universal-time))
 "2018.10.22 17:36:06"
 (u (:- "信息源"
        (u (:- "郭媒体 : " (@ "https://www.guo.media/milesguo" "@milesguo"))
           (:- "Youtube : " (@ "https://www.youtube.com/channel/UCO3pO3ykAUybrjv3RBbXEHw/featured" "郭文贵"))
           (:- "Instagram : " (@ "https://www.instagram.com/guowengui/" "guowengui"))))
    (:- "郭七条"
        (u (:- "反对 以黑治国 以警治国 以贪反贪 以黑反贪")
           (:- "不反国家 不反民族 不反习主席")
           (:- '(span (:class "badge badge-secondary") "修改增加: ") "反对以假治国")))
    (:- "海航王健事件"
        (u (:- "郭媒体新闻发布会：海航与王健之死"
               (u (:- "时间: 2018年11月19日 美国东部时间 早上10点")
                  (:- "地点: 纽约"
                      (@ "https://www.thepierreny.com" "The Pierre Hotel")
                      `(small () (span (:class "badge badge-light" :style "position: absolute;")
                                ,(@ "https://en.wikipedia.org/wiki/The_Pierre" "Wiki"))))))
           (:- '(small () "2018.10.9")
               "郭文: " (@ "https://www.guo.media/posts/134471")
               '(q () (pre () "王岐山已经做了放弃陈峰．和＂必须搞回王健夫人儿子．弟弟王伟的决定！＂而且是要求不惜一切代价不限任何方式！")))))
    (:- "主要内容跟踪"
        (u (:- '(small () "2018.10.22")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/138116")
                      '(q () (pre () "
... 这个林小姐是瑞银的私人银行狠角色！爸爸是个人物！她和她的老板王贯中！都是过去近二十年来为国内盗国贼洗钱几千亿美元💵以上的人物！她与多个常委家族有极深的关系！ ..."))
                      (u (:- '(pre () "瑞银 林小姐(Rebecca Lin) "))
                         (:- `(pre ()
                                   ,(@ "https://www.reuters.com/article/us-ubs-group-china-banker/ubs-warns-staff-over-china-travel-after-banker-held-in-beijing-source-idUSKCN1MU067"
                                       "UBS warns staff over China travel after banker held in Beijing: source")
                                   " (瑞银集团(UBS) 和 瑞士宝盛银行(Julius baer) 对 部分员工发出警告 禁止前往中共国的 因可能被莫名拘留或限制离境)")))))
               (u (:- "郭文: " (@ "https://www.guo.media/posts/138078")
                      '(q () (pre () "
路徳先生说的对．他与史地夫蚊．孙力军一起操作的所谓的习给川的亲笔信！听说习主席非常恼火！ 美国前FBl高官曾告诉我：澳门郑晓松．孙力军．是操纵这个事件的关键人之一！这位官员说他认为郑晓松．孙力军．会被灭掉！现在己经灭了一个了！看来美国的情报分析能力还中！
"))))
               (u (:- "视频: " (@ "https://www.youtube.com/watch?v=xoND9qNE7g0"
                                  "战友之声 20181021郭文贵报平安 澳门中联办主任郑晓松被杀是因为孟宏伟！接着排队跳楼的会更多 ，大家拭目以待！！")
                      (u (:- '(pre () "郑晓松是被杀 他和孟宏伟是好哥们"))
                         (:- '(pre () "香港中联办的王某 也快了"))
                         (:- '(pre () "利益的清洗 轮换")))))))
        (u (:- '(small () "2018.10.21")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/137840")
                      '(q () (pre () "
战友们团结一致的力量！已经在传播文贵爆料！捍卫美国中期选举！揭开盗国贼罪行！集结一切力量！我们已经形成了真正的无万敌当的巨大的力量！迎接CCP倒下的那一刻！下周将会在港币．CCPB．港股．A股．因各种制栽！联合行动后产生……戏剧性的变化！南海方面将有一糸列的行动！一切都是刚刚开始！
"))))
               (u (:- "郭文: " (@ "https://www.guo.media/posts/137585")
                      '(q () (pre () "... 一魔长寿．亿人枯！这才是真真正正的供血党的本质！..."))
                      (u (:- '(pre () "朱镕基")))))))
        (u (:- '(small () "2018.10.20")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/137471")
                      '(q () (pre () "
看看卢比奥先生的言讲：他反对是中共👍及中共政府🙏中国人民过去现在都是伟大的！中国人民的利益就是美国人民的核心利益！感谢磨镜霸加上的中文字幕！否则文贵会听成为．王岐山．和海外民运的利益！就是美国的核心利益！😹😹😹一切都是刚刚开始🌹🌹🌹
"))
                      (u (:- `(pre () "卢比奥议员的演讲: "
                                     ,(@ "https://www.youtube.com/watch?v=Kowkt19f4hU"
                                        "（听译17）参议员卢比奥再谈中国人权：中国人民的利益也是美国的核心利益"))))))
               (u (:- "郭文: " (@ "https://www.guo.media/posts/137403")
                      '(q () (pre () "
孟宏伟先生．现在在北京的一家医院里被关押！因为在抓他时自杀未遂伤到了孟宏伟先生！中央专案组正在用孟宏伟和高女士的家人来威胁诱骗孟夫人回国！一旦她上当！或者在海外和任何中国派来的人接触！包括最亲的最信任的朋友！她便会死无葬身之地。这都是独裁．无法无天的人．把人民当猪狗人的意志逻辑和想法，但愿不要生在孟夫人身上！
"))))
               (u (:- "视频: " (@ "https://www.youtube.com/watch?v=lzGaEclu-_g"
                                  "Oct 19th 2018：请战友们发信息给我用郭媒体私信功能！拜托千万不要再给我寄钱了！")))))
        (u (:- '(small () "2018.10.18")
               (u (:- "视频: " (@ "https://www.youtube.com/watch?v=7vA9ZHu-6iE"
                                  "法国大革命与共产党的打土豪分田地的根本不同！也必将引起流血革命！西方国家已经开始实施对中国共产党的清除方案！无人可以改变！")
                      (u (:- '(pre () "法国大革命时期 与 中共国当下 的相同与不同"))
                         (:- '(pre () "贫富悬殊的问题 是 制度的问题"))
                         (:- '(pre () "(31:50) 自力更生 体现它们的无德无能 (我: 哈哈哈 高能警告 吃饭的观众请注意)"))
                         (:- '(pre () "(35:10) 什么时候走到闭关锁国 ?: 不可能 没这能力  当下的时代 媒体的力量 无比巨大" ))
                         (:- '(pre () "(41:25) 沙特大使馆记者被杀事件 与 王健之死")
                             (u (:- '(pre () "T先生的看法"))
                                (:- '(pre () "世界媒体 报道的差异 说明了 中共对世界的影响" ))))
                         (:- '(pre () "(47:45) 王岐山 去中东 搞郭搞油搞科技")
                             (u (:- '(pre () "王岐山 负责的 海外国家安全基金 弄到自家去了 "))
                                (:- '(pre () "美国会高度关注"))))
                         (:- '(pre () "(54:15) 德州大学基金是发起者 是同其它大基金一起行动 而且是 受到美国相关部门默许支持"))
                         (:- '(pre () "(1:01:47) 美国与中共的这次较量 根本不是一个制裁能解决的")
                             (u
                              (:- '(pre () "美国对中共的态度 以及下一步如何应对 ?: 美官员的答案 : 现在是制度的对决 信仰和宗教的对决 世界经济秩序的对决 世界和平的对决 美国国家安全的对决 美国价值的对决"))
                              (:- '(pre () "发生军事冲突 会有什么结果 ?: 美国现在前三号人物之一回答 : 亚洲 长则一星期 短则72小时 结束任何形式的战争 中东12小时进12小时出达成 都是既定战略"))
                              (:- '(pre () "中共抓间谍怎么办 ?: 大打小 抓更多它们的间谍"))
                              (:- '(pre () "说出要消灭中共制度怎么办 ?: 那一刻中共开启倒计时 中国人民世界华人等等知道它们要完 就不会再和它们做交易"))
                              (:- '(pre () "冷战 超级冷战 是生死之战 美国输则完 川普必须赢中期选举"))))
                         (:- '(pre () "国人华人需要醒需要开智 我们要问自己该做什么 让世界看到我们在反抗"))
                         (:- '(pre () "(1:29:50) 孟宏伟暂时不会被杀 但活着出来的可能性已经没有 他妻子高女士 要么被杀或被绑架回去 要么爆出大料  我们要 尊重 支持 高女士")))))))
        (u (:- '(small () "2018.10.17")
               (u (:- "视频: " (@ "https://www.youtube.com/watch?v=-f6N_NFGuF8"
                                  "中共政法委专案小组．及大连法院以法盗劫780亿意味着什么！")
                      (u (:- '(pre () "对大连审判的看法 : 以黑治国最好的证明 上天给暴力革命的最好的礼物"))
                         (:- '(pre () "大连审判 背后的详情 : 正在准备一个视频 待到 上诉期走完 执行破产重组 后发布"))
                         (:- '(pre () "(我: 活着被肢解 真的很痛 我想起了美剧&lt;Dexter 嗜血法医&gt;)"))
                         (:- '(pre () "专案组的流氓行径"))
                         (:- '(pre () "把 我 嫂子的 姐姐的 女儿的 正谈恋爱的 对象的 爸爸妈妈 都给边控"))
                         (:- '(pre () "判决书 荒唐至极"))
                         (:- '(pre () "关于 戴的USSS勋章 : 文贵 不加入任何组织 不会成立任何组织 不从政没兴趣; 勋章是USSS给的 但并没有加入"))
                         (:- '(pre () "不要关注琐碎的事 别被转移视线 真正要去关注 : 港币 人民币 国内经济; 孟宏伟怎么回的国 怎么消失的 与其相关的爆料; 王健的死因"))
                         (:- '(pre () "王岐山 为什么去 以色列 ?: 去掏美国的肛 去弄技术 顺带去沙特弄油 并想要用人民币结算"))
                         (:- '(pre () "王岐山 说 千万要小心 美国在 香港澳门 台湾 问题上有动作 (担心制裁 它们的钱的问题 家人私生子女的问题)"))
                         (:- '(pre () "把 共产党 和 中国人民 分开  共产党不能代表中国人民 它不能也不配"))
                         (:- '(pre () "因为 文贵 提前爆料 让 德州大学基金行动 被推迟 一周  看来不能乱报啊 (我: 哈哈哈)")))))
               (u (:- "郭文: " (@ "https://www.guo.media/posts/136557")
                      `(small ()
                              "(我: 从 咖啡杯 -> "
                              (span (:style "display: inline-block; text-align: center;")
                                    (span (:style "font-size: 50%;") "逦媛纳")
                                    (span (:style "display: grid;")
                                          ,(@ "https://leonardparis.com/en/" "Leonard")))
                              " -> " (span (:style "display: inline-block; text-align: center;")
                                           (span (:style "font-size: 50%;") "The art of flowers and prints")
                                           (span (:style "display: grid") "印花艺术"))
                              " -> " (span (:style "display: inline-block; text-align: center;")
                                           (span (:style "font-size: 50%;") "orchid")
                                           (span (:style "display: grid") "兰花"))
                              ")")))))
        (u (:- '(small () "2018.10.16")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/136387")
                      '(small () "(PPT还未完全公开)")
                      '(q () (pre () "
10月15日：这份30页的中共经济的真相的PPT在过去的两个月里，我在不同的场合与不同的人做了多次的演讲。可以说，每次演讲都极为震撼！赢得无数掌声👏毫不夸张的说．这是一个打开中共经济侵略西方骗局的第一把钥匙🔑！这绝对是一个史无前例的伟大的演讲稿之一！而这个所有的资料都是由挺郭会的战友们和我的律师．媒体团队共同完成！文贵在此表示衷心的感谢！ 文华负责GDP视频数据整理 文之．小老虎．负责制作视频 Skinner整理国内军费维稳费等数据 大卫小哥．负责数据整理并与彭博社（Bloomberg）和路透社（Reuters）比对 合理安排使用内部绝密信息 大卫还负责一带一路战略分析 令狐负责历史资料收集．外部联系．组织专家团队核对数据 Sarawei：CCPB．PPT项目总导．负责沟通郭先生．及他的团队．与所有的团队紧密工作！ 很快大家会知道这个PPT的力量！🙏🙏🙏🙏🙏🙏🙏🙏🙏"))))
               (u (:- "郭文(1分钟报平安视频): " (@ "https://www.guo.media/posts/136322" "10月15日：尊敬的战友们好：你们健身了吗！一切都是刚刚开始！")
                      '(p () (small () "疯狂洗脑 挡不住 土崩瓦解; 关注欧美正发生的大事; 港币 汇率 外汇储备的变化; 孟宏伟事后 又有好几人被抓; 让子弹飞一会"))))))
        (u (:- '(small () "2018.10.14")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/135879")
                      '(q () (pre () "10月13日：王岐山将出席以色列科技创新高峰论坛．访问埃及．沙特……等国家！他此次窜访是醉翁之意……伟大的智慧的战友们．你们懂的！一切都是刚刚开始！"))))))
        (u (:- '(small () "2018.10.13")
               (u (:- "视频: " (@ "https://www.youtube.com/watch?v=7aKh_vP4vQo"
                                  "10月12日：反盗国贼第一招第一式！(隔山杀盗)美国基金将抽回．不再．投资中国150家银行．金融机构！整个世界将开始调查．查封．中国高官洗钱．藏钱！")
                      (u (:- '(pre () "大连法院 判罚600亿人民币 约130亿美元 看到 中共国依法治国的虚假和荒唐"))
                         (:- '(pre () "(22:30) 第一招第一式"))
                         (:- '(pre () "快准狠"))
                         (:- '(pre () "发起 以美国 教育基金 和 各种国家基金 为基础的 一个 反对 中共国CCP 让相关中共国企业和在美上市的公司 的资产归0 的制裁行动"))
                         (:- '(pre () "行动伊始: 德州大学基金 正领头打击 被美国制裁的公司 和 针对中共国所有的金融机构 并提倡 所有美国基金不再投资中共国的金融机构")
                             (u (:- '(pre () "相关企业1700多家 有关金融机构150多个"))
                                (:- '(pre () "将抽回投入的所有资金"))
                                (:- '(pre () "通过全世界的对伊朗和独裁国家的制裁法规 延伸出了此次制裁"))))
                         (:- '(pre () "接下来的 第二式 第三式")
                             (u (:- '(pre () "提议 清算中共在西方的负债 包括国债"))
                                (:- '(pre () "提议 所有基金和投资者 需公布曾经合作过的 中共国 官员 政府 及其家人 的合作关系"))
                                (:- '(pre () "要求 通过法律系统 查封中共国持有的 美国和其它国家 的国债 包括 海外所有非法盗用的中共国资产"))))
                         (:- '(pre () "第二招 暂时不说 但到时将看到 会上升到另外一个层次"))
                         (:- '(pre () "是你们逼的")))))))
        (u (:- '(small () "2018.10.12")
               (u (:- "郭文: " (@ "https://www.guo.media/posts/135383")
                      '(q ()
                        (pre () "
Guo Media Press Conference: NHA and Wang Jian's Death
郭媒体新闻发布会：海航与王健之死

November 19th, 2018, 10am EST
2018年11月19日 美国东部时间 早上10点

The Pierre Hotel, New York
纽约 Pierre酒店 
"))))
               (u (:- "郭文: " (@ "https://www.guo.media/posts/135158")
                      '(small () "(大连法院宣判: 政泉公司强迫交易罪 处罚金600亿RMB 相关人缓刑)")
                      '(q ()
                        (pre () "
10月12日：这是一个伟大的具有重大历史意义的一天！我提出的中共在我中华大地的统治手段是盗国．……以黑治国．以警治国．以贪反贪．以假治国！今天的审判是一个国家政权．体制．倾尽盗国之全力．证明了郭七条在中国存在的真实性！及危害性！这也是最好的向全中国全世界人民展示的铁证！大连法院．的朋友们你们辛苦了！文贵仅仅代表文贵本人向你们致以＂不＂衷心的感谢！一切都是刚刚开始！
"))))
               (u (:- "郭文: " (@ "https://www.guo.media/posts/135006")
                      '(small () "(我: 我看到翻领 还以为只是美国国旗 看路德视频 约翰小哥说是特勤局USSS 不过因为看不清 还不能确定 倒是通过搜索 搞明白这东西的英文怎么说了 lapel  pin)")
                      '(q ()
                        (video (:src "https://d57iplyuvntm7.cloudfront.net/uploads/videos/2018/10/vid_1539294684_44803.MOV"
                                :controls "controls" :preload "metadata" :style "width: 150px; background-color:black")))))))
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
 "2018.10.14 13:22:56"
 (u (:- '(small () "2018.11")
        "南海军演")
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
 "2018.10.22 17:46:20"
 (u (:- "关注"
        (u (:- (@ "https://www.youtube.com/channel/UCm3Ysfy0iXhGbIDTNNwLqbQ/featured"
                  "路德社"))
           (:- (@ "https://www.youtube.com/channel/UCNKpqIqrErG1a-ydQ0D5dcA/featured"
                  "战友之声")))))
 (u (:- "事件"
        (u (:- '(small () "2018.10.20")
               "澳门中联办主任 郑晓松 死亡"
               (u (:- '(pre () "郭文贵: 是被杀 他与孟宏伟是好哥们"))
                  (:- '(pre () "中共官方: 中央人民政府驻澳门特别行政区联络办公室主任 郑晓松同志 因患抑郁症 于2018年10月20日晚 在其澳门住所 坠楼身亡")))))
        (u (:- "孟宏伟")))))

(news-to-topic
 "美国" ;; (human-date (get-universal-time))
 "2018.10.21 11:49:59"
 (u (:- '(small () "2018.10.19")
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
 "2018.10.21 10:45:34"
 (u (:- "主"
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
                   ,(@ "https://www.lawfareblog.com/china-supermicro-hack-about-bloomberg-report"
                       "The China SuperMicro Hack: About That Bloomberg Report")
                   (small () "2018.10.4")))))))
