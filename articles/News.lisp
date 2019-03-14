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
 "郭文贵"     ;; (twb::human-date (get-universal-time))
 "2019.03.14 20:40:55"
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
