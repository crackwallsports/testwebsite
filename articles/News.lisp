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
 (u (:- '(small () "2019.5.27")
        (u (:- "郭文(短视频 SNOW): " (@ "https://www.guo.media/posts/198394")
               '(q () (pre () "5月26日：SNOW 是路德先生的大粉丝！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/198270")
               '(q () (pre () "
5月26日：大家打开这位北大学生的链接…… https://youtu.be/gF8-h-tlBdg 和这个华盛顿邮报铍接之后……大家就会明白文贵在过去爆料中所说的中共对人的残害的令人发指的手段，以及希望大家保护好自己肛门的意思的出处！一切都是刚刚开始。 https://www.washingtonpost.com/world/asia_pacific/if-i-disappear-chinese-students-make-farewell-messages-amid-crackdowns-over-labor-activism-/2019/05/25/6fc949c0-727d-11e9-9331-30bc5836f48e_story.html?utm_term=.6e39a42304c2"))
               (u (:- `(cite () ""
                             ,(@ "https://www.washingtonpost.com/world/asia_pacific/if-i-disappear-chinese-students-make-farewell-messages-amid-crackdowns-over-labor-activism-/2019/05/25/6fc949c0-727d-11e9-9331-30bc5836f48e_story.html?utm_term=.df70be960a79"
                                 "‘If I disappear’: Chinese students make farewell messages amid crackdowns over labor activism")
                             (small () "2019.5.25 The Washington Post")))
                  (:- '(pre () "郭文图片内容 : 王健之子毕业典礼   彭斯副总统")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.26")
        (u (:- "郭文(报平安视频): " (@ "https://www.guo.media/posts/198225")
               '(q () (pre () "
5月26日：尊敬的战友们好，你们健身了吗？你往身上喝水了吗？在，六．四 到来之际……我们应该为天安门的英雄做一些实实在在的事情……海外那些拿．六．四血卡的民运骗子们……吃血馒头的．从不反共的欺民贼们……该停止了……请大家高度关注美国副总统彭斯即将在为64创世纪的演讲……停止猎杀．终止欺骗，,必须给64平反……,必须要有行动……消灭中共……2019年．将是最后的64纪念年．2020．64……将是新中国的国庆日！！！！一切都是刚刚开始！"))
               (u (:- `(cite () 
                             ,(@ "https://www.youtube.com/watch?v=7EAk7NjDVBo"
                                 "5月26日：2020年的6月4日……将是新中国的国庆日！！")
                             (small () "Youtube: 郭文贵")))
                  (:- '(pre () "彭斯副总统的演讲   金融大佬 各界大佬 们 的演讲和表态")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.25")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=nTvKW2f31Co" 
                           "5月25日文贵直播：G20会议将是美中新游戏开始！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "鲁仁达"))
                  (:- '(pre () "平台 让国人能有一个说真话的平台"))
                  (:- '(pre () "班农先生 就是 法治基金主席  法治基金的第一份签署的公告文件  已经开始使用法治基金的钱"))
                  (:- '(pre () "卡尔巴斯 奖 港币和人民币的研究"))
                  (:- '(pre () "班农先生 在全世界活动  对欧洲的影响  哈萨克斯坦"))
                  (:- '(pre () "让西方了解 中共的威胁"))
                  (:- '(pre () "卡尔巴斯  中共国科技公司分析 中共国银行分析"))
                  (:- '(pre () "中共 渗透 世界银行  表"))
                  (:- '(pre () "过去一个月 最累最苦的一个月 没时间睡觉 喝安眠药咖啡  忙 日本G20"))
                  (:- '(pre () "日本G20 是 中美新的游戏开始 世界秩序新的开始  能否一年内灭共 就看G20"))
                  (:- '(pre () "为什么中共反悔协议 ? 都是死 那就拖时间"))
                  (:- '(pre () "中共那几个人 被灭了后 中国会怎么样 什么人会上来  西方已经做好了准备"))
                  (:- '(pre () "爆料革命 是70年来 唯一明确要消灭共产党的"))
                  (:- '(pre () "6.12的香港  2020的台湾选举"))
                  (:- '(pre () "王健之死  王健的家人  生命威胁"))
                  (:- '(pre () "海航 王伟 明镜 陈军 "))
                  (:- '(pre () "假如... 美国也不会回到从前"))
                  (:- '(pre () "法治基金 未来"))
                  (:- '(pre () "美国也有骗子"))
                  (:- '(pre () "马蕊案"))
                  (:- '(pre () "33333333333"))
                  (:- '(pre () "G20 三个保证"))
                  (:- '(pre () "取消香港自贸区 台商离开大陆"))
                  (:- '(pre () "台湾真好骗"))
                  (:- '(pre () "祈福"))
                  (:- '(pre () "集体作战 别找事"))
                  (:- '(pre () "自己的屁惊醒自己")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.24")
        (u (:- "郭文(照片 手机): " (@ "https://www.guo.media/posts/197813")
               '(q () (pre () "
5月24日：尊敬的战友们好，明天星期六．5月25日直播在纽约时间．上午10:00到10:30之间开始．11:00左右开始转直播班农先生在哈萨克斯坦的演讲！大约又一个小时，12点半左右结束！明天不爆料，就是和大家聊聊天，这几天正在和相关机构．组织开会！相关的结果和接下来的行动择时向战友报告！一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/197802")
               '(q () (pre () "
5月24日：尊敬的战友们好锅媒体的App版1.6版本已经更新，请大家点击更换新的版本感激……战友们都过媒体的包容和耐心，一切都是刚刚开始！")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/197724")
               '(q () (pre () "
5月24日：谢谢伟大的战友面具先生制作这个视频！揭发亲民贼对中国老百姓的欺骗以及对美国政府在海外华人继续的欺骗假募捐，寄生虫以及严重影响海外华人形象的卑鄙行为"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=VFibdGL0i04"
                                 "5月24日：谢谢伟大的战友面具先生制作这个视频！揭发欺民贼对中国老百姓的欺骗以及对美国政府在海外华人继续的欺骗假募捐，寄生虫以及严重影响海外华人形象的卑鄙行为")
                             (small () "Youtube: 郭文贵")))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/197713")
               '(q () (pre () "
5月24号：肖建华的命运．和他包商银行的资产……又让文贵蒙对了……两年前我就说过．他的核心资产和他本人的命运的故事，现在都一一的发生了，我们会干掉这个盗国黑社会集团……拯救全中国的私人企业家……一切都是刚刚开始！"))
               (u (:- `(cite () "tianxaiyouxue12 @tianxiayouxue12 : "
                             ,(@ "https://twitter.com/tianxiayouxue12/status/1131870927937888257")
                             (small () "2019.5.24 Twitter")
                             (q () (pre () "明天系肖建华的包商银行 又要被盗国贼吃了 查了一下 又是某人的建设银行托管 、"))))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/197704")
               '(q () (pre () "
5月24号：尊敬的战友们好，你们健身了吗？你们往身上泼水了吗？打开现在，美国的电视都是在谈论C C P是多么的坏多么的赖，这就是两年前根本不可能发生的事情，现在已经成为全世界正义的人士共同的认可标准，这都是伟大的战友们的功劳，没有伟大的战友的爆料革命，这一切不可能是这样。一切都是刚刚开始！")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/197612")
               '(q () (pre () "
5月24号：从这个视频看来．＂美国川普总统．和美国人民．班农先生，真的要搬起石头砸自己的脚＂好害怕哟，听到这个视频中的播音员和他的逻辑．这个世界上只有一个伟大的共产党才能成功的领导全人类……爹亲娘亲不如共产党亲．这个伟大的思想，应该让全世界人接受成为人类新的文明．唯一的信仰！全世界的土地．水．女人．金钱．都应该归由共产党所有……让全世界的．天和地．生殖器．都要服务伟大的共产党，这才是人类唯一的真理……剩下的世界上一切麻烦都是＂美帝国主义制造的……资本主义的错误＂……天哪……天哪……CCP快疯了……真快成了南朝鲜了！衷心地感谢战友之声的战友们家上的字母和翻译……一切都是刚刚开始！"))
               (u (:- '(pre () "(我: 哈哈哈哈哈哈 打是死 不打也是死 不过 打得话 死得会难看一些)"))))
           (:- "视频: " "鲁仁达先生与文贵在线互访直播 : "
               (@ "https://www.youtube.com/watch?v=zvWs6Tv7Z5s"
                  "Guo Media Broadcast (Chinese): Chinese language based Broadcast")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "鲁仁达 讲述 经历 对中共的看法 婚姻"))
                  (:- '(pre () "中美关系 夫妻关系 贸易协定 要求保护自己国民"))
                  (:- '(pre () "爆料革命 以后 美国正在醒来"))
                  (:- '(pre () "班农先生  背后还有千百人以上 以反共 作为毕生事业"))
                  (:- '(pre () "台湾人 中共国人 区别  优秀文化被洗没了"))
                  (:- '(pre () "宗教信仰"))
                  (:- '(pre () "中共 对 台湾 要有一点动作"))
                  (:- '(pre () "民运 欺民贼  男人不提菜  绝食  护照 政庇  (我: 隔着十万八千里 绝食 有屁用啊)"))
                  (:- '(pre () "放马过来 (我: 放成马屁了 都拍领导脸上了)"))
                  (:- '(pre () "爆料革命 接下来 应该 主要做什么 ?"))
                  (:- '(pre () "海外华人形象"))
                  (:- '(pre () "一颗老鼠屎不能坏两锅汤"))
                  (:- '(pre () "信心"))
                  (:- '(pre () "祈福"))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/197492")
               '(q () (pre () "5月23日：这速度太慢啦……丢人了……选时间好好试试！一切都是刚刚开始！")))
           (:- "郭文(视频 法治基金捐款留言): " (@ "https://www.guo.media/posts/197489")
               '(q () (pre () "
5月23日 法治基金团队衷心感谢所有的捐款者和支持者！ 5/23 The Rule of Law Foundation Team heartfully thanks all of our supporters and donors!")))
           (:- "郭文: " (@ "https://www.guo.media/posts/197476")
               '(q () (pre () "
5月23号：尊敬的战友们好，你们健身了吗？你们往身上泼水了吗？一切都是刚刚开始！文贵建议战友打开下面的链接，这个是龚小夏博士．献给六四的最好的礼物《瞬间倒下的红色帝国》的视频．
https://youtu.be/OEY5qbHbuIM"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=OEY5qbHbuIM&feature=youtu.be"
                                 "红色帝国崩溃的瞬间")
                             (small () "2019.5.22 Youtube: Sasha Gong"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.23")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=Wsy3J3dcoz4"
                           "5月23日：爆料革命已经进入了全球共同灭CCP的关键时刻！CCP对台湾香港可能要搞点事情……😄😄😄")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "全世界 自动爆料 自动灭共"))
                  (:- '(pre () "纽约 康城 威彻斯特 秘密会议"))
                  (:- '(pre () "没饭吃可不绝食嘛 (我: 哈哈哈哈哈)"))
                  (:- '(pre () "32家公司 金融界 上市公司 中共官员  惩罚"))
                  (:- '(pre () "港币 卡尔巴斯"))
                  (:- '(pre () "台湾 大动作"))
                  (:- '(pre () "祈福")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.22")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/197246")
               '(q () (pre () "郭九条（双语版）"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=jSCAuUgeIPE")
                             (small () "Youtube: 郭文贵")))))
           (:- "郭文(短视频 报平安): " (@ "https://www.guo.media/posts/197237")
               '(q () (pre () "5月22号：尊敬的战友们好，你们健身了吗？你们往身上泼水了吗？一切都是刚刚开始！"))
               (u (:- '(pre () "国际战场 熊熊烈火"))))
           (:- "郭文: "
               (@ "https://www.guo.media/posts/197218") " "
               (@ "https://www.guo.media/posts/197217") 
               
               '(q () (pre () "
5月22：香港港币的噩梦！终结版！的《英文版》的分析！来了！衷心感谢在木兰倾心打造的视频，一切都是刚刚开始！

5月22：香港港币的噩梦！终结版！的中文版的分析！来了！衷心感谢在木兰倾心打造的视频，一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=1JKiEcu8G70"
                                    "May 22: Hong Kong's \"Chinese version\" of the \"Chinese version\" of the \"Heart Orchid\" heart orchid \"")
                             (small () "Youtube: 郭文贵")))
                  (:- `(cite () ,(@ "https://www.youtube.com/watch?v=y9dXmYvdpjw"
                                    "5月22香港港币的噩梦终结版的中文版来了。")
                             (small () "Youtube: 郭文贵")))
                  (:- `(cite () "中文翻译(PDF) : "
                             ,(@ "https://cdn.discordapp.com/attachments/552637676914868257/580870235788148736/af0b53cc8b7f4c9d.pdf")
                             (small () "Discord: 战友之声"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.21")
        (u (:- "郭文(视频): " (@ "https://www.guo.media/posts/197103")
               '(q () (pre () "2017年BBC采访郭先生（中英文版）"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=pIrEaChcz-o")
                             (small () "Youtube: 郭文贵")))))
           (:- "郭文(): " (@ "https://www.guo.media/posts/197091")
               '(q () (pre () "5月21日：看了．川普总统被侮辱这个视频……感慨良多呀，一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=HwPnCKEWRM8")
                             (small () "Youtube: 郭文贵")))))
           (:- "郭文(): " (@ "https://www.guo.media/posts/197074")
               '(q () (pre () "5月21号：港币会很快完蛋的最可信赖的证据……和数据，一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=bmr_tBaaXwU")
                             (small () "Youtube: 郭文贵")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=QKJ6saCV29Y"
                           "2019年5月21日：中共天机又来了……还要延续政权30年？")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "中南坑 派人 游说美方"))
                  (:- '(pre () "中共寄望 伊朗 中东之乱"))
                  (:- '(pre () "中共想排最后"))
                  (:- '(pre () "骂班农先生 美国右翼 有钱了  班农之流"))
                  (:- '(pre () "懦夫 指望命运"))
                  (:- '(pre () "华为 土耳其教授 蓝金黄"))
                  (:- '(pre () "祈福"))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/196998")
               '(q () (pre () "
5月20号：过去的半年．每当西方国家朋友问我关于华为的时候，我都推荐他们观看这个视频．这个视频可以快速了解华为企业文化……视频中的．服装．建筑．音乐．身体语言．装饰．等等……都是国家级的标准！但是是抄袭另外一个国家的标准．竟然完全抄袭俄罗斯总统就职典礼的一切！这样的企业文化这样的企业家能有创新吗？在中国哪个企业家刚玩这游戏！哪个企业家有这样的本事敢做这样的事情更！华为在过去的几个月想尽办法在网络上删除这个视频是因为什么呢？更夸张的是，这个华为奉为最最重要的教授！ERADL ARIKAN竟然是土耳其籍的＂维族人＂这个教授有没有被．蓝．金．黄．？曾经发生过什么事？华为付他多少钱？华为是怎么招待＂他＂的？文贵会在一定的时间和战友们爆料！保证大家都会比＂权力的游戏＂电视剧．还刺激！一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=Cb8CvSNzGZE"
                                    "5月20日：华为企业文化．只有CCP的亲儿子．才有这范儿……音乐．服装．建筑．身体语言．全是原创！")
                             (small () "Youtube: 郭文贵")))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/196884")
               '(q () (pre () "
5月20日：天哪CCTV骂谁谁发财！…………夸谁谁被抓……这是咋回事呢…… 30分钟后在FOX……电视专访班农！https://twitter.com/trish_regan/status/1130605369552723973/video/1‬"))
               (u (:- `(cite () 
                             ,(@ "https://www.youtube.com/watch?v=QuAZKNEcj2g"
                                 "Steve Bannon: China was not prepared to have Trump in office")
                             (small () "2019.5.20 Youtube: Fox Business"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.20")
        (u (:- "郭文(直播视频): " (@ "https://www.guo.media/posts/196795")
               '(q () (pre () "
5月20号：我很贵报平安直播回答，很多战友问我．现在是否是机会，投资香港和上海股票市场的机会……文贵，拜托所有的战友们千万不要把盗国们即将到来的灾难．变成我们的苦难，人生只能靠劳动或投资赚钱！千万不要投机呀！接下来．我们中国及香港的经济．金融．将一塌糊涂．远超出大家的想象……务必要慎重投资，慎重决定！文贵没有任何资格回答你们的问题！一切都是刚刚开始！"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=_LC2SDopKVY"
                                 "20195月20日：零晨四点．请战友们千万不要再跟着共产党的宣传：在股票市场上投机……不要将到国贼的一个灾难变成战友们的苦难！")
                             (small () "Youtube: 郭文贵")))
                  (:- '(pre () "刘士余 \"自首\"  内斗"))
                  (:- '(pre () "投资 不要投机  过山车   台湾 可能军事冲突   不赔钱就是挣钱"))
                  (:- '(pre () "祈福"))))
           (:- "视频: " "Lady May 2 上直播 " '(small () "Youtube: Rolfoundation法治基金")
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=E3RmoFwi__E")))
                  (:- `(cite () ,(@ "https://www.youtube.com/watch?v=2ajbEujhtw0")))
                  (:- `(cite () ,(@ "https://www.youtube.com/watch?v=slWwwHgOg9U")))
                  (:- `(cite () ,(@ "https://www.youtube.com/watch?v=h7R-_IR4wZY")))
                  (:- `(cite () ,(@ "https://www.youtube.com/watch?v=PpL8K-jmuQ4")))
                  (:- '(pre () "纽约海上风景"))
                  (:- '(pre () "重点是 中共蠢 骂班农先生  让 班农先生挣大钱了 哈哈哈")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.19")
        (u (:- "郭文(照片 图片): " (@ "https://www.guo.media/posts/196691")
               '(q () (pre () "
5月19号：尊敬的战友们好．很久以前，我就在我的视频给说过，证监会主席刘士余是王岐山的铁哥们，他的结局不是被抓就是被杀……这个家伙，曾经坑害了中国千万个小股民…这再次的证明了共产党这个体制的高邑邪恶！大家也可以发现一个规律，只要文贵一报海航重要的料的时候……共产党就报他们官员的料😹😹😹这已经成了一个必然，这就是共匪惯用的转移视线……接下来王岐山的哥们儿，吓死党更多的被抓和被杀！或其他的方式被惩罚，中南坑的斗争已经全面开始！一切都是刚刚开始！"))
               (u (:- `(cite () "Mischa @MischaEDM : "
                             ,(@ "https://twitter.com/MischaEDM/status/1130179268040900613")
                             (small () "2019.5.19 Twitter"))
                      '(q () (pre () "
刘士余自首中纪委

2019年5月19日深夜，中央纪委国家监委网站发布消息，中华全国供销合作总社党组副书记、理事会主任刘士余涉嫌违法违纪，主动投案，目前正在配合中央纪委国家监委审查调查。

>> 华尔街见闻 :https://wallstreetcn.com/articles/3531408
深夜重磅！刘士余主动投案
")))))
           (:- "郭文(报平安 短视频): " (@ "https://www.guo.media/posts/196575")
               '(q () (pre () "
5月19号：尊敬的战友们好，你们健身了吗？你们往身上泼水了吗？今天没有直播一天都要在外面开会，见朋友……一切都是刚刚开始！")))
           (:- "郭文(照片 健身): " (@ "https://www.guo.media/posts/196429")
               '(q () (pre () "5月18日：尊敬的战友们好．你们健身了吗？你们往身上泼水了吗？一切都是刚刚开始！")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/196360")
               '(q () (pre () "美国国会共和党参议员苏利文：共和党和民主党都对中国不断反悔承诺的容忍度已降为零！"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=ppAXy-618BU"
                                 "白宫下达华为禁令 国会两党议员表示力挺")
                             (small () "2019.5.16 Youtube: 美国之音中文网")))))
           (:- "郭文(视频 法治基金捐款留言): " (@ "https://www.guo.media/posts/196359") " "
               (@ "https://www.guo.media/posts/196345")
               '(q () (pre () "

Appreciate all the donors to Rule of Law Foundation and Society!

5月1 8号：尊敬的战友们好．文贵将战友们在对法制基金捐款时的极少部分留言！做成视频发给大家！衷心的感谢战友们的支持建设一个属于我们共同的家．法制基金．法治基金的同士们正在全力以赴，与各个战线的战友们共同作战！实现喜马拉雅的使命！一切都是刚刚开始！")))
           (:- "郭文(图片): "
               (@ "https://www.guo.media/posts/196329") " "
               (@ "https://www.guo.media/posts/196324")
               '(q () (pre () "
5月18日：这些照片中的人与王健被杀什么关系！之二．（战友们的敏感度不够了……

5月18日：这些照片中的人与王健被杀什么关系！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.18")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=JIjvAMOG0BU"
                           "5月18日：文贵谈台湾保护法、香港自贸协定区、华为在美国被禁止、李嘉诚的500亿假烂账与江志诚的盗国关系、亚洲文化节开幕！钓鱼后首次公布王健被谋杀前酒店高清视频！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "开头视频: CCP恶魔开始绑架全中国人民对美国以及世界进行核讹诈 核恐吓   邓小平1974联合国大会演讲   2019.5.11香港立法会建制派与民主派 就修改\"逃犯条例\"大打出手")
                      (u (:- '(pre () "视频结尾 打脸了 扯淡前 先把你们偷的钱还回来 让你们子女回来保卫你们的国 (我: 笑而不语)"))))
                  (:- '(pre () "花粉敏感 药 黑接骨木"))
                  (:- '(pre () "台湾保护法 以及 重新审核香港自贸区协定 的重大意义"))
                  (:- '(pre () "(18:00) 华为及相关70家企业在美被惩罚   用一个故事来解释"))
                  (:- '(pre () "买卖不成仁义在"))
                  (:- '(pre () "任志强"))
                  (:- '(pre () "举报 社交媒体 限制 政治言论")
                      (u (:- `(cite () "The White House @WhiteHouse : "
                                    ,(@ "https://twitter.com/WhiteHouse/status/1128765001223663617")
                                    (small () "2019.5.15 Twitter")
                                    (q () (pre () "
The Trump Administration is fighting for free speech online.
 
No matter your views, if you suspect political bias has caused you to be censored or silenced online, we want to hear about it! 

http://wh.gov/techbias
"))))
                         (:- `(cite () ,(@ "https://whitehouse.typeform.com/to/Jti9QH")
                                    (small () "whitehouse.typeform.com")))
                         (:- `(cite () ,(@ "https://www.youtube.com/watch?v=QKi_KjbkqhY" "《青年热线》第5期。重磅直播：Trump特朗普白宫推出一个在线门户网站，收集已被禁止和/或被暂停社交媒体平台的用户的故事。手把手教你怎么投诉！我们拿回属于我们的言论权")
                                    (small () "2019.5.15 Youtube: Inty")))))
                  (:- '(pre () "(33:00) 李嘉诚 张子强 5000万 屈臣氏 江志成 新加坡淡马锡何晶   遣返条例  因果报应"))
                  (:- '(pre () "郭七条 梦中郭九条"))
                  (:- '(pre () "中国银行 阿里巴巴  崩塌"))
                  (:- '(pre () "亚洲文化节"))
                  (:- '(pre () "胡锡进 CCTV 骂 班农  欺软怕硬"))
                  (:- '(pre () "当下危机委员会 川普总统  民间机构 搞大了"))
                  (:- '(pre () "(1:00:00) 中国人民是大地的盐  不可或缺"))
                  (:- '(pre () "华为在英国是0"))
                  (:- '(pre () "中国人是好的 但被中共绑架 毁坏了国人的形象和声誉"))
                  (:- '(pre () "(1:12:00) 王健之死  视频  钓鱼  手机"))
                  (:- '(pre () "王健身边人 死 泰国旅游 船难  台湾关系"))
                  (:- '(pre () "私人企业们"))
                  (:- '(pre () "祈福"))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/196147")
               '(q () (pre () "
5月18号：尊敬的战友们好！两个小时以后的直播．没有什么惊天动地的事儿，就是有关最近，大连法院，北京法院对我们员工和家人进行的以法抢劫的一个小回应……有些小承诺兑现一小点点而已！请大家不要抱期望值太高，文贵就是和大家聊聊天，文贵从来不愿意．搞标题党．耸人听闻的事情．就是一个正常的星期六直播，希望不要影响到大家的周末休息！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: Snow 踢 球 踢 王八"))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/195803")
               '(q () (pre () "
5月17号：尊敬的战友们好．因特殊原因．明天．即5月18日上午9点的直播不能允许任何人转播！包括之前经郭媒体授权的战友们！文贵在此表示万分的抱歉，详细原因明天直播后大家就会明白。任何人明天转播郭媒体的直播将被追究相关责任！ 郭媒体今天已经更新1.5新版本，所有的使用郭媒体的战友可以尽快更新！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: 人民币对美元汇率"))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/195723")
               '(q () (pre () "
5月17日：刚刚结束了一个美妙的午餐与会议．我们的法治基金又一次得到了更高层次的合作……我们的宗旨与目标．将联合起来世界上最强大的正义的力量！一切都是刚刚开始！"))
               (u (:- '(pre () "劳斯莱斯 SUV 库里南")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.17")
        (u (:- "郭文(图片): " (@ "https://www.guo.media/posts/195643")
               '(q () (pre () "
5月17号：尊敬的战友们好你能健身了吗？你能往身上泼水了吗？今天没有直播，明天星期六．上午纽约时间9:00在郭媒体直播，一切都是刚刚开始！")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/195534")
               '(q () (pre () "
5月16号：川普总统今天回到了纽约他的家此时此刻的纽约万分的沸腾，大家猜猜川普总统先生都会与谁见面呢？请关注总统今天晚上及这几天的推文．我想很多信息都会与我们的爆料革命有关系！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.16")
        (u (:- "郭文(报平安 短视频): " (@ "https://www.guo.media/posts/195457")
               '(q () (pre () "
5月16号：尊敬的战友们好！今天明天都没有直播！文贵正在全力以赴地．与我们各个领域的战友们紧密合作，在全世界开展我们的行动计划，星期六纽约时间上午9:00北京时间晚上9:00文贵会在郭媒体．直播，向大家报告，一切都是刚刚开始！"))
               (u (:- '(pre () "伟大的时刻"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/195408")
               '(q () (pre () "
5月16号：尊敬的战友好！香港，台湾，新疆，西藏．……将迎来最美好的时间．期望大家绝对珍惜关继续努力……接下来你们会听到过去几十年想都不敢想的好消息！法制基金的团队们与背后的支持者正在全力以赴的创造的奇迹……实现目标！莘县阳谷县搭县！咱们走着看。一切都是刚刚开始！"))
               (u (:- `(cite () "Kyle Bass @Jkylebass : "
                             ,(@ "https://twitter.com/Jkylebass/status/1128971904348545024")
                             (q () (pre () "
POTUS-immediately revoke HK’s special status with the US as they have lost their “autonomy”. Do this now to keep our citizens that live in and visit HK safe from being “legally” kidnapped and disappeared  into china.#RuleOfLaw ⁦@SecPompeo⁩"))))
                  (:- `(cite () "Reuters 路透中文 @ReutersCN : "
                             ,(@ "https://twitter.com/ReutersCN/status/1128825703896616960")
                             (q () (pre () "华为及70家关联企业被美国列入贸易管制黑名单"))))
                  (:- `(cite () 
                             ,(@ "https://www.youtube.com/watch?v=XnlSULPJHtQ"
                                 "神準預言中美貿易大戰 郭文貴直播:台灣命運...│廖筱君主持│【君臨天下事】20190515│三立新聞台")))))
           (:- "郭文(短视频 Snow): " (@ "https://www.guo.media/posts/195280")
               '(q () (pre () "5月15号：一个牛耳朵的诱惑，SNOW兴奋不己！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.15")
        (u (:- "郭文(视频): " (@ "https://www.guo.media/posts/195209")
               '(q () (pre () "
5月15日：感谢战友之声．为视频加上的中英文字幕！万万分感谢所有背后默默无闻的战友们！在台后的辛勤工作。这是近几年来我看到记录历史的最好最有意义的视频！所有中国人都应该看的视频……我刚刚让几位美国朋友看！他们非常的激动！他们认为美国了解中国太少了！这个视频太重要了……这个视频会传遍全世界！这就证明了．14亿中国人被绑架被敲诈的真实因与果！和任何一个有良知的正常中国人都应该知道的历史真相！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文视频: 1974.4.10 邓小平 联合国大会第六届特别会议"))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/195170")
               '(q () (pre () "
5月15号：尊敬的战友好！很久以前，我曾经说过，李嘉诚的长江实业系……有巨额的烂帐。李嘉诚的屈臣氏也是最大的洗钱白手套，而与江家……等国内几个盗国贼集团，包括中国银行一起合作盗骗人民的财富．任何人持有的长江的股票是在2018年12月份以前买的，务必保留．未来法制基金将于这个时间以前的小股东联合起来，集体诉讼索赔一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://tw.news.yahoo.com/李嘉誠-長和-被指藏577億負債-郭文貴-他是江澤民家族白手套-033036908.html"
                                 "李嘉誠「長和」被指藏577億負債 郭文貴：他是江澤民家族白手套")
                             (small () "2019.5.15 Yahoo")))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/195168")
               '(q () (pre () "Steve Bannon Trump is doing the right thing in challenging China")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/195130")
               '(q () (pre () "Watch CNBC's full interview with Steve Bannon on the US-China trade war"))
               (u (:- `(cite () "" ,(@ "") (small () "")))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/195110")
               '(q () (pre () "Steve Bannon: There is ‘no chance’ Trump is going to back down in the China trade war")))
           (:- "郭文(): " (@ "https://www.guo.media/posts/195106")
               '(q () (pre () "
5月15日：刚刚看了这个视频节目．真的不好意思啦……那天的直播．鼻涕拉瞎的……因为一夜未睡．壮态极差……半梦半醒之间的与战友聊天的视频！一下子恁到台湾大美女．君临天下．那去了……那天的音质也太差劲了！大家快去关注这个超级美女的YOUTUBE……频道吧……一切都是刚刚开始！"))
               (u (:- `(cite () 
                             ,(@ "https://www.youtube.com/watch?v=XnlSULPJHtQ"
                                 "神準預言中美貿易大戰 郭文貴直播:台灣命運...│廖筱君主持│【君臨天下事】20190515│三立新聞台")))))
           (:- "郭文(图片): "
               (@ "https://www.guo.media/posts/195066") " "
               (@ "https://www.guo.media/posts/194979") " "
               '(q () (pre () "
5月15日：请战友关注 yhoo Twitter．账号奇迹将再次yhoo 这里发生！一切都是刚刚开始！Steve Bannon, cheering trade war, hopes for government to fall — in China


5月14日： Yahoo！网站是人类互联网的开始，近几年虽然被CCP欺骗！被马云差点给骗死，但我深信不疑．这个英雄一定会回到世界互联网最高端！大家拭目以待！一个能创造辉煌还能遇难呈祥的！一个时代伟大的创始者之一……一定还会创造一个新的高度。这就是，yahoo.com……！！！！！
这篇新闻已经成为世界上过去的20个小时，最高搜索和阅读者之一的内容！一切都是刚刚开始。🙏🙏🙏🙏🙏🙏
https://news.yahoo.com/steve-bannon-cheering-trade-war-hopes-for-government-to-fall-in-china-090000259.html
"))
               (u (:- `(cite () "Yahoo @Yahoo : "
                             ,(@ "https://twitter.com/Yahoo/status/1128246399190093825")
                             (small () "2019.5.14 Twitter"))
                      '(q () (pre () "
Steve Bannon, cheering trade war, hopes for government to fall — in China
")))
                  (:- `(cite () ,(@ "https://news.yahoo.com/steve-bannon-cheering-trade-war-hopes-for-government-to-fall-in-china-090000259.html"
                                    "Steve Bannon, cheering trade war, hopes for government to fall — in China")
                             (small () "2019.5.14 Yahoo")))
                  (:- `(cite () "中文翻译: " ,(@ "http://littleantvoice.blogspot.com/2019/05/steve-bannon.html")
                             (small () "2019.5.14 Blogspot: 战友之声")))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/194887")
               '(q () (pre () "
5月14号：恭喜台湾彭文正先生．与他的巜政经关不了》的节目，现在快赶上文贵的在世界媒体的待遇级别了……看来彭文正先生的节目对他的敌人造成的实质的威胁，才能享受如此的待遇！看来彭文正先生也要开始健身了，一切都是刚刚开始。"))
               (u (:- `(cite () "Godfather ✊ ✊ ✊ 🔥G @godfather3721 : "
                             ,(@ "https://twitter.com/godfather3721/status/1128304024015462400")
                             (small () "2019.5.15 Twitter"))
                      '(q () (pre () "
政經關不了（完整版）｜2019.05.14 https://youtu.be/2ecaYOWYKOs  来自 @YouTube
—————
《政经关不了》YouTube频道打赏功能被坏人举报，YouTube用了两条非常可笑莫须有罪名！

这个世界真的是有坏人存在，
你不愿看《政经关不了》你不看就是！你不愿意打赏你不打赏就行了！干嘛给YouTube施压停止打赏功能？
")))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/194861")
               '(q () (pre () "
5月14号：大连法院昨天依法抢劫，这是他们在我们的政泉小区张贴的法院公告！大连法院给郭文贵的600亿罚款使用的罪名是强迫交易罪．而成立强迫交易罪的核心证据．核心人物，就是东方集团的张宏伟！和张宏张宏伟在开发银行拿走的几百亿美元贷款在巴基斯坦搞石油开发至今一分未还……在海外大量洗钱！曾有政法委的官员给我打电话说，海航的损失要让我从大连法院上受到惩罚……说张宏伟一人的证据就可以罚我几百亿！现在都变成事实了，请大家记住！我会让张宏伟．及东方集团．和海航集团．付出10倍的价值……的惩罚……拭目以待！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.14")
        (u (:- "郭文(诉讼书图片): " (@ "https://www.guo.media/posts/194749")
               '(q () (pre () "
5月13号：熊宪民又名屎诺．这个烂到家了个臭流氓又输了，这是他第N次输了，他末来会输的更惨，美国的法律是公正的．任何玩弄美国法律和法官的人！没有不得到惩罚的．熊宪民在玩火．他5叶宁等畜生在玩弄美国的法律……不要脸到已经没有任何人可以比较的程度。这个下三滥从2013年，与博讯．韦石．一起开始造谣．威胁文贵……关于文贵的事情，从未有一件说过是真的一件事对的。这些臭流氓一次一次地到法庭．及在社交媒体骚扰威胁文贵及家人……已经给文贵及家人同事造成了巨大的损失。熊线民等这几个畜生是．文贵永远不会原谅下三烂……一定尊依美国法律．讨回公道，他必须为此付出代价，一切都是刚刚开始！")))
           (:- "郭文(短视频) : " (@ "https://www.guo.media/posts/194717")
               '(q () (pre () "
5月13日：比爹娘还亲的共产党！是否能回答你们认为这些猪狗不如的老百姓！是什么原因与津巴布韦国家一样，人类倒数第二的社会福利！养老保险！社会保障！为什么共产党的官员在全国各地都有疗养院！养老院！干部休养所．吃喝．性．按摩。都是由老百姓血汗钱来支付！而老百姓得了病！只能等死！全世界只有一个国家！连北朝鲜都不是．得了病以后的老百姓先付钱后看病。中国共产党是人类唯一一个给老百姓不提供社会保障社会福利的政府！这个邪恶的政府让中国的90%的人民．病不起．死不起．却心甘情愿的为这个邪恶的一个党付出一切！这是中国人在世界上得不到尊重的根本原因！一切都是刚刚开始。"))
               (u (:- '(pre () "郭文视频: 领导干部 疗养 巨大消耗 占GDP比例"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/194712")
               '(q () (pre () "
5/10/2019 Steve Bannon and the Military Society. Broadcast from Oslo. 班农先生和军方社会，来自挪威首都奥斯陆的直播"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=WzVM2_oPMCk"
                                 "5/10/2019 Steve Bannon and the Military Society. Broadcast from Oslo")
                             (small () "Youtube: 郭文贵")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=2M15FYJrNSg"
                           "5月13日 文贵报平安视频 关注金融市场 中共真的完了 ——JUSTICE")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "顾问 顾上也得问 顾不上也得问"))
                  (:- '(pre () "昨天 汇率 期货 石油  金融市场交易  不看好中共国经济 对未来根本不抱任何希望"))
                  (:- '(pre () "昨天 与中共高层有关系 有情报 的 赚大钱了  老百姓都是玩具 玩弄国内经济 国际金融"))
                  (:- '(pre () "中共是真完了 它们都在砸船弃船  但愿中国老百姓少受点迫害 但愿时间不要太长")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.13")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=5MZVXlixvrM&feature=youtu.be"
                           "七哥与战友们分享非常有效的治打喷嚏，鼻塞，流鼻涕的药💊")
               '(small () "Youtube: Mulan Chuanqi")
               (u (:- '(pre () "吸冰法"))
                  (:- `(cite () "Sambucol 黑接骨木 : "
                        ,(@ "https://www.amazon.com/s?k=sambucol&ref=nb_sb_noss_1")
                        (small () "Amazon"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.12")
        (u (:- "郭文(短视频): " (@ "https://www.guo.media/posts/194485")
               '(q () (pre () "
5月12号：文贵可以和任何人打赌．中美贸易协议，最终一定会达成．而且一定是百分之百按照美国的要求达成．而后中共会在内部宣布自己为国家争取了巨大的利益．获得了空前的胜利……对外声称达到了双赢，而且会举国欢腾．并感谢王岐山及几个盗国贼．并为他们歌功颂德。这是必然的最终结局．原因就是美国川普总统的实力不可征服！共产党的领导呓术不会有什么新花样……川普总统这一次的提升关税的决心和行动，让他们在50年来第一次体会到了美国的实力与行动力！另外C C P根本没有实力挑战美国和川普总统！又加上寄托美国内部的政治斗争干倒川普总统的可能性越来越低！在提升关税后的C CP控制下的经济根本不可能撑到2020年！就像一个癌症病人最后只要能多活一1秒钟让他吃什么都愿意的道理一样．因为没有选择……他们也都知道他们的政治体制撑不过2020的！所以极大可能在日本的G20会前后和中共签协议！像这个视频这个虚张声势的选手的动作．结果！一模一样……一切都是刚刚开始！"))
               (u (:- '(pre () "郭文视频: 拳击赛 边挑衅边逃跑"))))
           (:- "郭文(短视频 Snow): " (@ "https://www.guo.media/posts/194469")
               '(q () (pre () "5月12日：应战友们的要求．发一个snow视频，这是与SNOW散步的小视频，谢谢战友们对SNOW的关心，一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/194448")
               '(q () (pre () "
5月12日，刚刚在丰田汽车公司．为我们的喜马拉雅农场．定制了特殊版的丰田皮卡两台．两台超级丰田SUV和两台丰田防弹车．加在一起的台车总价还没有一个劳斯莱斯库南克Suv价格贵，但是他却是越野中最专业很耐用安全的．完成我的军彩版设计建造送给我们农场以后！再与战友们一起分享，这是我们战友们一起在喜马拉雅农场时的玩具！一切都是刚刚开始！"))
               (u (:- `(cite () "丰田 皮卡 : Tundra : "
                             ,(@ "https://www.toyota.com/tundra/")))
                  (:- `(cite () "丰田 SUV : 4Runner TRD Pro : "
                             ,(@ "https://www.toyota.com/configurator/build/step/model/year/2019/series/4runner/model/8674")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=MwlPUlmehzU"
                           "5月12日：母亲才是我们的国．父母才是我们的家！我们的家！愿中国所有的母亲，不要把自己的儿女送给共产党这个非法组织！任何一个加入共产党的家庭都有可能将受到全世界的制裁，未来无法到世界各地上学！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/194367")
               '(q () (pre () "
5月12号：尊敬的战友们好．40分钟后，也就是纽约时间上午9:00．北京时间晚上9:00．文贵直播谈谈．我如何过母亲节！一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/194305")
               '(q () (pre () "
5月12号：尊敬的战友们好！今天是母亲节，文贵在纽约的凌晨3:00向所有的母亲们致以衷心的问候．和万分的敬意🙏🙏🙏🙏🙏🙏🙏🙏🙏

海航正在世界各地更换自己的名称．和在世界上多个公司更换实际控制人，这是海航与盗国贼盗国计刬的第二部。金蝉脱壳．撇清债务．装穷装傻，最终就是敇掉王岐山，刘呈杰．贯君．陈峰等人．从中国进出口银行．中国国家开发银行……中国银行……以贷为盗几千亿人民的血汗钱吗？这时候的中纪委监察部去哪儿了！中国的经济警察去哪了，中南坑的常委呢？难道你们看不见吗？现在咋不打铁了呢……是因为自己不硬了吗？没问题，我们的爆料战友们会看清楚，搞明白……人民的血汗钱一分都不能少的要还给人民！

【海航 在阿姆斯特丹已經換名號。不叫HNA 更名為 TipEurope 這是它的網站 https://www.tipeurope.com/news/i-squared-capital-finalized-acquisition-tip-trailer-services】"))
               (u (:- `(cite () ""
                             ,(@ "https://www.tipeurope.com/news/i-squared-capital-finalized-acquisition-tip-trailer-services"
                                 "I Squared Capital finalized acquisition TIP Trailer Services")
                             (small () "2018.8.7 TipEurope"))
                      '(pre () "(我: I Squared  哈哈哈 我方 我好方)"))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=7mzapnARcBA"
                           "5月11日：文贵谈中美贸易谈判失败的真正原因，台湾和香港人民的未来")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/194213")
               '(q () (pre () "
5月11日：刚刚提高了关税后的美国经济是近些年来前所未有的好，这里真的是人人安居乐业人欢狗叫．一片太平。在这个曼哈顿居住人以上50%的人都是外来移民，在这里有上千个不同的民族．几百个不同的宗教信仰背景的人们！在这里居住创业！每年的GDP 1．2万亿美元，相当于一整个广东的GDP总和。这里是现代音乐，现代艺术，现代建筑，最新科技以及世界上最大的股票价交易市场！这里也是全世界金融的核心，全世界的精英和艺术家在这里共同相处，创造人类的现代文明．世界上77%的百亿富豪居住在这个曼哈顿城！这就是共产党永远做不到的！改革开放几十年！从未见一个世界的百亿富豪定居在中国，北京和上海，而中国的所有的富豪及高官．几乎全部都将自己的子女或者家人．送到了他们嘴上痛恨的美帝国主义．曼哈顿．包括王岐山．孟建柱，孙立军，包含所有的常委，他们的子女和家人，这就是比爹和娘都亲的共产党．让你爱国的原因，只有你爱他的国，他才能控制你的财富．你的儿女．你的未来．你的健康．你的生命……你只能在梦中得到你想要的一切一切！亲爱的同胞们如果再不醒来，你们．或你们的子女永远一定是你没有机会来这样的地方，而我们的家乡，如果有一个合法的真实的政府，我们会建设的的比这还漂亮，这就是需要我们拥有一个法治的国家．没有共产党的政权国家！一切都是刚刚开始！")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/194211")
               '(q () (pre () "5月11日这行动像谁呀？"))
               (u (:- '(pre () "郭文视频: 搬起锤子砸自己脚")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.11")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/194085")
               '(q () (pre () "
5月10号：尊敬的战友们好！明天5月11号上午9点正．北京时间晚上9点正在郭媒体直播！明天主要谈中美贸易谈判的失败及香港的立法会事件！不爆料！一切都是刚刚开始！"))
               (u (:- '(pre () "Live-streaming av Steve Bannon fra Oslo Militære Samfund")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.10")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=hBXd4dS22qU"
                           "2019年5月10日郭文贵先生生日跟战友们谈谈母亲，父母，家庭🙏")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(直播视频): " (@ "https://www.guo.media/posts/193919")
               '(q () (pre () "
5月10号：文贵50岁生日．谈谈家庭和谐．对中国人的重要．以及共产党严重的破坏了中国几千年赖以生存的最核心的社会关系．家庭．以及文贵对家庭的一些看法，愿天下的母亲父亲都能得到孩子们的尊敬和孝敬，愿天下人都做一个好的母亲和父亲！只有改变中国的政治体制！消灭共产党，中国人的家庭才能和谐，一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.9")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=Ax83KEmQ9IA"
                           "2019年5月9日5月9号：尊敬的战友们好！近两日来，由于中共玩弄的中美贸易协议这个重大事件！全世界的金融市场都在惊慌之中，都在为了长远的未来在中国销售生活用品的长期投资的按排！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "中美贸易谈判 金融市场巨大打击 撤资中国 布长线卖粮油生活用品"))
                  (:- '(pre () "中共在往死亡的路上狂奔"))
                  (:- '(pre () "美欧有动作 WTO  台湾和香港有大动作  台湾保护法  香港自贸区 汇率   组合拳"))
                  (:- '(pre () "日本 欧洲 等 跟上 "))
                  (:- '(pre () "中共控制的国有企业 过街老鼠"))
                  (:- '(pre () "祈福")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.8")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=uDV1AjSpcDs"
                           "2019年5月8日5月8号：尊敬的战友们好，你们健身了吗？文贵聊聊．为什么中方要求美方不能公开中美的贸易协议内容！为什么文贵的梦语．郭九条．在国内引起了巨大的反响！一切都是刚刚开始！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(图片 照片): " (@ "https://www.guo.media/posts/193251")
               '(q () (pre () "
5月8号：因文贵诉夏业良流氓畜生䅁件．今天本来在DC费吉尼亚法院指定的地点．庭外问话．继夏畜在上次的开庭当中被法警羁推出去后．流氓律师叶宁做了夏畜的律师．今天竟然敢不到庭接受质询……公开抵抗法官命令！这样的畜生竟然是北大的教授！北大出来的怎么样这么多这种烂东西！还以有文化人自居。这是典型的共产党的渣渣男！这一副无法无天的嘴脸，只有共产党才有！美国的法律一定会惩罚这种混蛋，接下来对他还会有更多的诉讼案件……夏畜生的未来将一直在他最害怕最不敢去的法庭中度过！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.7")
        (u (:- "郭文(照片): " (@ "https://www.guo.media/posts/192959")
               '(q () (pre () "5月7号：尊敬的战友的好！战友给我发个信息，我一时回不了，请大家原谅！稍后会一一回复，万分抱歉！一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/192949")
               '(q () (pre () "
5月7日：看看我现在在哪里🧐？在干啥呢？基金送给我生日礼物竟然是几台车……太小气了……去年的同一天我也在人这里收到了生日礼物……奔驰迈巴赫……欺民贼们在网络上一片叫喊……郭文贵没有钱了……那迈巴赫是假的……这个二楼的VP接车地．欺民贼们你们到这里擦则所的机会都没有！一切都是刚刚开始！")))
           (:- "郭文(直播视频): " (@ "https://www.guo.media/posts/192885")
               '(q () (pre () "
5月7号：尊敬的战友们好，你们健身了吗？你们往身上泼水了吗？昨天晚上孔子．老子．孙子．秦始皇．汉武帝．毛泽东．邓小平．集体开会后给我托梦了……让我在这儿奉旨胡说八道，如果大家觉得真是胡说八道就当是梦话，如果大家觉得有道理啊，请大家直接打电话给以上人员核实．电话号码王岐山孟建柱孙立军战友，请大家去跟他们要电话号码吧。……推翻共产党以后，台湾，香港，新疆，西藏，广东，应该马上实行中国人民特色的联邦自治式政治制度……全国的土地拥有权归还人民．媒体独立．司法独立．军队国家化．教育免费．医疗免费！马上降，现在中国所有监狱的人释放恢复自由，马上叫海外到过谁的钱归还给中国人民……免去所有中国人欠所谓银行的债务．建立世界和平相处的千种办法！让中国人成为世界上最受欢迎的人！一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=d5sGf98nfbQ"
                           "May 7, 2019共产党被推倒，释放所有监狱里的犯人．土地拥有权归人民所有．西藏，新疆，台湾．香港实施百分之百的自治！你们觉得可能吗？")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/192742")
               '(q () (pre () "5月6号：这是俺媳妇给俺做的乐高保时捷跑车．这是多年前我曾在德国驾驶的跑车系列之一，太棒了，愿天下所有的人家庭幸福快乐，一切都是刚刚开始！"))
               (u (:- `(cite () "Lego : Porsche 911 GT3 RS : "
                             ,(@ "https://shop.lego.com/en-US/product/Porsche-911-GT3-RS-42056")
                             (small () "Lego Shop")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/192732")
               '(q () (pre () "5月6日：每一个中国人都有能力．智慧．拥有这样的生活，只要中国没有共产党，没有盗国贼……每个中国人都会成为世界上最成功的人，我深信不疑！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.6")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=iIrHro8KsxY"
                           "May 6, 2019文贵直播谈谈，为什么川普总统要突然间的停掉，中美贸易协定共产党必须还回属于14亿中国人民的一切财富一切权力！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/192727")
               '(q () (pre () "
5月6号：政经关不了．这个节目和彭文正先生清新，帅气的形象！没有了格格的衬衫和带斜条纹的领带的彭文正先生！从不自由传统的的媒体方式！到现在转战自由的现代网络媒体！为台湾的自由而战！用现代的科技，唤醒台湾人民！和世界人民！几天来几万的订阅量！和80几万的观看次数！已经证明了彭文正先生的影响力！和他的专业水平！以及台湾．潜在的被威胁的被打压的追求自由的力量，我们将全力以赴支持大帅哥彭文正先生……请大家订阅《正经关不了》YouTube 频道，一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/channel/UCv-VvrlvdMfA-C4LEJubkpg"
                                    "政經關不了")
                             (small () "Youtube")))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/192715")
               '(q () (pre () "5月6号：这几件衣裳，这几双鞋子！咋样？亲爱的战友们！")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/192686")
               '(q () (pre () "
5月6号：对CCP的关税增加！停止欺骗性的贸易协议谈判，让川普总统躲过了一大劫难！加速了C C P的灭亡！川普总统又将进一步地赢得2020年的总统选举！无容置疑！川普总统将创造一各又一各的奇迹的同时，而且会改变世界，我深信不疑。中美贸易的谈判早在几个月前，我就说过一定是以荒谬的的结果结束，今天终于有了结果，王岐山，作为背后的救火队长和中国的国时，应该为这一巨大的历史事件复查，所有的责任，由他设计的一带一路2025．2035．2049．一带一路！将中国人送进地狱．一次又一次的重大事件！证明了王岐山是祸害中国的人魔鬼！中国人的走向灾难的罪魁祸首！一切都是刚刚开始！")))
           (:- "郭文(短视频 Snow): " (@ "https://www.guo.media/posts/192636")
               '(q () (pre () "
5月6日，尊敬的战友们好，你们健身了吗？你们往身上泼水了吗？文贵受到snow的严重骚扰……因为文贵马上要参加两个紧急的会议，暂时不能直播，在会议结束后我会择时直播谈谈！为什么川普总统的一个推文．价值3万亿人民币！和美国是怎么搬起石头砸自己的脚的！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.5")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=1en2pmA5OKE"
                           "5月5号：文贵与班农先生就有关中美贸易协议停止！美国对共产党实行25%的关税惩罚！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/192389")
               '(q () (pre () "Miles KwokHua wei is PLA, The electronic products processed in China there is a back door")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/192315")
               '(q () (pre () "
5月5号：对CCP的关税增加！停止欺骗性的贸易协议谈判，让川普总统躲过了一大劫难！加速了C C P的灭亡！川普总统又将进一步地赢得2020年的总统选举！无容置疑！川普总统将创造一各又一各的奇迹的同时，而且会改变世界，我深信不疑。中美贸易的谈判早在几个月前，我就说过一定是以荒谬的的结果结束，今天终于有了结果，王岐山，作为背后的救火队长和中国的国时，应该为这一巨大的历史事件复查，所有的责任，由他设计的一带一路2025．2035．2049．一带一路！将中国人送进地狱．一次又一次的重大事件！证明了王岐山是祸害中国的人魔鬼！中国人的走向灾难的罪魁祸首！一切都是刚刚开始！"))
               (u (:- `(cite () "Donald J. Trump @realDonaldTrump : "
                             ,(@ "https://twitter.com/realDonaldTrump/status/1125069835044573186")
                             (small () "2019.5.5 Twitter")
                             (q () (pre () "
For 10 months, China has been paying Tariffs to the USA of 25% on 50 Billion Dollars of High Tech, and 10% on 200 Billion Dollars of other goods. These payments are partially responsible for our great economic results. The 10% will go up to 25% on Friday. 325 Billions Dollars....

...of additional goods sent to us by China remain untaxed, but will be shortly, at a rate of 25%. The Tariffs paid to the USA have had little impact on product cost, mostly borne by China. The Trade Deal with China continues, but too slowly, as they attempt to renegotiate. No!"))))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/192258")
               '(q () (pre () "
5月5号：尊敬的战友的好！你们健身了吗？你们往身上泼水了吗？由于今天是周末！我不想打扰大家周末休息，今天没有直播，一切都是刚刚开始！"))
               (u (:- '(pre () "画 : 米奇 超人")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.4")
        (u (:- "郭文(图片): " (@ "https://www.guo.media/posts/192114")
               '(q () (pre () "
5月4日：天下最不要脸的五四大历史观一今天的钳制思想比汉朝过无数倍……结果会是什么！😼😼😼😼😼😼😾😾😾😾😾😾")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/192103")
               '(q () (pre () "
5月4号：尊敬的战友们好，今天我们有非常非常棒的小夏与文贵谈419的直播，这是我直播以来我认为最好的节目之一，我自己非常满意，这是我做了我必须做而！应该做的事儿，这是致良知．知行合一的！真实表现，但是不能有任何藉口停止自己的锻炼计划，就像追求喜马拉雅的目标一样，不能有任何藉口停下来，不能被任何力量所阻止！这就是我们的战斗理念！一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=UGKW7FCDucM"
                           "5月4日：小夏与文贵谈四一九VOA断播背后的真相")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/191855")
               '(q () (pre () "
5月3号：刚刚看了彭文正黄越宏先生的视频！文贵在前几日直播中的玩笑直言，希望两位先生别介意！一切目的都是衷心地！希望＂政经关不了＂永远都不被关！文贵将和你联系！与您连线直播！只要有利于台湾和台湾人民的事我都愿意干！一切都是刚刚开始！"))
               (u (:- `(cite () "Lego " ,(@ "https://shop.lego.com/en-US/product/Vestas-Wind-Turbine-10268"
                                            "Vestas Wind Turbine")
                             (small () "Lego Shop")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/191843")
               '(q () (pre () "5月3日：与战友分享日本拉面🍜……这是我的最爱之一呀……一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/191800")
               '(q () (pre () "
5月3号：衷心地感谢这位捐了5万元英镑的姐妹！和捐了50万美元的兄弟！以及另外一位捐了10万美元的老大姐！因为你们不让说出你们的名字！也不要法治基金公告！但是文贵万分还是要感激你们对法制基金和灭共的支持！你们的每一分钱都会花在都会花至灭盗国贼上！和拯救被共产党陷害的中国同胞有关的事情上……一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/191794")
               '(q () (pre () "
5月3号：尊敬的战友们好！明天！就是5月4号！星期六的早上9:00！北京时间晩上9点！文贵在郭媒体将与龚小夏博士聊天对谈！谈谈419VOA断播事件的背后，更多的细节！和小夏从没说出的故事！以及和在线网友交流，并回答战友问题，一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/191792")
               '(q () (pre () "5月3日：看看我这是在哪里玩呢……亲爱的战友们！一切都是刚刚开始！"))
               (u (:- '(pre () "沙滩 鲨鱼 野猪"))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/191743")
               '(q () (pre () "
5月3号：请尊敬的战友们猜猜！这几张长老椅上马上会发生什么事儿？正在准备什么事儿？一切都是刚刚开始！"))
               (u (:- '(pre () "教堂"))
                  (:- `(cite () "衣服品牌: Savile Row Bespoke"
                             ,(@ "http://www.savilerowbespoke.com")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/191668")
               '(q () (pre () "
5月3号：尊敬的战友们好，你们健身了吗？你们往身上泼水了吗？

这是我平常健身时为了纠正自己的错误姿势．都要录的视频，由于昨天晚上基本没怎么睡觉，第一组平板称做了28分钟，我每天做两组．大概在50分钟左右！

今天的第一组这个视频中的平板车做得变形了！非常不好，但是我要和战友们分享。因为很多战友做平板撑不标准！变成了弓板撑．对身体是有巨大伤害的，大家可以看到我在中间多次的变成个弓板撑！这是不好的！非常丢人，😔😔😔但是希望在别学我这丢人样！就算是我用我的错误来提醒大家吧！

小时内文贵会报平安直播！今天是个纪念的日子！我一切都是刚刚开始。"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=4SEBoogJp24"
                                    "May 3rd 2019 (1)文贵在做平板称时的视频做得不标准，希望战友们不要秀文贵这样的做共28分钟。")
                             (small () "Youtube: 郭文贵"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.3")
        (u (:- "视频: " '(small () "Youtube: 郭文贵")
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=4SEBoogJp24"
                                  "May 3rd 2019 (1)文贵在做平板称时的视频做得不标准，希望战友们不要秀文贵这样的做共28分钟。")))
                  (:- `(cite () ,(@ "https://www.youtube.com/watch?v=-8P-o86oNF8"
                                    "3rd may 2019 (2)2017年的5月3号和2018年的5月3号都发生了哪些重大事件，文贵与大家分享一些过去没有讲过的事情。")))
                  (:- `(cite () ,(@ "https://www.youtube.com/watch?v=QXddVpZJKSY"
                                    "3rd May 2019 (3) 3rd may 2019 (2)2017年的5月3号和2018年的5月3号都发生了哪些重大事件，文贵与大家分享一些过去没有讲过的事情。"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.2")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=wAfO_HyKGdk"
                           "2019年5月2日：毛泽东，邓小平，妈祖．给我托梦了．人民大会堂委内瑞拉，台湾香港要出大事儿．郭台铭的梦是假的，哈哈哈哈，一切都是刚刚开始。")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/191472")
               '(q () (pre () "
5月2号：刚刚的和网络维护公司开完会，让他们吓了我一大跳！仅仅我们每天新加入的人第一次看我们郭媒体的人就有大概14万人，而我们郭媒体被西方关注的人数比例．从过期的5%已经接近40%！而且我们的网络是排在前几名的增长！而且是非常安全的网络安全维护！这在全世界的网络公司都是罕见的，因为这些数字谁也做不了假，而事实上郭媒体媒体的使用客户．包括非关注者．而常用的战友已经达到1.11亿人……这就是战友的力量！正义的力量C ！C P的作恶成就了我们！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.5.1")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=FU0GR6uW-ro"
                           "2019年5月1日从委内瑞拉革命，我们可以得到如何保护台湾和香港快速灭共的最佳办法，什么是尿脸党！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "...")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.30")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=VF21P1-Yyj0&feature=youtu.be"
                           "郭文贵先生 4月30日 台湾之战决定共产党生死！中国银行第二个海航！ 王建死即将揭开！ ——JUSTICE")
               '(small () "Youtube: 战友之声 Voice of Guo.Media")
               (u (:- '(pre () "...")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.29")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=1xG7TCT94Q0"
                           "2019年4月29日：台湾．香港．将是灭共的重要之地……谷畜生侮骂一亿河南同胞必须受惩罚！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/190994")
               '(q () (pre () "4月29号：香港大游行！人们的这种声嘶力竭地叫喊和恐惧，过去的斯大林，希特勒和阎王爷都没做到的让人如此的恐惧，共产党却做到了……所以共产党比魔鬼还可怕．比独裁还可憎……天不灭C CP那就没有天理了！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.28")
        (u (:- "视频(报平安): "
               (@ "https://www.youtube.com/watch?v=vSLPmy-8CDs&feature=youtu.be"
                  "Guo Media Broadcast (Chinese): Chinese language based Broadcast")
               " 和 "
               (@ "https://www.youtube.com/watch?v=KHEPXouraRc"
                  "Guo Media Broadcast (Chinese): Chinese language based Broadcast")
               '(small () "Youtube: Rolfoundation法治基金")
               (u (:- '(pre () "中央公园 滑冰场 一棵树 川普总统"))
                  (:- '(pre () "支持香港游行"))
                  (:- '(pre () "花粉敏感")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.27")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=L3enbOXZxkU"
                           "4/27/2019 在喜马拉雅大使馆和文贵先生直播，信息量大！千万不要错过！")
               '(small () "Youtube: 路德社")
               (u (:- '(pre () "..."))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=YK9QJ-n1aFw"
                           "4月27日班农和文贵在路德访谈解读”一带一路”，谈”当危会”及Roger Robinson")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/190558")
               '(q () (pre () "
4月27日：尊敬的战友问好！四个小时后．纽约时间今天早上9:00．北京时间27号晚上9:00．在郭媒体与班农先生直播．谈谈刚刚在中国结束的第二届一带一路的会议．和刚刚结束的曼哈顿当前危机委员会的重大意义……今天会有我们的战友参加直播😘😘😘✊✊✊大概在三到四个小时直播时间！一切都是刚刚开始！")))
           (:- "郭文(视频 捐款留言): " (@ "https://www.guo.media/posts/190528")
               '(q () (pre () "
Appreciate all the donors to Rule of Law Foundation and Society!"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.26")
        (u (:- "郭文(报平安 视频): " (@ "https://www.guo.media/posts/190429")
               '(q () (pre () "
4月26号：尊敬的战友正好！你们健身了吗？你能往身上泼水了吗？今天文贵一天都在外面开会！开庭！没有时间发消息，这里向大家报平安了，一切都是刚刚开始！"))
               (u (:- '(pre () "慢工出细活")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.25")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/190278") ".."
               (@ "https://www.guo.media/posts/190215")
               '(q () (pre () "
4月25日：纽约天还没亮！刚刚早上5点！与亚洲的各个方面开了一整晚灭CCP大会！深刻体会到．世界正在向一起靠拢……正在前所未有的形成共识……即CCP正在威胁整个世界的安全！……必须推倒CCP的防火墙．停止投资CCP……我要去睡一会啦……一切都是刚刚开始

4月24日，尊敬的战友们。明天4月25日，纽约时间上午8时正！北京时间晚上8点．郭媒体将在纽约现场直播美国当前危机委员会曼哈顿会议！时长两个半小时！这是讨伐C C P的又一场重要的会议，届时将有更多的鲜为人知的人物参加！此会议将有一系列的重要演讲！郭媒体荣幸的被当前危机委员会要邀请．授权与美国及世界多个媒体一起现场全程直播！一切都是刚刚开始。"))
               (u (:- '(pre () "")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.24")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/190156")
               '(q () (pre () "4月24日：文贵衷心的感谢所有的战友之声的战友们和Sara女士！一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=6NU3FM3YfYQ"
                           "April 24, 2019文贵向战友们报告昨天的三个神秘会议的内容及对张建先生突然病逝的祈祷！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/190073")
               '(q () (pre () "4月24号：尊敬的战友们好！你们健身了吗？你们往身上泼水了吗？9．30左右！文贵直播报平安！谈谈昨天的三个神秘会议！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.23")
        (u (:- "郭文(报平安 短视频): " (@ "https://www.guo.media/posts/189959")
               '(q () (pre () "4月23日：尊敬的战友们好，你们健身了吗？你能往身上泼水了吗？文贵趴在地上向战友们报平安！一切都是刚刚开始！"))
               (u (:- '(pre () "与神人合作  三个空间  别忘了健身  老鼠夹"))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/189804")
               '(q () (pre () "
4月22号：所有的中国同胞们都应该看看这个真实专业与我们每个人都有利益关系的视频，并广泛转发！这个视频的客观和专业值得让我们每个人了都深思！并帮助我们的家人朋友更加了解C C P控制的房地产经济！事实上就是诈骗经济！以黑．假治国的铁证！我们不要再成为他们的诈骗对象和牺牲品，衷心的感谢我们伟大的战友们的制作和翻译，并加上的中英文字幕！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.22")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=rkytjh7aFyI"
                           "2019年4月22日：伊朗的石油制栽意味着共产党推行独栽盗国制度．将受到法治．民主社会制度的全面反击！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(短视频: " (@ "https://www.guo.media/posts/189706")
               '(q () (pre () "
4月22号：尊敬的战友们好，你们健身了吗？你们玩身上泼水了吗？应战友们的要求．半小时后，纽约时间上午10:00北京时间晚上10:00．文贵直播报平安．谈谈对伊朗石油的制裁意味着什么？和盗国贼有什么关系，一切都是刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/189601")
               '(q () (pre () "
4月21日：这叫啥招呢？巜?？？荒唐的中美贸易协议?? 》现在真的需要王歧山这个救火队长出山啦吧……胡舒立这个烂人呢？出来咳嗽几声吧……！原来吴证携夫人．烂杨．4月21日．下午6点22分在纽约32街的韩国餐馆找钥匙🔑他夫妇俩对面这个中国人是谁呢？灭爆小组杀手吗？一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.washingtonpost.com/opinions/2019/04/21/no-more-waivers-united-states-will-try-force-iranian-oil-exports-zero/?utm_term=.0c98d2adc3bd"
                                    "No more waivers: The United States will try to force Iranian oil exports to zero")
                             (small () "2019.4.21 The Washington Post")))
                  (:- '(pre () "短视频: 吴征 杨澜")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.21")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=Nno18amLzwQ"
                           "2019年4月21日：文贵为什么要揭穿．李嘉诚．马云．郭台铭．江志诚！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "李嘉诚 深度参与 灭爆小组"))
                  (:- '(pre () "为什么? 1.对郭先生本人和爆料革命 有巨大威胁  2.与喜马拉雅目标有巨大矛盾  3.假骗盗 葬送香港 台湾 与个人无冤无仇 是它们找上门来"))
                  (:- '(pre () "做菜"))
                  (:- '(pre () "当委会 金融会 神秘会"))
                  (:- '(pre () "祈福"))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/189470")
               '(q () (pre () "
4月21日：这一切的发展都太快了……太有意义了……我们爆料革命已经创造奇迹……也必将实现中华民族伟大复兴《以法治国．信仰自由》……一切都是刚刚开始！今天要早睡觉啦……天亮健身后见战友们🙏🙏🙏😘😘😘"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.20")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/189376")
               '(q () (pre () "
4月20号：欧洲的议会将会有一系列的决定保护西藏和新疆人权！将会推出一系列对CCP的惩罚措施，包括打击盗国贼．在欧洲的洗钱和秘藏的盗取中国人民财富，一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.vot.org/cn/欧洲议会通过议案：尊重西藏人权，关闭新疆再教/"
                                    "欧洲议会通过议案：尊重西藏人权，关闭新疆再教育营")
                             (small () "2019.4.19 西藏之声")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=Uh8Ourx9kRw"
                           "2019年4月20日班农先生与文贵谈郭台铭选台湾总统 : Steve Bannon and Miles Guo, a dialogue on Terry Gou’s presidential bid")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(图片 照片): " (@ "https://www.guo.media/posts/189285")
               '(q () (pre () "
4月19号：尊敬的战友们好，明天上午4月20号纽约时间上午9:00．北京时间下午9:00在郭媒体．班农先生能与文贵直播．谈郭台铭竞选台湾总统和中美贸易协议．香港遣返法．并与战友们就有关这些问题互动！不爆料．没有任何核弹级的信息……只是聊聊个人对这几个问题的个人理解！一切都是刚刚开始！")))
           (:- "郭文(短视频 报平安): " (@ "https://www.guo.media/posts/189227")
               '(q () (pre () "4月19日：文贵报平安视频！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.19")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=Oe22Ocs1qrU"
                           "4月19日：【419】一个难忘的日子……2017年与VOA龚小夏女士．东方先生……在我家的釆访！断播二周年．文贵回顾这两年来爆料的一些人和事……一切都是刚刚开始")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "回顾 2017 419"))
                  (:- '(pre () "绝路 过去的郭文贵已经没了 生死之战的开始 "))
                  (:- '(pre () "断播事件 中美关系"))
                  (:- '(pre () "直播 不能剪辑"))
                  (:- '(pre () "海航 王岐山 陈峰 王健"))
                  (:- '(pre () "吴征 遣返"))
                  (:- '(pre () "爆料革命 影响力 信任"))
                  (:- '(pre () "真善狠"))
                  (:- '(pre () "战友 安全 不忘记 不放弃 不抛弃"))
                  (:- '(pre () "无我 无利"))
                  (:- '(pre () "感谢战友"))
                  (:- '(pre () "祈福")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.18")
        (u (:- "郭文(短视频 喜马拉雅大使馆): " (@ "https://www.guo.media/posts/189083")
               '(q () (pre () "4月18日：正在准备20号上午9点的直播！一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/189053")
               '(q () (pre () "4月19日：一个难忘的日子……")))
           (:- "郭文: " (@ "https://www.guo.media/posts/189051")
               '(q () (pre () "
4月19日：东方先生希望的！在中国一定会很快的发生！（什么时候中国公民可以起诉他们在1949年后被没收的财产？ ）"))
               (u (:- `(cite () "东方 @DongFang_USA : "
                             ,(@ "https://twitter.com/DongFang_USA/status/1118854486087360518")
                             (small () "2019.4.18 Twitter")
                             (q () (pre () "什么时候中国公民可以起诉他们在1949年后被没收的财产？

>> 美国之音中文网 @VOAChinese : ")
                                (cite () ""
                                      ,(@ "https://twitter.com/VOAChinese/status/1118632277200855041")
                                      (small () "2019.4.17 Twitter")
                                      (q () (pre () "
美国国务卿 #蓬佩奥 17号宣布将实施赫姆斯伯顿法案第三条，允许美国公民起诉使用古巴政府1959年后没收的美国公民财产的企业或个人。这个法案1996年通过后一直被搁置；蓬佩奥国务卿说这一新的决定使得那些被没收财产的古巴裔美国人可以寻求他们多年来无法伸张的正义。#Cuba 
https://bit.ly/2GkvJHj "))))))))
           (:- "郭文(图片 照片): " (@ "https://www.guo.media/posts/189033")
               '(q () (pre () "
4月19日：【419】一个难忘的日子……2017年与VOA龚小夏女士．东方先生……在我家的釆访！半小时左右文贵直播回顾一下．不爆料！一切都是刚刚！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.17")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/188886")
               '(q () (pre () "
4月17日：尊敬的战友们好！由于今天紧急开会，没时间发照片，今天不录视频报平安直播，一切都要服务于行动……✊✊✊一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.16")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=-GP1BjH06v0"
                           "2019年4月16日4月16号：尊敬的战友们好，你们健身了吗？你20直播报平安！不爆料就是谈谈，昨天让大家搜集李嘉诚10个人信息的进展！和简单谈谈维基解密解密的信息")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/188754")
               '(q () (pre () "
4月16号：尊敬的战友们好，你们健身了吗？你们往身上泼水了吗，20分钟左右文贵将在郭媒体直播报平安！不爆料就是谈谈，昨天让大家搜集李嘉诚10个人信息的进展！和简单谈谈维基解密解密的信息，一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/188662")
               '(q () (pre () "
4月15日：尊敬的战友好！根据近几天的会议．和英国一些关键人物会议中．了解到的有关华为5G的信息．和华为的真实背景的相关证据！以及美国在对这方面的担忧．以及的国际形势和盗国贼们在背后的操控的证据，

我深信华为5G在英国将不会被接受……而在欧美日．将由美国，瑞典，日本，德国……的共同的研发的5G来代替，这个技术合作集团的技术．是捍卫．世界民主．自由．法治．的技术，而不像是华为公司是．只服务一个流氓，黑社会的盗国集团．的黑技术！这是本质上的不同……我们可以拭目以待！

一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.bbc.com/zhongwen/simp/business-47167608"
                                 "华为与5G：英国科技未来的决定时刻")
                             (small () "2019.2.8 BBC 中文"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.15")
        (u (:- "郭文(短视频): " (@ "https://www.guo.media/posts/188632")
               '(q () (pre () "4月15日：下午三点！显摆一下新＂汉挂子＂新衣服．向战友报告一点刚刚的神秘会议！一切都是刚刚开始！"))
               (u (:- `(cite () "衣服品牌: "
                             ,(@ "https://www.chromehearts.com"
                                 "Chrome Hearts")))
                  (:- '(pre () "中央公园 休闲"))
                  (:- '(pre () "战友之声 英文 影响"))
                  (:- '(pre () "不要被带节奏 跟风"))
                  (:- '(pre () "任何战友 不能代表 爆料革命  要注意  它们正在想尽一切办法 接近 战友骨干 蓝金黄 制造麻烦 "))
                  (:- '(pre () "不要"))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=TZESdz_IsN0" "2019年4月15日4月15日：接下来的爆料有些会是让人无法接受的……人性丑恶行为！＂世上有些人的恶已经超过魔鬼👹＂与共产党一起的任何人任何事情都比妖怪还要让人憎恶……")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(图片 照片): " (@ "https://www.guo.media/posts/188584")
               '(q () (pre () "
4月15日：接下来的爆料有些会是让人无法接受的……人性丑恶行为！＂世上有些人的恶已经超过魔鬼👹＂与共产党一起的任何人任何事情都比妖怪还要让人憎恶……这个马世文是海航控股德意志银行及欧洲N个大项目收购的操盘者……香港已经成为地狱之门……魔鬼交易做恶的中心！一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/188571")
               '(q () (pre () "
4月15日：尊敬的战友们好！半小时左右！也就是纽约4月15日上午10点．北京晚上10点左右．文贵报平安直播！不爆料．只是先与战友们谈谈李嘉诚超人有关的几个人！为下一步一系例的爆料先做个有关预告！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.14")
        (u (:- "郭文(照片): " (@ "https://www.guo.media/posts/188465")
               '(q () (pre () "414：一天都在外面见朋友……开会……法治基金的影响力太超出了我的想象了……一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/188398")
               '(q () (pre () "414：衷心的祝愿李小牧先生成功……一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=P7ZQO8GJlR0"
                           "April 13, 2019第三次直播．王岐山副主席可能要扶正！给战友们的四条建议！紧急通知⚠️战友必看！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=QHQrwq15VbM"
                           "4月13日文贵直播：什么叫蓝通？为什么刘鹤将遣返爆料战友等21人作为中美贸易交易的条件！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=kNAf1hLh0DQ"
                           "4月13日：郭文贵直播谈盗国贼的财富以及这周发生的大事！ 江家集团在中国的实际实力和未来的下场！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文: " (@ "https://www.guo.media/posts/188260")
               '(q () (pre () "
4月13日：韦石．太厉害了👍……什么条件能与共产党有此交易！多少上搏讯网的人被捕入狱？因为这个交易……一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/188259")
               '(q () (pre () "
4月13日：伟大无敌的战友们……什么都能搞清楚弄明白！多少人被这8个颜色冤杀了……一切都是刚刚开始！"))
               (u (:- '(pre () "(郭文图片没有 内容应该是 国际刑警组织 8种颜色的通知说明)"))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/188240")
               '(q () (pre () "
4月13日：这咋我刚懵完……川普总统就来了就……我好像记得．任正非老先生说过＂没有人敢．不用华为的5G＂这美国胆子太大了……我相信会有更多人带着一切做案工具．要求去到马阿拉哥去游泳吧……一切都是刚刚开始！"))
               (u (:- `(cite () "郭文视频: "
                             ,(@ "https://www.youtube.com/watch?v=EcWTCD6YiTY"
                                 "President Trump Delivers Remarks on United States 5G Deployment")
                             (small () "2019.4.12 Youtube: The White House"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.12")
        (u (:- "郭文(照片 图片): " (@ "https://www.guo.media/posts/188054")
               '(q () (pre () "
4月12日： 尊敬的战友们好你们健身了吗？你们往身上泼水了吗？今天由于要和几个重要的欧洲和日本来的朋友开会，来不及拍照片了，请大家放心，明天早上纽约时间上午9:00．北京时间晚上9:00．文贵在郭媒体直播谈谈江泽民家族的盗国财富和最近的一系列国际社会对共产党的惩罚的行动！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片"))))
           (:- "郭文(视频 捐款留言): " (@ "https://www.guo.media/posts/188047")
               '(q () (pre () "
4月11日法治基金分享部分收到的留言，感谢所有留言的与无名的捐助者！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=jXydynsyIJ8"
                                    "4月11日法治基金分享部分收到的留言，感谢所有留言的与无名的捐助者")
                             (small () "Youtube: Rolfoundation法治基金")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/187957")
               '(q () (pre () "
4月11日：我6个月前发布的信息昨天有了结果．这是重大的历史时刻，这是美国保护经济利益的重大，决定是美中关系的重大改变，这只是刚刚开始

【美国《联邦公报》10日发出通告，将37间中国企业及学校列入一个有“未经验证实体”的危险（red flag）名单，当中有7家是香港上市公司，美国政府呼吁美国公司在跟他们做生意时要小心。这个名单在11日生效。 　　

美国商务部负责出口管理的前助理部长沃尔夫Kevin Wolf指出，身为该等机构或学校的美国供应商，将不能再如以往般、在销售用于维修的产品许可证方面获得豁免。这些美国公司将需申请新的许可证。虽然这不是实际上的“禁运”，但因名单对那些企业及机构予以危险的定义，往往会被视为等同禁运。 　　

名单上包括7间设于香港的机构，当中包括Swelatel Technology Limited、Universe Market Limited、升运物流有限公司、远航科技香港有限公司、恒宇仓储物流有限公司、韬博盛科技有限公司及优联国际供应链有限公司。 　　

数间被上榜的中国机构，专门从事精密光学、电子、机床或航空等业务。它们包括北京的中国人民大学、上海的同济大学、广州的广东工业大学以及2间设于西安的学校。
被列入名单的中国企业则包括爱信（南通）汽车技术中心有限公司（它是日本丰田旗下爱信精机于中国设立的海外研发公司）；有研发国防科技的中国科学院长春应用化学"))
               (u (:- '(pre () "..."))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/187952")
               '(q () (pre () "
4月11日：当了30年的总统．最近还与中共合作建立了卫星通信基地．主要是针对美国及欧洲……这不作死吗……一年多来他的家人及他三次邀请我访问苏丹！竞然通过的是法国前亲共总理做中间人……盗国贼啥招都想了！卑鄙之极……这回知道世界上谁是老大了……他一定会是CCP在非洲实施的．BGY项目计划的多米诺骨牌效应的第一张牌……往下看吧…一个又一个的国家都会因CCP而脆断的发生革命……这种情况很快会发生在中国……比苏丹．突尼斯还要快．还要彻底！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文视频: 苏丹")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.11")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=bf_m0yL7xe4"
                           "2019年4月11日4月11号：文贵报平安直播！谈谈美国和欧洲接下来的联合行动！和,必须拒绝一个战友捐款170万美元的问题，再谈谈在伦敦被抓朴的阿桑奇和当前危机委员会！一切都是刚刚开始！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "买房子 捐款 不能收"))
                  (:- '(pre () "法治基金 留言 一周发一到两次 避免发太多 暴露战友信息"))
                  (:- '(pre () "班农先生 当前危机委员会 演讲  之前发推错了 是克鲁兹议员去演讲" )
                      (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=fKuFJ62JXSo"
                                         "Steve Bannon Speaks at 'Committee on the Present Danger: China' Event")
                                    (small () "2019.4.9 Youtube: securefreedom")))
                         (:- `(cite () ,(@ "https://www.youtube.com/watch?v=8WFPh5Igec0"
                                         "战友之声中文字幕：班农先生在“当前危险委员会-中国”活动上发言4/11/2019")
                                  (small () "Youtube: 战友之声 Voice of Guo.Media")))))
                  (:- '(pre () "他们的国 有派人到中共国内 做调查"))
                  (:- '(pre () "中美贸易谈判 就是笑话  植树节演戏"))
                  (:- '(pre () "川普总统 2020大选完 台湾 欧洲 选完"))
                  (:- '(pre () "台湾 香港 美国 大变天"))
                  (:- '(pre () "维基解密阿桑奇被捕"))
                  (:- '(pre () "空中取钱"))
                  (:- '(pre () "祈福"))
                  (:- '(pre () "留住 法治基金 捐款凭据"))))
           (:- "郭文(图片 照片): " (@ "https://www.guo.media/posts/187776")
               '(q () (pre () "
4月10日：这都是＂人家＂的功劳……😹😹😹咱不说．不说……爆料战友们只要一个结果……灭CCP……接下来会有更大的更大的组合拳……事实上我今天就可以剃胡子了……详情等方便时再报告给战友吧！一切都是刚刚开始！"))
               (u (:- `(cite ()
                             "tianxaiyouxue12 @tianxiayouxue12 : "
                             ,(@ "https://twitter.com/tianxiayouxue12/status/1115844723757985794")
                             " 找尋失去的靈魂 @zhaoxunlinghun : "
                             ,(@ "https://twitter.com/zhaoxunlinghun/status/1115840043720040449")
                             " House Foreign Affairs Committee @HouseForeign : "
                             ,(@ "https://twitter.com/HouseForeign/status/1115670711283134473")))
                  (:- '(pre () "红衣男子")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.10")
        (u (:- "郭文(照片 Snow): " (@ "https://www.guo.media/posts/187680")
               '(q () (pre () "
4月10日：不速之客造访．SNOW突然袭击的出现在西马拉雅大使馆……吓，了我一大跳！一切都是刚刚开始！")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/187668")
               '(q () (pre () "
4月10号．尊敬的战友们好：目前来看，所谓的美国名主持与俄罗斯美女造谣文贵的事情．还在进一步的确定详细的信息中，律师建议咱不能直播就有关问题，咱们的等等看，但是我们有其他很多好消息，看来文贵很快要刮胡子了，一切都是刚刚开始。"))
               (u (:- '(pre () "..."))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/187656")
               '(q () (pre () "
4月10日：今天试穿我自己设计的2019秋冬新装．不尿你的郭战装系列．布家迪特制布料的秋冬裤子系列……一切都是刚刚开始！")))
           (:- "郭文(照片 Snow): " (@ "https://www.guo.media/posts/187639")
               '(q () (pre () "
4月10号：Liai king 和这位俄罗斯美女的出现，终于让我看到了潘多拉盒子打开的必备条件之一的出现，没有这些元素潘多拉盒子打开是没有意思的，今天让我看到了潘多拉盒子，必须打开的第一个条件已经诞生，这个LIai king还有这个俄罗斯美女的背后操纵着就是潘多拉盒子当中相关者之一，他们终于开始蹦出来了，上天在领导的我们的爆料革命！一切都是天意，上天的美好安排，虽然我会失去很多钱，但是他会让我们更高质量的完成，我们的爆料革命！实现喜马拉雅的目标。一切都是刚刚开始！")))
           (:- "郭文(短视频 报平安): " (@ "https://www.guo.media/posts/187613")
               '(q () (pre () "
4月10日：尊敬的战友们好！你们健身了吗？你们往身上泼水了吗？刚刚有突发事件？很多战友发给我说larr king 还有俄罗斯美女又开始找我们事了……造我们谣了，还有很多基金打电话取消跟我的合作！咋回事儿让我了解清楚后我们再直播聊聊，一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/187500")
               '(q () (pre () "
4月9日：这个男人可能又是一个CCP派来的杀手……😾😾😾😹😹😹😸😸😸与马阿拉哥俱乐部同样的故事呀！一切都是刚刚开始！"))
               (u (:- '(pre () "红衣男")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.9")
        (u (:- "郭文(视频): " (@ "https://www.guo.media/posts/187483")
               '(q () (pre () "
4月9日，尊敬的战友们好，现在向战友们分享喜马拉雅大使馆内部的法制基金的办公室的一小部分．战友餐厅．以及法制基金的办公区。这是战友们在美国纽约的家，这里是纽约曼哈顿唯一的现代办公防弹建筑．她是由世界建筑大师完成的．外号＂太空船＂这个建筑过去是曼哈顿的传奇．从现在起由我们创造新的辉煌！一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/187469")
               '(q () (pre () "4月9日：应战友们的要求发几张此时此刻工作的照片！一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=q1S5RZNij1k"
                           "4月9号文贵报平安直播！谈谈陈小平先生和何频先生．明镜．和龚小夏女士上次直播时没有说清楚的几个事！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "继续住当前的公寓 新房还在装修"))
                  (:- '(pre () "当前危机委员会 效率"))
                  (:- '(pre () "陈小平"))
                  (:- '(pre () "龚小夏女士"))
                  (:- '(pre () "谁也不欠谁的"))
                  (:- '(pre () "祈福")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.8")
        (u (:- "郭文(视频): " (@ "https://www.guo.media/posts/187323")
               '(q () (pre () "2019年2月6日文贵、班农、凯琳回答战友们对春晚爆料的问题（中英文字幕版）")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/187307")
               '(q () (pre () "4月8日：2008年我赞助的五彩传说中的这些新彊的孩子．现在应该都长大了！但愿他们不要被关在新疆的监狱里！一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/187286")
               '(q () (pre () "
4月8日：这一切假象．乱．疯之举……都是上天赐予我们的礼物🎁他们共产党灭亡前的作死之兆…… {港币危机既不是表面的货币超发，也不是简单的资本外逃；更加确切的说是：红色权贵资本对于中共在大陆统治信心指标，我称其为：“红色恐慌指数”；当今中国政治危机，不但促使大陆的红色资本借道香港出逃，也让过去20年逃离到香港的存量红色权贵资本也疯狂出逃}")))
           (:- "郭文(短视频 报平安): " (@ "https://www.guo.media/posts/187261")
               '(q () (pre () "
4月8日：尊敬的战友们好．昨天晚上工作到今早七点！刚刚睡醒！为了国内及亚洲战友睡觉前能看到消息．先发个信息报平安！一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/187261")
               '(q () (pre () "4月7日：下周二在华盛顿有重大的行动．有快速的联合行动．并有新闻发布会！一切都是刚刚开始！")))
           (:- "郭文(视频 报平安): " (@ "https://www.guo.media/posts/187108")
               '(q () (pre () "
4月7号：尊敬的战友们好！我们的爆料革命已经深度的影响了美欧日的政治决定，现在一系列的对中共的国有企业在欧美的上市的尽职调查和未来的新的监管方法的立法，以及对中共媒体在西方存在的要求，包括立法都具有深远的意义。我们的战友们一定要坚持以真打共的假！以善打共产党的恶！打造华人的真善美的公众形象，坚决反对任何反中．反华的各种言论和行为，真正的实现中国拥有独立的法制系统！实现真实的依法治国，信仰自由！成为世界的和平的重要力量！实现我们真正的喜马拉雅！一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=JnkMMk7OY_E"
                           "2019年4月7日：美．欧．日．等将对中资国营．香港自贸协定．中共及香港官员的一系列的立法制栽．或调查．或列入黑名单．行动．将是中共灭亡的第一步！")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/187077")
               '(q () (pre () "
4月7日：尊敬的战友们好！衷心地感谢战友文琅制作的这个视频。我认为这是昨天直播当中非常重要的信息！几个月来战友之声制作了大量的英文节目，在西方世界广泛流传，像今天这样的短视频是非常有传播力和影响力的！战友之声已经成为了来自各地的战友聚会的平台！是战友相聚的平台，我在此表示万分的感谢。一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.6")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=f698odWJvpY"
                           "4月6日：班农先生与郭文贵先生谈“当委会”、中美贸易协议与法治基金")
               '(small () "Youtube: 郭文贵")
               (u (:- '(pre () "..."))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/186951")
               '(q () (pre () "
4月6日：应战友们的要求．展示一下喜马拉雅大使馆直播间！这是战友们在美国纽约的家的的9分之一！这里将是实现中华民族伟大复兴！实现真正的依法治国．信仰自由！不让我们当猪狗的喜马拉雅目标的大使馆！！！一切都是刚刚开始！"))
               (u (:- `(cite () 
                             ,(@ "https://www.youtube.com/watch?v=QtwQzoKlnxA"
                                "4月6日：郭文贵应战友们的要求．展示一下喜马拉雅大使馆直播间！这是战友们在美国纽约的家的的9分之一！这里将是实现中华民族伟大复兴！实现真正的依法治国．信仰自由！【挺郭小妹】")
                             (small () "Youtube: 战友之声 Voice of Guo.Media")))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/186935")
               '(q () (pre () "4月6日：应该战友要求分享一下……今天凯琳的不专业的照片！一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/186899")
               " " (@ "https://www.guo.media/posts/186893")
               '(q () (pre () "
4月6日：尊敬的战友们好．今天我与班农先生直播时间更改为纽约时间．上午9点．北京时间下午9点．提前半小时！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.5")
        (u (:- "郭文:" (@ "https://www.guo.media/posts/186753")
               '(q () (pre () "
4月5日：这才是真正的中国人！ 不是吃了中南坑人队丸的人！ 这样子的人是最高尚的．也是真正的贵族……我们的好＂三哥＂特别是从35分钟开始看．下面的留言说明了人心所向！ 一切都是刚刚开始！ https://youtu.be/u7XhF34Lwbs")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/186693")
               '(q () (pre () "
4月6日．星期六上午9．30分钟．我会在郭媒称直播．班农先生正在修改他的行程安排．也会加入我们的直播！
主要谈：中美贸易协议
当下委机应对委员会
文贵西行干了什么！及感想
华为问题发展及一带一路在欧洲．及被蓝金黄的宗教信仰．
中国女间谍要去马阿拉歌游泳被抓事件！
法治基金的最近情况．和如何与当危委合作！
战友如有什么问题请留言！我们会友一小时与战友互动！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/186680")
               '(q () (pre () "
4月5日：衷心感谢您．李大师的建议！背后不挂字．怕走背字！！！这是道术之术……江湖风水之流气！佛祖之兄醉佛以背字论佛才会有今天的大乘佛法……承天意者重在心力是否执定．只要心坚意执政……一切可破！一切皆为色．一切皆为空🙏🙏🙏☝️大师的推文字字珠玑……嘻丑哈恶！如神兵天降一般．开民智．震盗贼！！！文贵万分感激您担负的民族责任！一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/186589")
               '(q () (pre () "
44月4日：尊敬的战友们好！我今天一大早就到喜马拉雅大使馆开会．所以暂时没有时间视频．我一切都好！一切都是刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.4")
        (u (:- "郭文(照片): " (@ "https://www.guo.media/posts/186470")
               '(q () (pre () "
4月3日：几天来的忙碌……我更加深刻的感受到了灭共的重要性……更加感受到了我们承受的上天赋与我们神圣的使命！刚刚下飞机就又收到了一个礼物．劳斯莱斯．库尔南的新车！上天不会亏待任何一个有信仰有理想的人．也不会放过一个做恶的人！一切都是刚刚开始！")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/186467")
               '(q () (pre () "
4月3日：万分感谢科罗拉洲的战友们……你们的勇敢与智慧……让文贵感动至极……一切都要看结果……一切都是刚刚开始！"))
               (u (:- '(pre () "科罗拉多 塞斯朋(?) 盗国贼藏了很多钱"))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/186465")
               '(q () (pre () "4月3日：衷心的感谢你们这些了不起的战友！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片内容: \"看到几个战友消失，心痛... ...安全上网刻不容缓...\"")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.3")
        (u (:- "郭文(照片): " (@ "https://www.guo.media/posts/186392")
               '(q () (pre () "
4月3日：这个当地最好的滑雪景点的超5星级酒店竞然有我们裕达的老员工！！！这里有我们很多战友……特别是在金融领域！真是天助我们呢……一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/186386")
               '(q () (pre () "
4月3日：尊敬的战友们好！我已经从加州到了科罗拉多州的阿期彭．这里是盗国贼欺民贼藏钱的重要之地……这里刚刚开始下雪了！一切都是刚刚开始！")))
           (:- "郭文(图片 捐款留言): " (@ "https://www.guo.media/posts/186381")
               '(q () (pre () "
来自“法治基金团队”的信息： 法治基金一直以来都在收到很多捐款者和战友的反映：事实上在中国大陆，绝大多数捐款都是被屏蔽和拦截的！🔥 但是，即使是这样，法治基金还是时时刻刻都在接收来自中国国内和海外的捐款！🙏 这更加让我们感动和感激，更加让我们珍惜每一笔收到的捐款！🙏 更加坚定了法治基金必须实现我们的目标：建立一个法治的、信仰自由的中国！🎯💪🙏🔥🔥🔥")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/186253")
               '(q () (pre () "
4月2日：衷心感谢加洲战友们的热情和帮助！万分感谢潜伏的战友们的重大贡献……中国人民会在实现喜马拉雅目标．干掉CCP时．你们这些潜伏的英雄将成为新中国的甚至是世界的大英雄……文贵在你们认为适当的时候．让世人知道你们的无私奉献……一切都是刚刚开始！")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/186252")
               '(q () (pre () "
4月2日：衷心感谢加洲战友们的热情和帮助！万分感谢潜伏的战友们的重大贡献……中国人民会在实现喜马拉雅目标．干掉CCP时．你们这些潜伏的英雄将成为新中国的甚至是世界的大英雄……文贵在你们认为适当的时候．让世人知道你们的无私奉献……一切都是刚刚开始！"))
               (u (:- '(pre () "收获巨大 加州变化巨大 正在坚定与我们走在一起"))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/186235")
               '(q () (pre () "
尊敬的戰友們好：郭先生法務團隊與大家分享！👨‍⚖️👩‍⚖️
2018年8月24日，郭先生訴夏業良案在佛吉尼亞州開庭，夏業良當時還沒有律師。他由於無理取鬧，在法庭上丟人現眼，當場被法官命令法庭警官，將夏逐出法庭。
葉寧代表夏業良後，法官在法庭令中明確警告叶宁，你最好不要胡說八道，注意你提交的文件和說的話，你要負責任！
這就是海外民運的醜惡嘴臉！這些流氓心中根本沒有法律！這在哪個國家都是不可容忍的！ 🤡

夏業良，你還記得庭上這一幕吧？👇
夏：我感覺郭的律師對我存在很強烈的歧視……
法庭：好吧，我不再聽你講了……你只有滿足被冒犯的條件後，才可以反訴。明白嗎？
夏：我是被歧視的……
法庭：Joe, move him – Joe, move Mr. Xia out leave. （Joe 是法庭警官。）
郭先生律師：謝謝您，法官先生。
夏：律師的職責不只是賺錢。
法庭警官：當你到了審判庭上時，你會有機會。
夏：我感到非常失望。
法庭警官：我相信你很失望，但不是在這裡。
👮🏻‍♂️👮‍♀️ 一切都是刚刚开始！💪💪💪"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.2")
        (u (:- "郭文(视频 捐款留言): " (@ "https://www.guo.media/posts/186184")
               '(q () (pre () "
4月2日:法治基金留言集锦。衷心感谢各位战友们、留言和未留言的捐赠者对法治基金的支持和捐赠！我们一定不辜负各位的期望！一切都是刚刚开始！代法治基金团队发布")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/186177")
               '(q () (pre () "
4日2日：尊敬的战友们好！你们健身了吗！你们往身上泼水了吗！文贵向战友们报告在加洲开会的感受．和睡在帐篷的原因与地点！一切都是刚刚开始！")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/186175")
               '(q () (pre () "
4日2日：尊敬的战友们好！你们健身了吗！你们往身上泼水了吗！文贵向战友们报告在加洲开会的感受．和睡在帐篷的原因与地点！一切都是刚刚开始！"))
               (u (:- '(pre () "花粉严重过敏"))
                  (:- '(pre () "住帐篷 比佛利山 名店街 四季酒店"))
                  (:- '(pre () "加州变化非常的 对川普总统态度转变 好莱坞对中共态度转变"))
                  (:- '(pre () "美国银行 盗国贼洗钱"))
                  (:- '(pre () "盗国贼 没有半点收手的迹象 盗国洗钱更疯狂"))
                  (:- '(pre () "盗国贼正在走向灭亡前的疯狂时刻 不可掉以轻心"))
                  (:- '(pre () "国际大环境对我们越来越有利 我们要坚持"))
                  (:- '(pre () "要行动 光说没有用 "))
                  (:- '(pre () "祈福"))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/186161")
               '(q () (pre () "
4日2日：尊敬的战友们好！很多战友都在问我今天是否有直播！今天因为会议安排太紧凑没有直播！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.4.1")
        (u (:- "郭文(短视频): " (@ "https://www.guo.media/posts/185970")
               '(q () (pre () "
4月1日：尊敬的战友们好！你们健身了吗！你们往身上泼水了吗！一切都是刚刚开始！"))
               (u (:- '(pre () "没钱啦 只能住帐篷 但还要健身"))
                  (:- '(pre () "政治家 拼 智慧 勇气 身体"))
                  (:- '(pre () "飞机上 立血誓 不达目的誓不罢休"))
                  (:- '(pre () "话不能说太早 看结果"))
                  (:- '(pre () "祈福"))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/185854")
               '(q () (pre () "
3月31日：没有人能挡住母亲的力量…… 谢谢您．雪候鸟的母亲！ https://www.pscp.tv/w/b3FwNzF4ZUtXeU5iWGRaRVB8MXluS09PTW15blpLUnwQ9XKnQJJdCQIPn7KhYwmM2DBoVg22KjLGlchi2-Mq")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/185828")
               '(q () (pre () "3月31日：这个年轻的香港帅哥让人偑服！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.31")
        (u (:- "郭文(照片): " (@ "https://www.guo.media/posts/185724")
               '(q () (pre () "
3月31日：尊敬的战友们好！你你们健身了吗！你们往身上泼水了吗！文贵在加州圣巴巴拉向大家报平安！一切都是刚刚开始！")))
           (:- "郭文(短视频 报平安): " (@ "https://www.guo.media/posts/185720")
               '(q () (pre () "
3月31日：尊敬的战友们好！你们健身了吗！你们往身上泼水了吗！文贵在加州圣巴巴拉向大家报平安！一切都是刚刚开始！")))
           (:- "郭文(图片 照片): " (@ "https://www.guo.media/posts/185582")
               '(q () (pre () "
3月30日：看到加州战友们的真情．热情的愿与文贵在加州相聚！文贵是万分感激．感动！由于我要去见几个法治基金．及当危委员会．的合作者！然后还要去3．4个城市！我还要马上就回纽约为喜马拉雅大使馆举行开幕仪式！文贵此次就不拜见加洲战友们了！我会很快回来的！🙏🙏🙏🙏🙏🙏🙏🙏🙏一切都是刚刚开始！")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/185579")
               '(q () (pre () "2019年3月21日班农先生在意大利罗马《信息算法》主题演讲（中英文字幕版）"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=6kWpAk7K5gw"
                                 "2019年3月21日班农先生在意大利罗马《信息算法》主题演讲（中英文字幕版）")
                             (small () "Youtube: 郭文贵")))))
           (:- "郭文(报平安 短视频): " (@ "https://www.guo.media/posts/185525")
               '(q () (pre () "
3月30日：尊敬敬的战友们好！你们健身了吗！你们往身上泼水了吗！文贵在加州向战友们报平安！"))
               (u (:- '(pre () "长4公斤 腹肌"))
                  (:- '(pre () "感激战友的关心"))
                  (:- '(pre () "深思 很多事不能说太早  少说多做 最好只做不说  结果最重要")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.30")
        (u (:- "郭文(图片): " (@ "https://www.guo.media/posts/185349")
               '(q () (pre () "
3月29日：我自己听了三遍．雪候鸟．与老母亲的真情对话视频．可是推特限制点赞转发……盗国贼连这样的真话都害怕……不敢面对．又怎么能让人民过上美好的生活呢？文贵拜谢雪母了🙏🙏🙏一切都是刚刚开始！"))
               (u (:- `(cite () ""
                             ,(@ "https://twitter.com/WlxhtW2PrYXxdQQ/status/1111838808381616133")
                             (small () "2019.3.29 Twitter")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/185313")
               '(q () (pre () "
3月29日：今天直播完后．直接上飞机✈️去加州……蓝天白云间飞着．看着战友们的视频！心情很爽……感恩所有的战友们！🙏🙏🙏🙏🙏🙏一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.29")
        (u (:- "郭文(照片 Snow): " (@ "https://www.guo.media/posts/185205")
               '(q () (pre () "3月29日：应战友的要求发几张snow 的照片！一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/185203")
               '(q () (pre () "3月29日：什么都要看结果！一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=C97jR_GVl4E"
                           "3月29日郭文贵浴火重生超人归来")
               '(small () "Youtube")
               (u (:- '(pre () "21天家中守孝 反思  战友战斗 团结"))
                  (:- '(pre () "川普总统 穆勒调查结束"))
                  (:- '(pre () "中美贸易  王岐山 信任的金融大佬 每周往返北京和纽约  书:库什那的生意  中共的干预  毁灭川普总统和其家族"))
                  (:- '(pre () "美国 的 反应  一系列国家 看清中共本质 一带一路 太空计划 新疆 网络 媒体 "))
                  (:- '(pre () "美国当下危机应对委员会 山里开的会  核心(执行委员会 秘密委员会):经济决策者:钱和情报"))
                  (:- '(pre () "美国政治党内之争 在 司法框架下"))
                  (:- '(pre () "法治基金 在 影响力"))
                  (:- '(pre () "与 当下危机应对委员会 的争论  必须 明确 反共产党 并声明 绝大多数党员是好的"))
                  (:- '(pre () "宪法 公民"))
                  (:- '(pre () "棍子和面包都要有  反对的同时 还要 建立"))
                  (:- '(pre () "许章润"))
                  (:- '(pre () "美国 教育退休养老基金 没有再投资一个中共国项目"))
                  (:- '(pre () "将联合超过70个国家 公开对 中共所有 国营和相关私营企业 进行 经济制裁"))
                  (:- '(pre () "全面调查在美上市中共国公司"))
                  (:- '(pre () "法治基金 巨额捐助者"))
                  (:- `(cite () "班农先生 采访视频 : "
                             ,(@ "https://www.youtube.com/watch?v=LDrTpgHBeq0"
                                 "Steve Bannon: China is a threat to the industrial democracy in the West")
                             (small () "2019.3.29 Youtube: CNBC Television")))
                  (:- '(pre () "凯琳女士 郭战装 道歉"))
                  (:- '(pre () "法治基金 目前70%的钱是郭先生家族基金的捐款  正在协调 再捐助10亿  得有足够的钱 才有实力与 当下危机应对委员会 合作"))
                  (:- '(pre () "过街老鼠"))
                  (:- '(pre () "喜马拉雅大使馆 法治基金 郭媒体  大楼  郭先生捐献全部 家具 艺术品"))
                  (:- '(pre () "中共骗 新疆集中营 pm2.5"))
                  (:- '(pre () "2017郭先生哭的视频"))
                  (:- '(pre () "习访问欧洲 签的备忘录 都是演戏  欧洲会成立经济贸易委员会应对中共"))
                  (:- '(pre () "渎职 腐败  成都毒食品 盐城化工厂 ..."))
                  (:- '(pre () "冷静 不要沾沾自喜 不可低估对手 不要高估自己"))
                  (:- '(pre () "修宪 最大的礼物  对内的影响   对外的扩张 渗透  中共自己作的"))
                  (:- '(pre () "爆料革命"))
                  (:- '(pre () "战场拉向国际 以法灭共 以美灭共 以国人 有良知的党内人"))
                  (:- '(pre () "赶紧骗中共点钱 让它们滚蛋  大家都讨厌它们 但不骗白不骗"))
                  (:- '(pre () "停电一星期 金融系统瘫痪"))
                  (:- '(pre () "委内瑞拉 太拖泥带水"))
                  (:- '(pre () "王岐山 难民威胁论"))
                  (:- '(pre () "中国梦 就是杀人"))
                  (:- '(pre () "海外需要一批年轻的 有追求有信仰 有能力的 民主力量  为他们提供舞台"))
                  (:- '(pre () "爆料 手榴弹  王健之死 盗国贼海外财富 希望西方与中共国任何贸易往来 要以开放网络为前提"))
                  (:- '(pre () "帮助 海外自媒体  更严厉打击 海外欺民贼"))
                  (:- '(pre () "爆料 集体作战  媒体合作"))
                  (:- '(pre () "行动说了算"))
                  (:- '(pre () "正义 公平"))
                  (:- '(pre () "衷心感谢 所有对郭先生母亲表达哀思的战友"))
                  (:- '(pre () "祈福"))
                  (:- '(pre () "不看效果 看结果"))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/185093")
               '(q () (pre () "
3月29日：尊敬的战友们好．今天的直播已经准备好了……盗国贼还在疯狂的DDOS攻击中……无论如何我们都直播到底……今天我们将是第一次在法治基金．郭媒体．新的总部．《喜马拉雅大使馆．THE HIMALAYAN EMBASSY》此独立的新楼．是最先进的现代化防弹办公室……过一段时间我会邀请一些战友到这里相聚．这里也有最先进的厨房．厨师👩‍🍳……一切都是刚刚开始！")))
           (:- "郭文(图片 捐款留言): " (@ "https://www.guo.media/posts/185077")
               '(q () (pre () "
3月29日：分享几位战友为法治基金的留言，期待郭先生归来！一切都是刚刚开始！💪💪💪💪💪💪💪 — 代法治基金转发")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/185058")
               '(q () (pre () "
3月29日：尊敬的战友们好！现在己经是快零晨5点啦！我要去睡一会儿了！我很兴奋的又要和战友们一起战斗．一起聊天！盗国贼们在过去的十几个小时已经黑掉了我们所有的通讯及直播平台！但是他们挡不住我们的直播．他们的恐惧就是我们的胜利！我们的武器！一切都是刚刚开始！")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/184898")
               '(q () (pre () "
2月23日郭先生采访班农先生梵蒂冈连线视频中英字幕版，感谢伟大的义工团队翻译组、字幕组！一切都是刚刚开始！媒体组"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=kD7PuiUJ94g"
                                 "2月23日郭先生采访班农先生梵蒂冈连线视频中英字幕版")
                             (small () "Youtube")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/184872")
               '(q () (pre () "
3月28日：尊敬的战友们好！文贵回来了！我21天来没有下过楼！也没有与任何战友连系！今天我己经从我的团队手里拿回了我的手机！我今天会到公司上班！并准备明天早上9点30分的直播！非常非常感谢大家的支持．和坚持对盗国贼的战斗！我一切都好．我没有理由没有资格不好！因为我们要战斗到底……直到消灭CCP……实现喜马拉雅目标✊✊✊👉👉👉！明天见．亲爱的战友们！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.28")
        (u (:- "郭文(视频): " (@ "https://www.guo.media/posts/184698")
               '(q () (pre () "
3月27日：感谢战友之声明湾战友制作提供！ 【# 战友之声 #抖音版爆料革命 #楚门看世界 #明湾 因为林强跟踪调查过王岐山，王岐山对林强记恨在心，报复林强，将其关押7年之久。林强曾经也是叱咤风云的人物，中共这台绞肉机，不管你有多牛，到最后都会被绞肉机绞的渣的不剩。 体制内的人更需要鼓起勇气反共，不然下一个就是“绞”你自己！】 一切都是刚刚开始！媒体组")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/184697")
               '(q () (pre () "
感谢战友之声的翻译和字幕制作！ 【 2018年10月5日 采访文贵 卡尔巴斯：孟宏伟为什么会在在中国失踪了？ 文贵：孟一定是去监狱被杀的，我去年就说过。王岐山抓他因为： ❶ 孟没有把我遣送回国。 ❷ 孟参与了王岐山在法谋杀海航王健。国际刑警组织和法国当地警察拿走了监控录像，威胁所有人不准讲，他们都听王岐山的。 一切都是刚刚开始！媒体组")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/184677")
               '(q () (pre () "
尊敬的戰友們好：3月29日（週五）上午9:30（美東時間）我們的文貴先生將在郭媒體直播大約兩個小時左右。文貴先生主要是考慮到國內戰友們的休息時間，將會是中國大陸時間3月29日（週五）晚上9:30。文貴先生讓我們轉告大家，本次直播不爆料，就是想與戰友們互動交流，聊聊天。因為他一直按中國的傳統習俗及他的宗教信仰禮數守孝，素食，誦經......107戒律規制的生活方式，他還沒有從悲傷中走出來。 所以他的身體狀況非常虛弱，希望大家不要介意。 一切都是刚刚开始。🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏 （媒体组）"))
               (u (:- '(pre () "郭文图片: 经文 地藏经")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.27")
        (u (:- "郭文(视频): " (@ "https://www.guo.media/posts/184534")
               '(q () (pre () "3月26日：感谢战友之声文琅战友制作提供！ #战友之声 #抖音版爆料革命 #楚门看世界 #文琅制作 回看共产党的历史，在这70年里，残害了中华民族无数的老百姓， 头一次让中华民族成为了全世界最讨厌和最危险的民族， 并与世界为敌 共产党的邪恶体制造就了所有的灾难 我们的目标就是要彻底改变这个体制，推翻共产党 让中国有法治有信仰自由 一切都是刚刚开始！媒体组")))
           (:- "郭文(视频 捐款留言): " (@ "https://www.guo.media/posts/184532")
               '(q () (pre () "3月26日：法治基金团队分享收到的留言（部分），衷心感谢无数法治基金的捐款者和支持者！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=-nd6hODw_J0"
                                    "3月26日：法治基金团队分享收到的留言（部分），衷心感谢无数法治基金的捐款者和支持者！")
                             (small () "Youtube: 郭文贵"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.26")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/184436")
               '(q () (pre () "
3月25日：尊敬的贤二先生好！郭先生所有的手机都在我们这里，我们法务．媒体．安保．小组每天向他汇报一次，所有的信息由郭先生口头指示我们代发。在三七守孝期间，郭先生末与任何战友及朋友联糸或见面，只接受了欧洲．日本．等几个国家的亲戚们打给家里的电话，某几个国家领导人派来的代表们的当面的慰问。郭先生将在28或29号开始使用手机，并直播，请大家等候我们的通知。🙏🙏🙏 一切都是刚刚开始 媒体组"))
               (u (:- `(cite () "鳩文真賢二 @SqQAKez3xOg2meJ : "
                             ,(@ "https://twitter.com/SqQAKez3xOg2meJ/status/1110178817983700994")
                             (small () "2019.3.26 Twitter")))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/184423")
               '(q () (pre () "
3月25日：感谢战友之声楚门战友提供的视频和内容！ #抖音版爆料革命 #战友之声 #楚门看世界 我们经常听说散户投资股票会被割韭菜，大股东也一样会被割，只要这个体制不改变，任何一个人都会成为下一波韭菜！北大方正集团的李友，胡舒立就是靠骗骗骗！骗一个又一个投资人进去，然后这些钱全部占为己有！强盗呀！强盗！就是这一小撮人把中国搞得乌烟瘴气！ 一切都是刚刚开始！媒体组")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/184418")
               '(q () (pre () "3月25日：感谢战友之声郭啸天战友！ #啸天点评 感谢战友郭啸天激情制作！ 再也无人可以阻挡以美灭共✊！ 一切都是刚刚开始！媒体组"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.25")
        (u (:- "郭文(视频): " (@ "https://www.guo.media/posts/184260")
               '(q () (pre () "
3月24日：感谢战友之声抖音组文多战友制作！ #抖音版爆料革命 #战友之声 #楚门看世界 #文多 张健，说真的，你彻底颠覆了我对人的看法，你太贱了！你尽然恬不知耻的那你们那种要饭的行当跟公益法治基金相提并论。张贱贱。出卖自己的灵魂和原则并不丢人，丢人的是没能卖一个好价钱。 一切都是刚刚开始！媒体组")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/184244")
               '(q () (pre () "
3月24日：尊敬的战友们好；这个委员会的成立是中美关系40年来的第三件大事，一是两国建交，二是签WTO中国入世，三是这个委员会的成立。 你们会看到法治基金在与这个委员会的深度合作！💪💪💪这是CCp灭亡的真正的开始！ 这是灭共革命在国际战场中最大的胜利 再也无人可以阻挡以美灭共！一切都是刚刚开始 媒体组

【美当前危险委员会成立】针对中共对自由世界日益增大的威胁，美国一批中国专家、国家安全从业人士、商界领袖、人权和宗教自由活动家等拟下周一启动第四届当前危险委员会Committee on the Present Danger: China (CPDC)；前三届委员会分别针对苏共和恐怖主义，本届集中消除中共对美的最严峻威胁。"))
               (u (:- `(cite () "CPDC(Committee on the Present Danger: China) "
                             ,(@ "https://presentdangerchina.org")
                             " "
                             ,(@ "https://www.youtube.com/watch?v=Bedfr_uM_yc"
                                 "Brian Kennedy -- The Committee on the Present Danger: China")))
                  (:- `(cite () "CPD(Committee on the Present Danger) "
                             ,(@ "https://en.wikipedia.org/wiki/Committee_on_the_Present_Danger"
                                 "Wiki")
                             " "
                             ,(@ "https://web.archive.org/web/20160220161351/http://committeeonthepresentdanger.org/index.php?option=com_cpdfront&Itemid=90"
                                 "archive.org"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.24")
        (u (:- "郭文(视频): " (@ "https://www.guo.media/posts/184150")
               '(q () (pre () "
3月23日：感谢战友之声抖音组文多战友！ #抖音版爆料革命 #战友之声 #楚门看世界 #文多 1120之前，班农提出了成立法治基金，班农的两个想法打动了文贵，第一他说必须去调查类似于王健被杀的所有案件，第二他说要把中国的精英有一个救济的地方，而且班农已经找到相关国家愿意合作，对所有的中国寻求政治庇护的甚至给护照。 一切都是刚刚开始！媒体组")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/184147")
               '(q () (pre () "
3月23日：为什么我们要支持 #法治基金# 鼓掌战友文扬夜以继日制作的精彩短片🙏🙏🙏 站起来中国人！ 我们已经看清CCP的丑恶真相！ 跟好 #法治基金# 为了孩子！ 我们必须赢✊✊✊ 一切都是刚刚开始！媒体组"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=G1bM8IC6438"
                                    "战友之声2019年3月23为什么我们要支持法治基金，鼓掌战友文扬精心制作")
                             (small () "Youtube: 战友之声 Voice of Guo.Media")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/184143")
               '(q () (pre () "
3月23日：万分感谢细思小哥的这些天与伟大的战友们合作的一糸列的精彩直播。 【班农与文贵的合作，是神的旨意，是上天的安排，这绝不是偶然的现象。文贵原来并不认识班农，而班农在北京见了王岐山后，很多媒体都在鼓吹之际，直接飞去纽约，坚定的与文贵站在一起，开始了反共大业的合作，给艰难中的文贵送去了最大的支持，也使东西方的反共力量凝聚在一起。意义重大，影响深远。】一切都是刚刚开始！ 媒体组"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=iY6mm7V9xiQ"
                                 "3月23日：万分感谢细思小哥的精彩直播！一切都是刚刚开始！媒体组")
                             (small () "Youtube: 郭文贵"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.23")
        (u (:- "郭文(视频): " (@ "https://www.guo.media/posts/184012")
               '(q () (pre () "
2019年3月21日班农先生在意大利罗马进行了《信息算法》主题演讲。演讲讨论了全球化背景下的社交网络、媒体、文化等方面的全球信息战。演讲视频如下（字幕版将后续上传）。一切都是刚刚开始。媒体组。 21 March 2019 Rome, Italy Stephen K Bannon lecture on information warfare in social, media, and cultural context."))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=qXQNc_WJGXQ"
                                 "Guo Media Broadcast (Chinese): Chinese language based Broadcast")
                             (small () "Youtube: Rolfoundation法治基金")))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/183968")
               '(q () (pre () "
3月22日：万分感谢全民挺郭联盟制作的视频！ 盐城化工厂爆炸与中央电视台的欺骗民众，是造成死伤者巨大的根本原因，以假黑治国的共产党是元凶！谁来主持公道？谁能帮助这些可怜的百姓？这样的政府再不被推翻，天理难容！ （上一条视频没有声音，抱歉。在此重发一遍。） 一切都是刚刚开始！ 媒体组。 完整视频地址https://www.youtube.com/watch?v=vop4prs3GuA&feature=youtu.be")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/183966")
               '(q () (pre () "
3月22日：必须要让全世界人民了解CCP的蓝金黄计划和手段及危险性。 我们14亿中国人的未来的法治基金主席凯尔巴斯先生干的太漂亮了，他将有更大的行动！【The ccp runs what they call BGY campaigns. Blue-Internet snooping/hacking, Green-monetary influence, yellow-sex entrapment and blackmail. Cindy’s company name is GY US Investments.They actually didn’t even to attempt to cover up what they were doing #china】媒体组 一切都是刚刚开始"))
               (u (:- `(cite () "Kyle Bass @Jkylebass : "
                             ,(@ "https://twitter.com/Jkylebass/status/1109079151389130752")
                             (small () "2019.3.22 Twitter")))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/183961")
               '(q () (pre () "
3月22日：感谢《战友之声》及战友文琅提供的视频和内容！ 【#战友之声 #抖音版爆料革命 #楚门看世界 #文琅 杨洁篪你跟吴征怎么去骗美国人的？怎么去贿赂司法部的？何频多少次见过吴征？为什么何频到最后把文贵给卖了？何频先森这个老鸨子真本色出演呀！】 一切都是刚刚开始！（媒体组）")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/183957")
               '(q () (pre () "
3月22日：感谢《战友之声》及战友文琅提供的视频和内容！ 【#战友之声 #抖音版爆料革命 #楚门看世界 #文琅 何频老贼，早就认识吴征，何频是如何介绍吴征和陈军认识的？何频老奸巨猾，一边拿着中共给的钱，一边还在要文贵的钱，脚踏两只船。就算是中共，都没有这么不要脸！】 一切都是刚刚开始！ （媒体组）"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.22")
        (u (:- "郭文(视频 捐款留言): " (@ "https://www.guo.media/posts/183863")
               '(q () (pre () "
尊敬的战友好：大家为法治基金的留言郭先生都收到了！敌人的恐惧就是我们最大的武器！💪一切都是刚刚开始！🔥—— 王雁平🙆🏻‍♀️ 代 法治基金团队发布")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/183842")
               '(q () (pre () "
3月21日：感谢《战友之声》及战友明湾提供的视频和内容！ 【#抖音版爆料革命 #战友之声 #楚门看世界 #明湾 马云，你可得劲儿吹吧！当你跟川普承诺给100万个就业机会的时候，你在川普身边的人心目中就已经是个骗子了！看看数据，你就知道马云为什么是骗子！ 1、沃尔玛 230万名员工：沃尔玛全球拥有11695家门店 2、麦当劳 150万名员工：麦当劳拥有约36900家门店】 💪以上来自媒体组：一切都是刚刚开始！💪")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/183841")
               '(q () (pre () "
3月21日：感谢《战友之声》及战友明湾提供的视频和内容！ 【#抖音版爆料革命 #战友之声 #楚门看世界 #明湾 我们再来回顾一下何频先森！ 一个操着fú南口音滴，一天到晚luò呵呵滴！看起来很面善滴！ 实际上是个披着羊皮的狼！ 大家还记得那个走路🚶‍♀像蚯蚓的爬行生物陈军吗？ 不光走路一扭一扭！思想还一扭一扭！打着民运的旗号当着共产党的狗腿儿！似不似很刺激？】 💪以上来自媒体组，一切都是刚刚开始！💪")))
           (:- "郭文(照片 Snow 卫星电话): " (@ "https://www.guo.media/posts/183836")
               '(q () (pre () "
3月21日：我们安全组刚刚处理了郭先生私人办公室里的两个卫星通信系统被骇的问题。 基本上可以确定骇客地址来自于上海，郭先生所有的手机都是我们在管理，每天到他家当面汇报一次，盗国贼还是要想尽办法去打拢他，伤害他。 媒体组 一切都是刚刚开始"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.21")
        (u (:- "郭文(视频): " (@ "https://www.guo.media/posts/183799") " .. " (@ "https://www.guo.media/posts/183648")
               '(q () (pre () "
2019文贵看春晚11 法治基金的启动是灭共的倒计时，用法治基金依法灭共！文贵，班农，凯琳为中国人民祈祷祝福！
2019文贵看春晚10 人民群众是不是我们的敌人呢？现在这个国家就是被几个大流氓给绑架了。
2019文贵看春晚9 在中国消失的五百人上千万亿的财产都哪去了，班农说王岐山就是个魔鬼。
2019文贵看春晚8 ＂加中英文字幕版＂ 郭文贵：只有灭掉共产党中国才会有自由，公平，法治，14亿人民不应该成为几个人的奴隶
2019文贵看春晚7 ＂加中英文字幕版＂ 凯琳，班农展望未来，央视春晚是对14亿百姓的洗脑犯罪，共产党是制造仇恨的源泉
2019文贵看春晚6 ＂加中英文字幕版＂ 金正恩被共产党当作筹码，JHO LOW在马来西亚拥有大量资产和势力，背后有孟建柱亲爹的支持
2019文贵看春晚5 ＂加中英文字幕版＂香港台湾被威胁被蓝金黄
2019文贵看春晚4 孟建柱要干掉达赖喇嘛，共产党信奉马列邪教抢夺百姓财产及的宗教信仰人权的自由
2019文贵看春晚3 采访达赖喇嘛
2019文贵看春晚2 香港已经被沦陷
2019文贵看春晚1 杨澜找钥匙，凯琳谈人生观，班农先生在推广平民主义运动"))
               (u (:- `(cite () "视频在郭先生Youtube频道 : " ,(@ "https://www.youtube.com/channel/UCO3pO3ykAUybrjv3RBbXEHw/featured?disable_polymer=1" )))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/183693")
               '(q () (pre () "
3月20日：万分感谢战友之声，和战友文琅 【#战友之声 #抖音版爆料革命 #楚门看世界 #文琅 现在再回过头去看王岐山当副主席，大家说是好事儿还是坏事儿？现在老王坐在那椅子上就如同坐在火上烤！下又下不来，上又上不去，想上去就要干掉习近平，想下来，就一定会被人整！咋整捏？看看老王有没有那个胆量在中南坑发起政变！】 媒体组")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/183687") " "
               (@ "https://www.guo.media/posts/183639")
               '(q () (pre () "
3月20日：尊敬的战友们好，纽约时间明天3月21日，纽约时间中午12点整，北京时间晚上零点，罗马下午时间，班农先生本人在郭媒体直播。 全程使用英语没有即时翻译，我们暂不了解直播内容。请战友们关注！一切，都是刚刚开始。媒体组

March 21, 5PM CET: Broadcast with Steve Bannon from Rome “The Algorithms of Information” 3月21日，下午5时：看班农先生在罗马直播“信息算法”")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/183635")
               '(q () (pre () "
3月20日： 【戰友們，來看看啥叫爆料革命傳播的藝術🤣🤣🤣 聽完之後是不是覺得這位戰友的智慧，你不得不服啊😄👍】 媒体组"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=5IZU9ipmbTc"
                                    "3月20日：【戰友們，來看看啥叫爆料革命傳播的藝術🤣🤣🤣 聽完之後是不是覺得這位戰友的智慧，你不得不服啊😄👍】媒体组")
                             (small () "Youtube")))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/183624")
               '(q () (pre () "
3月20日：郭先生每天见面的人数，他的工作效率和行动力，是我们所有媒体组的成员从来没有见过的。 他的朋友中有很多都是像STEVE BANNON 班先生这样世界上最有影响力，最年轻，最有魅力，最有理想的人……！ 我们媒体工作人员在经郭先生允许的情况下，会接受路徳访谈或战友之声的釆访谈一下这方面的感受。 【Who is Steve Bannon? Filmmakers of Upcoming Bannon Documentary Discuss youtu.be/lPW7w6QFOMQ via @YouTube 全球公映的班农影片有七哥，”the whistle blower” and rule of law foundation!!! 31” 女导演特别强调事实。拍摄期间，班农每次去纽约必去七哥住所。出行经常乘坐七哥的私人飞机。】 媒体组"))
               (u (:- `(cite ()
                             ,(@ "https://www.rfa.org/cantonese/news/hna-03192019082813.html"
                                 "海航集团债务危机升级　持股被冻结员工遭欠薪")
                             (small () "2019.3.19 自由亚洲电台粤语部")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/183612")
               '(q () (pre () "
3月20日：万分感谢您，面具先生。 【面具先生精心制作，几夜未眠分析郭先生爆料绝对用了全心💞💞💞 回顾郭文贵爆料 探秘南普陀与刘承杰他爹和郭文贵爆料之间的关系 片尾有彩蛋🥰感谢所有战友的支持🙏🙏🙏我们一定会赢 我们一定要赢 我们必须赢✊✊✊为... youtu.be/o6nJ9cTiMVA via @YouTube】 媒体组")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/183599")
               '(q () (pre () "
3月20日：感谢《战友之声》及战友文郎。 【#战友之声 #抖音版爆料革命 #楚门看世界 #文琅 吴小晖被抓，绝对的是刚刚开始，吴小晖太天真，太把邓家当回事儿，他很会用中国的政治，但是他不懂中国政治的本质。本质就是下一代人报上一代人的仇！邓小平得罪了那么多人，王岐山，江泽民都在摩拳擦掌要干掉邓家人！】 媒体组"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.20")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/183485")
               '(q () (pre () "
3月19日：纽约时报记者，傅才德先生的文章总是很夸张，我们团队与他打过交道后发现这个人很不诚实。 此人与财新杂志胡舒立，及中共，所谓海外华人社团，的关系，及政治立场，非常复杂。 他喜欢危言耸听，一心想搞大新闻。 郭先生在去年在马阿拉哥，再次被至今为止都不知道是谁的神秘力量保护。 成功的躲过了王岐山，孟建柱，孙力军，在哪里布下的陷阱。 相关细节适当时机，我们会公布与众，那时大家会明白辛迪．杨，到底是谁！ 这篇文章将是个大笑话。 一切都是刚刚开始。 媒体组"))
               (u (:- `(cite ()
                             ,(@ "https://cn.nytimes.com/usa/20190318/cindy-yang-trump-donations/"
                                 "起底辛蒂·杨：与特朗普合影的华裔女商人")
                             (small () "2019.3.18 纽约时报中文网")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/183446")
               '(q () (pre () "
3月19日：万分感谢《全民挺郭联盟》这个釆访班农先生的视频一 班农接受专访片段，谈对英国现任和未来领导人的看法。班农非常有风度，双眼炯炯有神，潇洒的发型，极快的语速，女记者敏捷地提问，班农对答如流。特别是提到博里斯爆减体重，令他跃跃欲试。 中英文字幕。 媒体组y"))
               (u (:- `(cite  () ,(@ "https://www.youtube.com/watch?v=tBePwwDqp78"
                                     "班农接受专访片段，谈对英国现任和未来领导人的看法。班农非常有风度，双眼炯炯有神，潇洒的发型，极快的语速，女记者敏捷地提问，班农对答如流。特别是提到博里斯爆减体重，令他跃跃欲试。 中英文字幕。")
                              (small () "2019.3.19 Youtube: 全民挺郭联盟")))
                  (:- `(cite  () ,(@ "https://www.youtube.com/watch?v=wIo3hGY0pbA"
                                     "Exclusive - Steve Bannon: Mexican border is 'ticking time bomb'")
                              (small () "2019.3.18 Youtube: Sky News")))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/183442")
               '(q () (pre () "
3月19日：尊敬的战友们好！ 【不敢让民众知道他们曾经说过的话，因为骗子都怕自己被揭穿： 周恩来1944年在延安的演讲：我们认为欲实行宪政，必须先实行宪改的先决条件。我认为最重要的先决条件有三个：一是保障人民民主自由；二是开放党禁；三是实行地方自治。目前全国人民最迫切需要的自由，是集会结社的自由，是言论出版的自由。】媒体组"))
               (u (:- `(cite () "东方 @DongFang_USA : "
                             ,(@ "https://twitter.com/DongFang_USA/status/1107957160649076736")
                             (small () "2019.3.19 Twitter"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.19")
        (u (:- "郭文(视频): " (@ "https://www.guo.media/posts/183335")
               '(q () (pre () "
3月18日：🙏🙏🙏【藏传佛教精神领袖达赖喇嘛3月18日在达兰萨拉他的办公室接受了路透社的专访： 他说：将来可能会有两个达赖喇嘛，一个来自这里，一个自由的国家；一个是中国人挑选的，那么就没有人会相信，也没有人会尊重（那个由中国挑选的） 他警告说:任何由中国指定的继任者都不会受到尊重。】（媒体组）"))
               (u (:- `(cite ()
                             ,(@ "https://www.reuters.com/article/us-china-tibet-dalai-lama-exclusive-idUSKCN1QZ1NS"
                                 "Exclusive: Dalai Lama contemplates Chinese gambit after his death")
                             (small () "2019.3.18 Reuters")))))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/183332")
               '(q () (pre () "
3月18日：衷心感谢🙏🙏🙏 【#抖音版爆料革命 #楚门看世界 #明湾 大家可以发现一个规律，只要胡舒立这个吃人饭不拉人屎，说人话不办人事儿的垃圾出来，那么必定是王岐山要害人了。 胡舒立三板斧 1.这当官儿的女人多，上千个 2.钱多得去了，钱可淹死人 3.侵占罪，神秘资金 她出来咬人说明王岐山要杀人了 为啥你胡舒立不去爆海航呀？】（媒体组）")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/183331")
               '(q () (pre () "
3月18日：😭😭😭【第一个反抗恶魔的伟大英雄】黃立众，安徽人，56年考入北大。因在学校散布农村饿死人的谣言，被开除。回家后，看到众多乡亲被饿死，愤而组织中国劳动党，不到3个月发展119人，准备武裝暴動，61年被捕后被枪決。生前曾写詩：饿死千千萬，家家无鼠粮，感时天落泪，悲來风癲狂，大道埋枪炮，羊肠伏虎狼。（媒体组）")))
           (:- "郭文(视频): " (@ "https://www.guo.media/posts/183292")
               '(q () (pre () "3月18号：尊敬的战友们好！万分感谢《好奇的蚂蚁》战友，翻译的班农先生在日本的演讲。一切都是刚刚开始。（媒体组）"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=CUwwkiIfIPI"
                                 "3月18号：尊敬的战友们好！万分感谢《好奇的蚂蚁》战友，翻译的班农先生在日本的演讲。一切都是刚刚开始。（媒体组）")
                             (small () "Youtube"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.18")
        (u (:- "郭文(短视频): " (@ "https://www.guo.media/posts/183155")
               '(q () (pre () "3月17日：【海航的基金的钱那来的】媒体工作组，感谢明湾战友的制作，一切都是刚刚开始。"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=LVNtNUk7gtk"
                                 "3月17日：【海航的基金的钱那来的】媒体工作组，感谢明湾战友的制作，一切都是刚刚开始。")
                             (small () "Youtube")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/183155")
               '(q () (pre () "3月17日：【为什么不抓不查海航】媒体工作组，感谢明湾战友的制作。一切都是刚刚开始。"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=MNWajWRR80w"
                                 "3月17日：【为什么不抓不查海航】媒体工作组，感谢明湾战友的制作。一切都是刚刚开始。")
                             (small () "Youtube")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/183154")
               '(q () (pre () "媒体工作组，感谢明湾战友的制作。一切都是刚刚开始。"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=gaoLfafnguw"
                                 "3月17日：【盗国贼的私生子】媒体工作组，感谢明湾战友的制作。一切都是刚刚开始。")
                             (small () "Youtube")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/183142")
               '(q () (pre () "
3月17号：我们的媒体组，将最近有关我们国家发生的学校毒食堂事件的所有信息，整理后给了郭先生。郭先生希望战友们能够广泛地在媒体上传播和揭露，这个腐败体制导致的整个社会的道德败坏的本质和真相！ 一切都是刚刚开始。")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/183139")
               '(q () (pre () "
3月17号：尊敬的战友好，文贵先生拜请所有的战友们积极在社交媒体上继续揭露海航盗国及王建之死的真相。我向他转达了战友们对他的问候及关心，他说我们都是承担拯救14亿人民的使命与责任的，我们应该全力以赴的去争取最快的时间实现我们的＂喜马拉雅的目标＂只有实现了法治中国，我们才不再活在恐惧中，我们才有资格拥有幸福的家庭，所以我们会战胜一切艰难险阻。一切都是刚刚开始。（王雁萍）"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.17")
        (u (:- "郭文(图片): " (@ "https://www.guo.media/posts/183019")
               '(q () (pre () "
3月16号：尊敬的战友们好，郭先生让我代他转达感谢战友们对他的关心与问候，他一切都好！他拜托战友们要更加积极主动的与盗国贼，欺民贼的战斗，祝战友们周末愉快。一切都是刚刚开始！（王雁萍）")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/183017")
               '(q () (pre () "3月16日：尊敬的战友们周末愉快，一切都是刚刚开始。"))
               (u (:- '(pre () "郭文视频内容: 猴子与狗")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.16")
        (u (:- "郭文(图片): " (@ "https://www.guo.media/posts/182925")
               '(q () (pre () "尊敬的战友们好！这是唐柏桥和耿静诉郭先生的诽谤案被法官最终驳回判决的原件和中文翻译版。一切都是刚刚开始。")))
           (:- "郭文(视频 捐款留言): " (@ "https://www.guo.media/posts/182907")
               '(q () (pre () "3月15日法治基金团队委托郭媒体转达的留言视频！法治基金感谢所有留言和未留言的无数捐赠者！🙏"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=SaBd_tyWo0k"
                                 "3月15日法治基金团队委托郭媒体转达的留言视频！法治基金感谢所有留言和未留言的无数捐赠者！🙏")
                             (small () "Youtube"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.15")
        (u (:- "郭文(图片): " (@ "https://www.guo.media/posts/182737")
               '(q () (pre () "
尊敬的战友们好！今天的第二个捷报！🔥🔥🔥 “一生倒霉夏业良，谁沾谁败叶宁，两个狼狈为奸的失败者被法律严惩的结果！” 郭先生起诉夏业良后，夏在自己没有律师的情况下，先后两次被法官将他自己写的应诉状发回，要求他重写。近日法庭资料显示，叶宁出任了夏业良的代理律师，🚨但叶宁在佛吉尼亚州是没有律师执业资格的 —— 夏业良还得再花钱在佛州聘请代理和上庭律师！🚨 今天佛州法院发出法庭令，要求被告夏业良在10天之内，必须回复郭先生一方的庭外调查取证要求；同时，法庭警告被告夏业良，如违反此令，将会受到包括缺席判决在内的制裁！郭先生一方必须向法院提交庭外调查取证动议的律师费情况，法院会评审并判处被告夏业良支付！ 夏业良因对郭先生进行造谣、威胁、恐吓和流氓式辱骂而被起诉，现在又被流氓律师叶宁在背后操纵、吹捧。这就是美国法律的伟大！美国法律会让骗子、流氓、披着任何外衣的畜生，显出他狰狞的面目，并得到法律公正的严惩！这就叫法治！🔥🔥🔥 一切都是刚刚开始！！！ 王雁平 代郭先生法务团队发布")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/182731")
               '(q () (pre () "
尊敬的战友们好！今天捷报频传！👏👏👏🎯🎯🎯 “多行不义必自毙 —— 唐柏桥、耿静案” 2017年唐柏桥和耿静状告郭先生的诽谤诉讼，今天纽约南区主审法官 John F. Keenan 正式公布了判决结果：联邦法院彻底驳回唐柏桥与耿静的诉讼，并明确要求唐耿二人不能通过修改诉状再次提起诉讼 —— <大家注意，🚨通常情况下，法官是不会作出这种明确要求的！🚨> 主审法官通过这一要求，明确表达了法院的立场：警告唐柏桥和耿静，不要再无理缠诉郭先生，浪费美国的司法资源！🔥🔥🔥 这再次体现了美国法律的公正、公平和严谨！这也恰恰说明了美国法官和法律采取的适用标准，法官和法院是知道这些人是干什么的！也知道这些人之前一直是干什么的，他们现在想干什么！ 正义一定会昭显，这就是法治基金的重要性！2019年，所有CCP走狗和欺民贼在美国的作恶，他们过去几十年一直以来对中国人民的欺骗，美国的法律都会给出公平的审判和结果！ 一切都是刚刚开始！！！ 王雁平 代郭先生法务团队发布🙆🏻‍♀️")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/182681")
               '(q () (pre () "
所有过去和CCP合作伤害郭文贵先生，非法在美国操作所谓对郭文贵先生的遣返，以及被“蓝金黄”与CCP合作的任何一个人，都将接受美国法律公平、严厉的惩罚！今年将是对盗国贼、欺民贼、CCP走狗们一步一步走向法律公平审判的重要的一年！一切都是刚刚开始！💪💪💪💪💪💪💪 —— 郭先生法务团队"))
               (u (:- `(cite ()
                             ,(@ "https://cn.wsj.com/articles/美司法部调查特朗普竞选委员会受赠款项是否涉及刘特佐资金-11552520710"
                                 "美司法部调查特朗普竞选委员会受赠款项是否涉及刘特佐资金")
                             (small () "2019.3.14 华尔街日报")))))
         (:- "郭文(视频 捐款留言): " (@ "https://www.guo.media/posts/182680")
             '(q () (pre () "
3月14日法治基金团队委托郭媒体转达的留言视频！法治基金感谢所有留言和未留言的无数捐赠者！🙏"))
             (u (:- `(cite ()
                           ,(@ ""
                               "3月14日法治基金团队委托郭媒体转达的留言视频！法治基金感谢所有留言和未留言的无数捐赠者！🙏")
                           (small () "Youtube"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.14")
        (u (:- "视频(捐款留言): " (@ "https://www.youtube.com/watch?v=gW9Fn5KZ4Io"
                           "在此衷心的感谢留言的战友们 以及所有匿名的捐赠者们对法治基金的支持 2019年3月13日")
               '(small () "Youtube")))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.13")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/182438")
               '(q () (pre () "
感谢亲爱的可爱的义工团队翻译组战友们！你们太棒了！精装版今天已经快递给卢比奥议员！一切都是刚刚开始！💪💪💪💪💪💪💪—— 王雁平"))
               (u (:- `(cite () "PDF:"
                             ,(@ "https://www.rubio.senate.gov/public/_cache/files/0acec42a-d4a8-43bd-8608-a3482371f494/262B39A37119D9DCFE023B907F54BF03.02.12.19-final-sbc-project-mic-2025-report.pdf"
                                 "Made in China 2025 and the Future of American Industry.")))
                  (:- `(cite () "战友之声 中文翻译 PDF下载: "
                             ,(@ "https://cdn.discordapp.com/attachments/455062882992914434/547697154332950528/2025.pdf"
                                 "中国制造2025 与 美国产业未来")))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/182428")
               '(q () (pre () "
尊敬的战友们好： 3月8日（上周五），PAX（全名Pacific Alliance Asia Opportunity Fund L.P.）第三次试图在Sherry公寓上设立attachment的动议，被法官当庭再次驳回！同时法官提出最后一次面见有关Sherry公寓的证人，因为PAX在失败了的三次尝试中，提供的证据理由被证明是彻底站不住脚的！—— 而且在过去几个月内，PAX已经连续失败了两次！ 往回看所谓的PAX案件和这些人，在背后和海航控制如出一辙 —— 威吓、恐吓、造谣！但是太多的造谣已经被人忘记，同时这些人还在天天说追求正义、要求真相，这种卑鄙可耻的流氓行径一定会受到法律的制裁和惩罚！ 以上信息来自郭先生法律团队")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/182422")
               '(q () (pre () "
尊敬的战友们好： 这是郭先生在纽约再次起诉郭宝胜、叶宁、赵岩后，郭先生的律师成功送达郭宝胜的送达凭证。 近期郭宝胜还找了警察报案，说郭先生公布了他的护照信息，警察昨天联系了郭先生的律师，问清楚了情况，了解到是郭宝胜自己把自己的护照信息提交到法院的，民事案件的法律文件在被提交后，是对公众开放的，任何人都能查到！警察和郭先生的律师说，郭宝胜就是在浪费警察的时间！这在美国就是蓄意骚扰警察！ 所有的问题往回看，他们每次公告全都是假的，每次新闻也全都是假的。 对郭宝胜等这些造谣诽谤分子，我们绝不放过任何一个，一定会让他们受到美国最严厉的惩罚！ 以上信息来自郭先生法律团队"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.12")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/182252")
               '(q () (pre () "
尊敬的战友们好🙏🙏🙏🙏🙏🙏🙏🙏🙏：
 
我们每天都会将郭媒体和网络上战友们对郭先生母亲的哀悼和纪念的信息整理，并向郭先生汇报，郭先生每次听到这些信息，都泪如雨下。
 
郭先生和家人都在按中国的习俗为老人家守“三七”，还有“四七”、“五七”、“七七”、“百天”的准备。郭先生让我转达对战友们衷心的感谢和感激。郭先生母亲的丧礼已全部结束，老人家选择了“二月二龙太头”（三八国际妇女节）早上七点十七分，不打扰任何人安详地离去，最美好、最完美地离开了她的亲人，远离了牵挂和思念。
 
虽然老人家是因共产党的迫害而死，但与杨改兰女士相比，她是幸运的；与那些在“以贪反贪、以黑反贪”的政治运动中，被迫害的千万个家庭的母亲、父亲相比，她也是幸运的。郭先生一直以此来衡量母亲的溘逝，让自己更加有战斗力，更坚定摧毁CCP的决心。未来郭先生唯有向母亲报告和回报的，就是在中国真正实现了法治和信仰的自由。
 
一切都已经是过去，最好的对老人的怀念，就是如何面对现在和未来。老人已经得到了亿万战友的祝福和祈祷，这种大恩大德是无法用语言表达的。郭先生将和战友们奋斗到底，实现喜马拉雅，实现一个让我们父母家人没有恐惧的时代，让天下更多父母不再为担忧儿女而逝，思念儿女而丧。
 
战友们，不能只是盗国贼的父母更换器官，利用民生、民命让他们的父母家人长寿和怪寿，而让我们的父母家人早早因恐惧、威胁和思念而挂在了墙上。也希望所有的战友能从郭先生身上的悲剧得到改变，对父母孝敬，更多地尊敬父母，更多地陪伴父母，让每一个老人都能晚年健康、快乐。不要等到父母挂在墙上时，望着遗像痛哭、自责和无可奈何。 
 
郭先生在此恳求战友，大家全力以赴过好自己的生活，陪伴好自己的父母，在安全的情况下为喜马拉雅奋斗。为保护自己的父母家人，为实现自己的理想，更加团结、坚决地与CCP斗争。所以从今日起，请大家不要在网络上讨论任何关于郭先生母亲逝世的事，唯一对老人的思念和尊重，就是与导致她因思念、担心和恐惧而逝去的CCP战斗到底，让所有中国人的母亲不再有这样的悲剧和恐惧。
 
所有战友的关心，已经让郭先生和家人感到很惶恐和无法形容地感激。为了尊重她老人家的隐私和她一贯低调、作为一个普通人的生活方式，以及满足郭先生家人的要求，请所有战友对老人的追思和哀悼，到此为止。并请大家接受郭先生和所有家人对所有追思战友们的回礼，“三叩九拜”。🙇🏻‍♂🙇🏻‍♂🙇🏻‍♂🙇🏻‍♂🙇🏻‍♂🙇🏻‍♀🙇🏻‍♀🙇🏻‍♀🙇🏻‍♀
 
一起都是刚刚开始！
 
以上内容为郭先生口述，王雁平整理
2019年3月11日 
 
"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=yrdwRkE3vas&feature=youtu.be"
                                 "3/10/2019 特别节目（第三天）：CCP阻挡不了人们自发的各种各样的悼念；战友们悄悄在盘古门口放白色鲜花悼念。")
                             (small () "Youtube")))
                  (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=3juiMmoJ5Tk&feature=youtu.be"
                                 "2019年3月10日：追思郭之慈母——【 佛说阿弥陀经】第三日，以此三日经文为伟大的郭之慈母送行！愿郭之慈母得道多助！仙登极乐！（诵经直播为时1小时，感谢战友们聊天室中悼词！）")
                             (small () "Youtube")))
                  (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=Wvam2k6RSjE&feature=youtu.be"
                                 "战友之声 大卫 慈母安息！为华夏母亲奋斗！ 战友们共勉！")
                             (small () "Youtube")))
                  (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=AumkPoLuAtg&feature=youtu.be"
                                 "谁之殇 英雄流血又流泪 （墙内战友制作）")
                             (small () "Youtube")))
                  (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=2MEJRlZsKOw&feature=youtu.be"
                                 "3/9/2019 特别节目（第二天）：班农在日本共同社演讲悼念文贵先生母亲；墙内大量不能公开发声的体制内外战友发私信表达悼念之情。。。")
                             (small () "Youtube")))
                  (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=q0oqSmicB28&feature=youtu.be"
                                 "曹長青发文感叹郭文贵丧母之痛")
                             (small () "Youtube")))
                  (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=4kD4wWojlJY&feature=youtu.be"
                                 "面具先生--郭奶奶一路走好 我知道你在西方极乐世界看着我们🙏🙏🙏🙏🙏🙏🙏🙏🙏 我会用我的一切 灭掉这个带给所有中国老百姓苦难的共产党🙏🙏🙏🙏🙏🙏🙏🙏🙏")
                             (small () "Youtube"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.9")
        (u (:- "郭文(图片 王雁平): " (@ "https://www.guo.media/posts/181535")))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.8")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/180977")
               '(q () (pre () "
3月7日： 尊敬的战友们好！🙏🙏🙏🙏🙏🙏🙏🙏🙏 我母亲因得知我哥哥再次被盗国贼．CCP非法关监狱的真相及消息后．因悲伤过度而脑血拴！ 紧急抢救无效！ 于2017年农历二月初二早晨7点17分 病逝于医院！ 从即日起文贵将按中国传统在家守孝三期．守孝期间文贵不在看．用．手机！ 愿万佛万神保佑我们所有人的父母平安健康！ 文贵拜上🙏🙏🙏🙏🙏🙏🙏🙏🙏")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/180928")
               '(q () (pre () "3月7日：万万分感谢你们．亲爱的战友们！一切都是刚刚开始！🙏🙏🙏🙏🙏🙏🙏🙏🙏")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/180904")
               '(q () (pre () "
衷心感谢伟大战友们的支持！这是今天刚刚收到的捐款支票！法治基金不会辜负大家的期望！一切都是刚刚开始。")))
           (:- "郭文(视频 报平安): " (@ "https://www.guo.media/posts/180869")
               '(q () (pre () "
3月7号：尊敬的战友好！文贵向大家报平安视频！由于我母亲得知我哥被关在监狱的消息．而脑捨紧急住院！ 所以文贵这几天会很少发郭文．以及不能及时回答战友们私信的问题！共产党不仅杀了我弟弟．关押了我俩个兄弟！抓捕了我全家……几百个同事……他们正在使用他们的最毒的一招．制造压力威胁家人……但是文贵不会放弃……也更不会妥协．这是上天在考验我们！虽然无比痛苦😖！但我能坚持的住……🙏🙏🙏🙏🙏🙏🙏🙏🙏请大家原谅！但愿所有的战友都能多陪陪父母……不要留下太多的遗憾！一切都是刚刚开始！"))
               (u (:- `(cite () 
                             ,(@ "https://www.youtube.com/watch?v=8k-zgNYwl2E"
                                 "3月7日文贵报平安视频。因为母亲住院，近期文贵会很少发视频和回答战友们的私信。谢谢大家的理解。")
                             (small () "Youtube")))))
           (:- "郭文(视频 捐款留言): " (@ "https://www.guo.media/posts/180864")
               '(q () (pre () "衷心感谢！不会辜负你们的鼓励和希望！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.7")
        (u (:- "郭文(图片 捐款留言): " (@ "https://www.guo.media/posts/180688")
               '(q () (pre () "
3月6日：衷(心感谢007及所有支持我们法治基金的战友……法治基金会用结果．与行动．实现目标．实现我们让中国人拥有真正独立与政治之外的以法治国……让我们都活在没有恐惧的我们国家里……一切都是刚刚开始！")))
           (:- "郭文(图片 捐款): " (@ "https://www.guo.media/posts/180605")
               '(q () (pre () "3月6号：法治基金．文贵衷心的感谢，美女战友小百合．为法治基金圈的两比共4千美金！和从昨天到今天很多来自新加坡．和台湾．洛杉矶．战友们捐款．由于文贵这几天有重大事情要忙．不能一一回复．在此表示衷心感谢🙏一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/180588")
               '(q () (pre () "
3月6日：路德先生这节目真的是太棒了👏👏👏👏👏。战友们的心声都听到了！坚决按战友的意愿完成！执行到底！一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=HCmXN-d4Y3U"
                                    "3/6/2019 路德时评：重磅来袭，海航请求法庭撤诉起诉郭文贵诽谤案，海航为什么认怂？为什么明白中计了后悔莫及？文贵先生会同意撤诉吗？为什么这是文贵“围点打援”的重大成功？")
                             (small () "Youtube")))))
           (:- "郭文(图片): "
               (@ "https://www.guo.media/posts/180555") " "
               (@ "https://www.guo.media/posts/180554")
               '(q () (pre () "
3月6号：尊敬的战友们好！你们健身了吗！你们往身上泼水了吗！今天的华尔街日报报导的有关海航撒诉的这一重大的消息．请战友们从更高的战略角度上．和历史事实去看两年来的爆料革命．我们已经拒绝了海航通过各种渠道多次要求的撒诉．和解．这一次．同样我们也拒绝了他们要求撒诉！接下来我们还会继续打这个官司，美国的法律系统给了我们继续打一下去的权利！请战友们拭目以待！好戏刚刚登场！……王岐山盗国贼们的傲慢和权倾天下！在美国的公平司法制度面前完全不灵！他们利用在中国一统天下的力量！用权利决定一切．控制媒体．真相．司法系统，这在美国和西方实践是行不通通的！这就是为什么我们要让中国实现真正的依法治国……独立政治之外的法治系统，文贵今天不直播．一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://cn.wsj.com/articles/海航集团计划撤销对流亡商人郭文贵的诽谤诉讼-11551873310?mod=trending_now_1&tesla=y"
                                    "海航集团计划撤销对流亡商人郭文贵的诽谤诉讼")
                             (small () "2019.3.7 华尔街日报"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.6")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=H5yF3Osa8Yc"
                           "3月5号：为什么在两会上说，金正恩拯救了中国？")
               '(small () "Youtube")
               (u (:- '(pre () "欧洲某个金融小国(卢森堡) 欧洲强国  通电话 关于海航  (我: 送电话 打完再收回去 哈哈哈 这才是真正的端到端加密)"))
                  (:- '(pre () "没有持续性   各扫门前雪"))
                  (:- '(pre () "两会 会议纠察组   北朝鲜 金正恩 帮大忙了 拖延了美国加关税  靠金正恩拯救中共 "))
                  (:- '(pre () "农业开放 0关税  又搬起石头砸到人家脚上 疼的还是老百姓"))
                  (:- '(pre () "金正恩 火车"))
                  (:- '(pre () "周永康 石油钱 -> 王岐山名下"))
                  (:- `(cite () "大卫小哥 YouTube频道 加不上 : "
                             ,(@ "https://www.youtube.com/channel/UCq5haQKrVHnCQ84YmyBn4KA")))
                  (:- '(pre () "祈福"))
                  (:- '(pre () "捐款留言 感谢 每个会看 会留下来   捐款 一定量力而行")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.5")
        (u (:- "郭文(图片): " (@ "https://www.guo.media/posts/180351")
               '(q () (pre () "
3月5日：刚刚的与某国家的司法机构开了一个视频会！帮他们了解有关贯军．和刘呈杰及海航的一些具体的信息．让我非常惊讶😦他们的调查和了解是如此的仔细和深入。这同时我也非常的感慨……我们开始爆料两年……我们中国人来看热闹的多的吓人……用心负责深入调查真相的中国人……寥寥无几……而欧美国家却比我们更加严肃认真的进行调查…… 而这些国家认真的仔细程度让文贵非常佩服！由他们调查伤害中国盗国贼事情的真相……真是感觉奇怪又无奈这些人可是中国的盗国贼呀……他们对海航的了解超出了我的想象，这就是将爆料革命战场拉向国外的核心意义所在……一切都是刚刚开始！"))
               (u (:- '(pre () "姚庆 贯君 刘呈杰"))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/180265")
               '(q () (pre () "3月4日：＂金正恩先拍桌子走人＂……又让文贵懵对了……咋弄呢咋办呢……欺民贼．民运骗子党．们懵了几十年了……咋一回也没懵对呢……"))
               (u (:- `(cite () "llyzs 🐜 @llyzs : "
                             ,(@ "https://twitter.com/llyzs/status/1102569090386845696")
                             (small () "2019.3.5 Twitter")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=EKQZNY15t8o"
                           "2019年3月4日文贵谈10亿欧元支票怎么来的！北京正在进行的两会为什么说2019的64民主全民运动即将来临……")
               '(small () "Youtube")
               (u (:- '(pre () "试直播 看通知是否能受到  骇客有信号干扰"))
                  (:- '(pre () "战友发的信息  注意安全"))
                  (:- '(pre () "听说 两会 很多人 意识到国家风雨飘摇  爆料革命 不是要让国家完蛋 而是要 拯救中国 避免走向灾难 走向不归路"))
                  (:- '(pre () "非洲人都不理解 中共国饭都还没吃饱 却跑去非洲当老大 (我: 就是撒币)"))
                  (:- '(pre () "两会的核心问题 如何避免 经济 国际 自然 人道灾难"))
                  (:- '(pre () "中共自相矛盾"))
                  (:- '(pre () "10亿欧元 钓鱼高手  (我: 那些神经病 歇斯底里 啥都敢说 关键说之前又不先涨涨姿势 想侮辱别人 同时还顺带侮辱自己 我也是佩服了)"))
                  (:- '(pre () "别想去骗 法治基金 的钱"))
                  (:- '(pre () "释大成"))
                  (:- '(pre () "欺民贼"))
                  (:- '(pre () "中共就怕哪天 百姓都上街  两会重大议题 就是 防止经济 重大滑坡  89的那个环境又再一次形成"))
                  (:- '(pre () "祈福"))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/180216")
               '(q () (pre () "3月4日：万分感谢您……这位年轻的战友！务必注意安全……听从内心指引．上天的安排！理解体制内的人的一些事情！必竟他们在那个环境拼搏了一辈子．除了被洗脑教育．还有对CCP的恐惧！一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/180213")
               '(q () (pre () "
3月4日：共产党的智商与对世界文明认知几乎为零．去动物世界海外欺民贼等同！上天是公平公正的……给了他们权力……却拿走了他们做人的基本认知与美好……成为人间烟火……"))
               (u (:- `(cite () "邱岳首 @7k_QYS : "
                             ,(@ "https://twitter.com/7k_QYS/status/1102545872196272128")
                             (small () "2019.3.4 Twitter"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.4")
        (u (:- "郭文(图片): " (@ "https://www.guo.media/posts/180058")
               '(q () (pre () "
3月3日：干了一整天了……越干越有劲……一点睡意都没有……一直都想直播一下……战友们的留言让我知道我应该万万分小心……勤奋……努力💪……不让大家失望！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: Elliot Broidy 邮件"))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/180050")
               '(q () (pre () "
3月3号：3月21号代表CCP的习近平先生将出访欧洲……到意大利梵蒂冈……法国……29号到美国．马阿歌庄园签署中美贸易协议……不包括结构改革……亲爱的战友们你们认为会顺利的发生吗？他将意味着什么呢？一切都是刚刚开始。")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/180018")
               '(q () (pre () "3月3日：谢谢您小扎美女！🙏🙏🙏🙏🙏🙏"))
               (u (:- `(cite () "郭文图片: 小札 @suxinPL : "
                             ,(@ "https://twitter.com/suxinPL/status/1102111209468411905")
                             (small () "2019.3.2 Twitter")))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/180010")
               '(q () (pre () "
3月3号：看到了一个在公开向法制基．叫板．要求法制基金帮助释大成法师．和国内受害战友的公开信息！请这位朋友好好去看看法制基金捐助方式和帮助救助方式的规则！法制基金不是郭文贵的，是所有的捐款者和14亿中国人的！官方网站上公布的可以资助人的方式你都没有看过．却在为你根本不熟悉的释大成法师以及上百万的战友在国内被威胁来要钱……请问这位战友你为他们做了什么？不要打着帮别人！却事实上来挑战法制基金或者根本就是来骗钱！ 在这里装孙子！ 一切都要按照法治基金的官方规则来办．法治基金是所有中国人的基金！不是哪些人都可以敲诈勒索！也不是给一帮骗捐的所谓的人权贩子们利用各种藉口来利用的！我与释大成法师一直保持多个渠道联系！用不着你吃咸萝卜操太监蛋的心！别只会装孙子！有本事你拿点钱拿出点行动，干点实事，别老是用这种敲诈的手段向别人伸手！ 在这个属于中国人的和所有的捐款者的唯一一个华人干净的地方来耍诈！法治基金与所要支持的对象不需要任何中介！……也不需要任何所谓的你们这些骗捐惯犯失败要饭花子们参与！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: 海风快报 @5xyxh (我: 推文被删了 我搜不到)"))))
           (:- "郭文(视频 报平安): " (@ "https://www.guo.media/posts/180003")
               '(q () (pre () "
3月3号：文贵……报平安直播视频！2019年3月3日金正恩为什么直接回朝鲜为什么要枪毙．偷拍金正恩视频的中国人吗？视频中忘了告诉战友们！正在进行的所有谓的两会，将【以法治中国】为这次会议的重要议题！事实上，他们这都是胡扯霸道，只要共产党不灭根本不存在，事实上中国可能在依法治国。但是这就是我们法制基金所存在的价值和他的重大意义……一切都是刚刚开始！"))
               (u (:- `(cite ()
                             ,(@ "https://www.youtube.com/watch?v=C2dCa-Z9Yxg"
                                 "2019年3月3日金正恩为什么直接回朝鲜为什么要枪毙．偷拍金正恩视频的中国人吗？")
                             (small () "Youtube")))
                  (:- '(pre () "广东 打着郭先生名义 捐钱 骗  房地产开发商"))
                  (:- '(pre () "卖李友材料的"))
                  (:- '(pre () "卖信息的 要厚道"))
                  (:- '(pre () "据悉 南宁偷拍金正恩 是 重大政治事件  上面说 偷拍的人 枪毙都应该  为啥不能拍啊"))
                  (:- '(pre () "两会  知识产权保护  对外援助法  大湾区货币  网络信息管理条例"))
                  (:- '(pre () "党内斗争激烈  爆料革命大家都心照不宣"))
                  (:- '(pre () "岐山同志 又住院了 出来后 精神大好 脾气暴躁  大骂 人家洗钱打他名义 让他背后锅 (我: 787谁的 飞行记录上的都谁家人 呵呵)"))
                  (:- '(pre () "经济 政协有人敢提经济问题 P2P 问钱去哪了  GDP到底多少"))
                  (:- '(pre () "内外呼应 炖王八 炖熟了 才能掀锅"))
                  (:- '(pre () "祈福"))))
           (:- "郭文(短视频 捐款留言): " (@ "https://www.guo.media/posts/180002")
               '(q () (pre () "3月3号：衷心的感谢所有的支持发法治基金的战友很多留言！我不能一一的给你回复！法制基金和文贵一定会全力以赴，完成你们的使命，不辜负你们的信任！一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/179991")
               '(q () (pre () "3月3日：10亿欧元．不可思议……这是真的吗？🥵🥵🥵😆😆😆😇😇😇")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/179909")
               '(q () (pre () "3月3：号尊敬的马先生．衷心的感谢您的捐款，你不要为您的表现感到任何的沮丧，事实上不可能每个人都当郭文贵！关键是邪共的势力太大，我们要做好自己关键的关键是不要放弃🙏🙏🙏法治基金会成为您以法报仇！以法正名找回属于自己的尊严．与合法权益．财产的平台！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.3")
        (u (:- "郭文(短视频): " (@ "https://www.guo.media/posts/179813")
               '(q () (pre () "
3月2号：这就是共产党宣传的比爹和娘还亲一的政府．给人民带来的中国梦！和美好生活的向往的结果。事实上，中国绝大部分．山区和边远地区！比这个还恶劣．几年前，我曾去过甘肃，广西，宁夏，西藏．看到山区里的人民比这活得还惨，所以他们才要搞网络控制，不让里面的人知道墙外面的真相。也不让墙外面的人，知道里面发生了什么……一切都是刚刚开始！"))
               (u (:- '(pre () "郭文视频: 山里的穷苦孩子  (我: 贫富差距大不说 看看西部山里孩子的生活学习 就知道 中共没有良知 扶贫就是扯淡)"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/179807")
               '(q () (pre () "3月2号：与战友们分享媳妇刚刚组装的乐高越野赛车！一切都是刚刚开始！"))
               (u (:- `(cite () ""
                             ,(@ "https://shop.lego.com/en-US/product/Rally-Car-42077"
                                 "Rally Car")
                             (small () "Lego shop")))))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/179799") " " (@ "https://www.guo.media/posts/179798")
               '(q () (pre () "
3月2号：尊敬的战友们好．你们健身了吗？你们往身上泼水了吗？今天直播后又将今天早上没有完成的健身刚刚补上！不能给自己的目标，有任何藉口和理由不去完成世上最糟糕的词就是．放弃！一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=_Tb7a63mqOE"
                           "3月2日直播：郭文贵和Sara、安红女士、路德、邱先生谈话")
               '(small () "Youtube")
               (u (:- '(pre () "惊喜 5人连线直播"))
                  (:- '(pre () "北京开两会 躲 追悼会"))
                  (:- '(pre () "金正恩 火车直接回家 计划都乱了 本来两会要邀请金正恩演讲的 取消了 摊上大事了"))
                  (:- '(pre () "锵锵五人行 风花雪月 爱情 婚姻  \"到女人的心里\" 张爱玲")
                      (u '(pre () "到女人心里的路通过阴道 - 张爱玲 <色戒>")))
                  (:- '(pre () "对爱的理解"))
                  (:- '(pre () "澳大利亚政府 对中共的表态  蓝金黄"))
                  (:- '(pre () "经营夫妻关系  性 钱 新鲜感"))
                  (:- '(pre () "情理并重"))
                  (:- '(pre () "(41:00) 海外 欺民贼 内斗"))
                  (:- '(pre () "(59:30) 越南川金会"))
                  (:- '(pre () "中共 川普赢了中期选举 中共输一百年 川普输了 中共就赢一百年 (我: 哈哈哈 做梦呢 川普输赢 中共都亡 为啥 因为它们不停干坏事啊 你让川普输 让川普难过 不还得动用各种手段去影响嘛 只要你动手了 你就已经输了  在泥沙了 以为要死了 赶紧要爬出去 但是 你越动陷得越深 死的越快  那应该怎么办 不要乱动 叫救命 示好 等人来救你)"))
                  (:- '(pre () "先离场的是 金正恩"))
                  (:- '(pre () "中共干的坏事 都国人买单"))
                  (:- '(pre () "(1:18:30) 日本 GDP  夜总会  中日关系"))
                  (:- '(pre () "(1:24:00) 美国出招"))
                  (:- '(pre () "(1:31:00) 中日谈  日本 跟 中共要啥  中共 又要啥"))
                  (:- '(pre () "兴奋啊 美国一定会报越南之仇"))
                  (:- '(pre () "中共 已经 在 案板上了  只是 怎么切的问题"))
                  (:- '(pre () "对付 共产党的 各国的法律支持  反恐 反黑 国家安全"))
                  (:- '(pre () "学习 美国法律"))
                  (:- '(pre () "是美国人让你赢 让你占便宜 不让的时候 你就完"))
                  (:- '(pre () "罢工 停车不走 去银行取钱  中共就完 中南海都是 骗子 没能人"))
                  (:- '(pre () "中共国经济一塌糊涂"))
                  (:- '(pre () "法治基金 第四权 足够的钱"))
                  (:- '(pre () "川普 见 金正恩 前  就预料到这个结果 但是 不想失去这次机会 仍然去跟他谈"))
                  (:- '(pre () "(2:07:00) 不反对别人反习  反共产党 但99%都是好人 不矛盾   要全世界和中国人民联合一起 反对这个制度  用智慧灭共"))
                  (:- '(pre () "毅力 坚持  平板撑比喻  知行合一"))
                  (:- '(pre () "波西米亚狂想曲 皇后乐队 : 试着看清身边所有的人 有的人能帮你找到自己 有的只会掏空你的灵魂"))
                  (:- '(pre () "爆料革命 不需要任何人评价 包括我们自己  一切看结果  中共是否被灭 国人过上有法治的生活?  华人在世界上的形象是否改变?"))
                  (:- '(pre () "猪的文化  猪圈"))
                  (:- '(pre () "(2:38:00) 郭先生 理想追求  家人可以不参与 但不能有一句话反对  如果忘掉八弟的死 家人的遭遇 那就不配当一个人 "))
                  (:- '(pre () "老朋友 到纽约 相见  当说客"))
                  (:- '(pre () "勇气 无私"))
                  (:- '(pre () "(2:50:30) 郭先生的调查团队 发现 王健先生 在 法国的一个保险箱"))
                  (:- '(pre () "郭先生 掌握的王健之死的信息 连10%都没拿出来"))
                  (:- '(pre () "(2:56:50) 捐款留言"))
                  (:- '(pre () "祈福"))
                  (:- '(pre () "谢谢"))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/179739")
               '(q () (pre () "3月2号：尊敬的战友们好！纽约今天下了大雪！非常的漂亮浪漫极了！我正在准备两个小时以后的直播！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文视频: 阳台 纽约飞雪")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.2")
        (u (:- "郭文(照片): " (@ "https://www.guo.media/posts/179616")
               '(q () (pre () "3月1日：看我背后那幅画的里面有谁！"))
               (u (:- '(pre () "画里有 毛"))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/179613")
               '(q () (pre () "
3月1号：支票已经收到．衷心的感谢．陈先生．李先生．胡先生．江先生．S N T先生！邓先生．邓女士．曹女士．一切尽在不言中，万分感激！一切都是刚刚开始！")))
           (:- "郭文(报平安 照片 健身): " (@ "https://www.guo.media/posts/179578")
               '(q () (pre () "3月1号．尊敬的战友们好！你们健身了吗！你们我身上泼水了吗！一切都是刚刚开始！")))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/179568")
               '(q () (pre () "
3月1日尊敬的战友：昨天几乎一整夜的工作，现在刚刚醒来．昨天美国一系列的国会的行动！对我们的爆料革命具有重大影响！世界形势正在巨大的变化中，请国内的战友抓紧休息，文贵稍后再发健身报平安照片！今天没有直播！没有视频！一切都是刚刚开始。"))
               (u (:- '(pre () "Holly Zheng 郑泓  蓝标国际")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.3.1")
        (u (:- "郭文(短视频): " (@ "https://www.guo.media/posts/179406")
               '(q () (pre () "2月28：政事这小哥你在哪？如果你把豆豆还给我们！我就送你一个乐高遥控车可以吗？请回复！请回复！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=mXdOYl7TaA0"
                           "2019年2月28日：文贵报平安谈金正恩谈判的破裂和蓝标公司在美国犯罪的各种信息。")
               '(small () "Youtube")
               (u (:- '(pre () "俯卧撑 撑的装的 墨水抹的 水是浇的"))
                  (:- '(pre () "天机不可泄露"))
                  (:- '(pre () "中岳庙 青城山"))
                  (:- '(pre () "不参与美国政治  但担心 他们的内斗"))
                  (:- '(pre () "越南 川金会 蒙对了  美国没弄明白"))
                  (:- '(pre () "中美贸易 签了协议好 不签也好"))
                  (:- '(pre () "律师  国内也有讲法讲理的 但被中共祸害"))
                  (:- '(pre () "海外反习不反王  给习给中央写报告 总是写 叛国 反习 反共  目的就是 把反盗国贼 变成反习  把习王斗 变成 习郭斗"))
                  (:- '(pre () "都反共 灭共了 还扯反不反习"))
                  (:- '(pre () "起诉 海外那些人"))
                  (:- '(pre () "蓝色光标  私生子女   蓝金黄"))
                  (:- '(pre () "提供信息 蓝标的  Twitt YouTube 被封关 订阅播放数受影响 等的  国内被抓被喝茶的  集体诉讼  赔了郭先生出 赢了大家分"))
                  (:- '(pre () "爆料 哪那么容易  钱 命 上天保佑"))
                  (:- '(pre () "华人形象"))
                  (:- '(pre () "中共圈养国人"))
                  (:- '(pre () "吴仪副总理 聊 中美谈判  忽悠 骗 拖 行贿 威胁 画大饼"))
                  (:- '(pre () "海外 一直被骗 也不发声"))
                  (:- '(pre () "一定不能让中共国最坏的时刻到来"))
                  (:- '(pre () "金正恩 改行程  错过最好机会"))
                  (:- '(pre () "祈福")))))))
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
 "郭文贵" ;; (twb::human-date (get-universal-time))
 "2019.05.04 20:03:38"
 (u (:- "信息源"
        (u (:- "郭媒体 : " (@ "https://www.guo.media/milesguo" "@milesguo"))
           (:- "Youtube : " (@ "https://www.youtube.com/channel/UCO3pO3ykAUybrjv3RBbXEHw/featured" "郭文贵"))
           (:- "Instagram : " (@ "https://www.instagram.com/guowengui/" "guowengui"))))
    (:- "郭七条"
        (u (:- "反对 以黑治国 以警治国 以贪反贪 以黑反贪")
           (:- "不反国家 不反民族 不反习主席")
           (:- '(span (:class "badge badge-secondary") "修改增加: ") "反对以假治国")))
    (:- "蓝金黄 3F美国计划")
    (:- "海航 王健之死")
    (:- "蓝色光标")
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
 "当前关注" ;; (human-date (get-universal-time) )
 "2019.03.11 16:39:50"
 '(p () "这只是部分 我将 增量补充 未来我看了新的视频时 再加入" )
 (u (:- (@ "https://www.youtube.com/channel/UCm3Ysfy0iXhGbIDTNNwLqbQ/featured"
           "路德社")
        '(small () "Youtube"))
    (:- (@ "https://www.youtube.com/channel/UCNKpqIqrErG1a-ydQ0D5dcA/featured"
           "战友之声")
        '(small () "Youtube"))
    (:- (@ "https://www.youtube.com/channel/UCq5haQKrVHnCQ84YmyBn4KA"
           "David大卫")
        '(small () "Youtube"))
    (:- (@ "https://www.youtube.com/channel/UC0JPw1DKfJLj6nbwzUCI7mw"
           "Oz Media")
        '(small () "Youtube"))
    (:- (@ "https://www.youtube.com/channel/UCkU5hWnORzZMZf9SkFmjF6g"
           "木蘭訪談")
        '(small () "Youtube"))
    (:- (@ "https://www.youtube.com/channel/UC66D8Bl3TeNTgyUAG-mcwHg"
           "澳洲新声")
        '(small () "Youtube"))
    (:- (@ "https://www.youtube.com/channel/UCF8iFfXnkbYIUqykN_xpy8g"
           "南十字星")
        '(small () "Youtube"))
    (:- (@ "https://www.youtube.com/channel/UCA3-DEkClR3G1DG1cq8YbeQ"
           "Inty")
        '(small () "Youtube"))
    (:- (@ "https://www.youtube.com/channel/UCQT2Ai7hQMnnvVTGd6GdrOQ"
           "政事直播(政事小哥)")
        '(small () "Youtube"))
    (:- (@ "https://discord.gg/ZhGK3EA"
           "战友之声") 
        '(small () "Discord") )))

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
