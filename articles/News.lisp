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
 (u (:- '(small () "2018.12.12")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/159853")
               '(q () (pre () "
12月11日：没钱了！只能委屈的让自己抽1945年的拉图．大卫雪茄．坐一个6000万美元的飞机．几千万美元的荷兰的船．去一个总统的俱乐部……开一个百万美元的发布会……吃着青菜．没有常委的背景．也不是党员．也不会量震．更没有AG6的车牌．没有任何党派．组织……外交部的特殊保护……穷的只有几亿战友……我这活的太那个了……一切都是刚刚开始！")))
           (:- "郭文(短视频): "
               (@ "https://www.guo.media/posts/159848")
               (@ "https://www.guo.media/posts/159800")
               '(q () (pre () "
12月10日：回到了美丽的蓝天白云的纽约！
12月11日：文贵出发啦！")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/159617")
               '(q () (pre () "12月10日：文贵简单的早餐！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/159612")
               '(q () (pre () "
12月11日：尊敬的战友们好你！们健身了吗！千万不要忘了关注王建之死的真相！和海航背后的故事！千万不要被盗国贼转移了话题！谢谢伟大亲爱的战友们！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2018.12.11")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/159405")
               '(q () (pre () "
12月10日：这位战友总结的好．但是对川普总统结论下的太早了！很快您会看到川普总统与他的超级团队．摧枯拉朽般的横扫CCP及邪恶伙伴国！2019年1月7日后．你们会看到一个伟大的美国总统的练习做总统期结束！ 一个伟大的美国．一个拯救世界的总统．会震惊世界！！！ 比他当初赢得总统大选还会超出想象的一糸列的行动！及创造历史的大事件发生！ 昨天在我在川普总统常去的同一个教堂里一位牧师说．川普做总统是上帝的安排！是一个新世界的开始！我完全相信！ 这是我第一次．无论从私下还是公开斗胆谈我対总统先生的个人观点！ 因为我的一贯原则是不谈美国的任何政治．和政治人物．事件．因为我不配也不懂！ 关于中国政治．人物．事件……我自信我可以与任何人任何机构谈…… 因为CCP正在釆取一切办法在毁坏川普总统他的荣誉……及他的一切！ 我今天在看到这位战友的关于川普总统的这个不客观的推文时．我心血来潮的说一些我的个人无知的观点．望大家多多指教批评！ 当川普总统他确定已被盗国贼控制的中国不是敌人．也没有中国人真的愿意做美国的敌人．而是绑架了14亿中国人的CCP是真正的敌人！而且中美所有的问题的原因制造者．都是CCP的时候！ 解决问题的唯一办法就是法制中国！ 他唯一的决择就是干掉那CCP改变这个邪恶的体制　 这才是他喜欢的大—DEAL— 虽然过去50年美国没有一次赢过CCP……但我相信川普总统会结束这糟糕的一切"))
               (u (:- '(pre () "郭文图片内容: 从里根开始 美国历任总统在任期内 都结束了几个共产或独裁政权 川普总统是否也会?"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/159101")
               '(q () (pre () "
12月10日：纽约检查官的这个决定太是时候了……这将使打开潘朵拉盒子的效果．对CCP更加具有杀伤力……同时美欧国家很快就要对香港护照签证．贸易地位进行重新定位……香港将成为孤岛．臭港……香港一些卖港官员将受到美国的法律调查．这才是大戏的开始！"))
               (u (:- '(pre () "纽约南区法院 驳回 中国农业银行 中国银行 等六家银行 关于撤销财产调查令的申请 并命令六家银行 自收到命令之日起28日内(2018.12.17)执行财产调查令 向美国公开 全部交易记录"))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/159081")
               '(q () (pre () "
12月10日：大连刘乐国因为通过李友案件掌握了．中南海的高官的很多证据被释放．他能活多久？")))
           (:- "郭文: " (@ "https://www.guo.media/posts/159048")
               '(q () (pre () "
12月10日：这位战友的信息让我非常感动……很多像您一样情况的战友给我同样的信息！这让我觉得我更有信心更有责任实现喜马拉雅的．法治中国的目标……我们不能再活在贫穷．恐惧．污染．没有有希望．信仰的猪狗都不如的这样社会环境了！我们14亿人民其实都是在麻木．无望．精神．肉体．亚建康的病态中痛苦挣扎着！我们将彻底改变这些问题……那就是铲除这些盗国贼……让我们拥有健康欢乐有法有信仰自由的新中国！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=uhRUE_v0tT4"
                           "2018年12 月10日：纠正一下昨天直播时的几个口误！刘乐国因为掌握令计划案北大李友案太多案情。")
               (u (:- '(pre () "党内反应最好"))
                  (:- '(pre () "A6 牌照"))
                  (:- '(pre () "量子计算机可能性 投入的国力财力"))
                  (:- '(pre () "千人计划 超过2万人 但不都是坏人  张是间谍是有内部文件的 未来会出来"))
                  (:- '(pre () "王恩哥 2015.2免去北大校长职务 和 2015.10抓捕郭先生家人员工 马健 李友 被抓 相差15到20天"))
                  (:- '(pre () "李友被抓 王恩哥的事就暴露了 江家为保他 就让他去了中国科学院"))
                  (:- '(pre () "刘乐国 接收了案子 改卷宗 删除李友的交待信息"))
                  (:- '(pre () "人民银行副行长 叶一飞"))
                  (:- '(pre () "刘乐国 被抓 被放"))
                  (:- '(pre () "共产党最危险的就是 隐蔽性强"))
                  (:- '(pre () "一个\"最优秀的\"共产党员 三多 : 钱 女人 坏事"))
                  (:- '(pre () "美国法院见"))
                  (:- '(pre () "潘多拉盒子 是否打开 ? 未来某种形式看到 江 朱 孟等 的视频录音的时候 就是潘多拉的盒子被打开了"))
                  (:- '(pre () "香港 警察"))
                  (:- '(pre () "江家为什么这么干? 保自家的安全和利益")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2018.12.10")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/158567")
               '(q () (pre () "
今天很多人说今天已经打开了潘多拉魔盒！ 确定是不是开始打开潘多拉盒子的唯一标准是： 必须是原版的江泽民．江绵恒．王岐山．孟建柱．的音频．视频．银行信息……让大家听到看到！否则都不算打开了潘多拉魔盒！ 一切都是刚刚开始！ 这个南华早报的神秘人物又是北大的…… 我要好好了解一下这个🐂人了！ 找机会向他学习学习！如何能做到全人类都做不到的事情！一个记者能力超过200多个国家所有情报机构的情报搜集能力！ 12月9日：张首晟先生是中共正式党员．我可以负法律责任的在此说明！何时何地．入的党？谁是推荐人？我们会在一层层的关系揭开后看到江．X．朱．王．孟……的上海国际王国！王歧山．孟建柱为什么敢干掉所有的十八．十九届……中央委员．军委委员！或者让他们全闭上嘴！十九大修宪．习王终身主席．副主席！这是谁的设计？如何实现的？多少人为此家破人亡？为什么同时出现了2025．2035．2050……这一切的设计与行动．都开始于中华人民共和国60年大庆！第一次动手就是令谷车祸！当大家无论以什么方式听到看到任何人．任何方式放出的有关录音录像的时候！便是潘多拉盒子真正打开之时⬆️⬆️⬆️以法灭共将正始开启14亿人罚共第一篇！🙏🙏🙏🙏🙏🙏🙏🙏🙏"))
               (u (:- '(pre () "郭文图片: <南华早报>中共国版副主编 周昕 (北大2006届传播学硕士)"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/158556")
               '(q () (pre () "
12月9日：张首晟先生是中共正式党员．我可以负法律责任的在此说明！何时何地．入的党？谁是推荐人？我们会在一层层的关系揭开后看到江．X．朱．王．孟……的上海国际王国！王歧山．孟建柱为什么敢干掉所有的十八．十九届……中央委员．军委委员！或者让他们全闭上嘴！十九大修宪．习王终身主席．副主席！这是谁的设计？如何实现的？多少人为此家破人亡？为什么同时出现了2025．2035．2050……这一切的设计与行动．都开始于中华人民共和国60年大庆！第一次动手就是令谷车祸！当大家无论以什么方式听到看到任何人．任何方式放出的有关录音录像的时候！便是潘多拉盒子真正打开之时⬆️⬆️⬆️以法灭共将正始开启14亿人罚共第一篇！🙏🙏🙏🙏🙏🙏🙏🙏🙏")))
           (:- "郭文: " (@ "https://www.guo.media/posts/158401")
               '(q () (pre () "
12月9日：伟大的战友们好！今天我爆出的人．有多大比例是上海人．江家的人．大家都请记住这些详细信息……否则潘朵拉盒子打开后．你们会懵的……记住我说过的人物．和重点事件……如令谷车祸．马航事件．黎磊石．李保春：两位肾移植专家：将军．跳楼自杀．张阳将军及家人自杀．王健拍照死．孟宏伟被消失……刘特佐藏身上海．吴征代表中纪委．国家电话通知我．全家及员工和资产被抓被封．江家几十年贴身警卫．安全部纪委书记刘彦平来纽约家．伦敦二次见面．索要91号文件．孙力军到华盛顿官说．叫大哥．要91号文件．重金公关．多名间谍欲与美置换文贵……（天哪我写不完了！我要歇一下喽)太多太多了……当我说开盒子的时候大家都会明白了！一切都是刚刚开始！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/158359")
               '(q () (pre () "
12月9日：刚刚从教堂侧所出来时．在侧所门口遇到了这两位女同胞！战友谁认识！帮我介绍一下吧！这是我十几年来第一次在这里遇到华人同胞！还是在＂侧所＂门口！缘份呢！")))
           (:- "郭文: "
               (@ "https://www.guo.media/posts/158396")
               (@ "https://www.guo.media/posts/158355")
               '(q () (pre () "
致歉纠正：“徐光耀”应为“许永跃”，前国安部长！再掴自己脸三次！✊️✊️✊️

12月9日：应是中国科学院……不是社科侁院！文贵今天有几次的口误！自掴脸三后次！😹😹😹💪💪💪😢😢😢")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/158280")
               '(q () (pre () "
“必读必看:你能想象到习近平及CCP不想让你看的惊人照片——为什么摄影师卢光在中国失踪了。”扭腰时报"))
               (u (:- `(cite () ,(@ "https://www.nytimes.com/2018/12/08/opinion/sunday/lu-guang-photographer-missing-china.html"
                                    "A Photographer Goes Missing in China")
                             (small () "2018.12.8 The New York Times")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/158174")
               '(q () (pre () "
12月9日、所谓CCP依仗的干掉．3F美国的核心技术．量子计算与5G……在上天面前不过是上天的其中一个屁……而且是偷骗而来的……一个没有信仰的．没有善良之心．人和团体最终必将失去一切的一切！历史已经给了我们答案！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/158057")
               '(q () (pre () "
12月9日：伟大的战友们好！今天的爆料算不算捞鱼😹😹😹"))
               (u (:- `(cite () "郭文图片中文章: " ,(@ "https://www.bloomberg.com/news/articles/2018-11-30/china-hawk-navarro-is-part-of-trump-entourage-at-g-20-summit"
                                    "China Hawk Navarro Is Part of Trump Entourage at G-20 Summit")
                             (small () "2018.11.30(GMT+8) Bloomberg")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/158003")
               '(q () (pre () "
12月9日：今天的直播在线接近120万人！这就是上次与真相．正义．伟大的战友的力量！今天的黑客非常疯狂．但是我们完成了这个世界上最危险的爆料！文贵really appreciate behind us America firend ...及所有的伟大的……亲爱的战友们！一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=oSRXeu8E8JE"
                           "2018年12月9日：量震床上功夫和G20中美峰會的真相，孟晚舟女士在加拿大被抓與華為公司的背后真相，張首晟先生是自殺還是被殺。")
               '(small () "Youtube")
               (u (:- '(pre () "感谢 战友 量子级挖掘机"))
                  (:- '(pre () "王健之死的调查 因为显摆说太多 导致被动 证人被威胁 不能合作 证据被销毁  吸取教训 不再谈太多细节"))
                  (:- '(pre () "\"道听途说\" 别就信 要去验证"))
                  (:- '(pre () "(5:30) G20晚餐  " )
                      (u (:- '(pre () "<南华早报> 周昕 关于G20的报道"))
                         (:- '(pre () "纳瓦罗 参会 的信息 被报道的时间"))
                         (:- '(pre () "G20会达成的结果 90天 被报道的时间 90天怎么来的?"))
                         (:- '(pre () "晚餐上 中方的答复 为什么符合美方的决策 美方的信息怎么被泄露的?"))
                         (:- '(pre () "知道了G20结果的人 利用这些信息 洗了全球股市 "))
                         (:- '(pre () "美国一个记者说过 只要盯住了几个人 就知道中共国政策的核心  佩服 曾在国会山后见面")
                             (u (:- '(pre () "江泽民 孙子 江志成  其下有二三十个基金和他合作"))
                                (:- '(pre () "香港 和 王岐山 有合作的 几个大家族 基金"))))
                         (:- '(pre () "这些人背后的基金 和 美国背后的几大家族的基金 是大赢家 "))
                         (:- '(pre () "G20前 感恩节回家休息 的 美高层决策者 与 中共派的人 以及它们的欧美战略合作者们 在哪见了面?"))
                         (:- '(pre () "90天 钱是拿到了 拖川普时间"))
                         (:- '(pre () "G20背后的博弈 盗国贼对世界的 蓝金黄"))))
                  (:- '(pre () "(24:20) 华为 孟晚舟 张首晟")
                      (u (:- '(pre () "过去非常尊敬 华为 任正非 被问及华为是否军企都说不知道 这是第一次真正谈华为"))
                         (:- '(pre () "军企(中共国走出去战略): 北方工业集团 中国兵器 保利集团 平安集团 华为集团 阿里巴巴 微信 振兴石油 中兴 中国威视(胡锦涛家)"))
                         (:- '(pre () "这些企业的背后是 江家"))
                         (:- '(pre () "这些企业 在军方有编号 重点扶持和保护的 外交特权"))
                         (:- '(pre () "中共国 物理研究 量子计算机 王恩哥 谷东梅 张首晟  1995百人计划 千人计划创始者"))
                         (:- '(pre () "王恩哥 中共海外的三重身份间谍 窃取高新技术 蓝金黄技术界"))
                         (:- '(pre () "MIT-文小刚 北京数学研究院-田刚院士 北大国际..-牛圈 徐维雅 中国物理学院副秘书长-张喘"))
                         (:- '(pre () "\"量子床震\""))
                         (:- '(pre () "江家 江绵恒 上海科技大学 量子计算机 芯片"))
                         (:- '(pre () "张首晟 2006年就是有编号的 军工特务"))
                         (:- '(pre () "见过 张 3次 京西宾馆和军方一起 发国家一等功时(受奖者...)"))
                         (:- '(pre () "马云是江家代理人 南华早报是江家的 栗战书的料是江家让放的"))
                         (:- '(pre () "美国人 完全不理解 中共 中共国发生的事"))
                         (:- '(pre () "华为的技术后门"))
                         (:- '(pre () "阿里巴巴的技术 大数据"))
                         (:- '(pre () "海航 是第11家 后来 中银也进入"))
                         (:- '(pre () "纽约东区法院 "))
                         (:- '(pre () "不只抓孟晚舟 还要抓另外两个同样级别的人 躲不了的"))
                         ))
                  (:- '(pre () "(1:13:0) 外交部 于情于理 合法"))
                  (:- '(pre () "(1:20:0) 王恩哥 起诉  张首晟 受王健之死影响 不敢回中共国"))
                  (:- '(pre () "建议 美国FBI 根据提供的新线索 重新调查 张的死亡 和他在美国的活动"))
                  (:- '(pre () "美国若不抓 江 马 等  将面临国家安全问题 3F就要成功了"))
                  (:- '(pre () "王恩哥 对 美国的威胁"))
                  (:- '(pre () "\"与你个球..关系啊\""))
                  (:- '(pre () "中共2020完的理由 : 99%的人都不安全 江姥爷的身体 国家要革命时出现的一个独裁 一个国家出现一个英雄(爆料革命启发了党内绝大多数人开智)"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/157921")
               '(q () (pre () "
12月9日：醒来发现还是困……子还想睡觉…………突然想起今天有直播．一下子精神了……就是天生的劳碌命！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片里 有 毛茸茸的考拉")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2018.12.9")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/157763")
               '(q () (pre () "
12月9日：刚刚老领导打电话．问寒问暖！还痛骂了过去的专案组无理粗爆对待我的家人和员工……说有关领导同志要求查清查明真相！给文贵一个公道……老领导没有任何要求．也没提即将发生的直播！我也就一直说感谢🙏看来我今天的直播会让老领导非常不高兴😠……我要去睡会觉啦……一会儿郭媒体直播见．亲爱的战友们！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/157625")
               '(q () (pre () "
https://twitter.com/ae888ea/status/1071180691558277120?s=12 这一天马上就要来啦……"))
               (u (:- '(pre () "转发推文链接内容 : 苏联解体时刻"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/157613")
               '(q () (pre () "
12月8日：尊敬的战友们好：2018年12月9日．文贵将在郭媒体直播谈以下三个问题 第一个G20中美峰会的一些真相与未来可能的发展 第二个孟晚舟女士在加拿大被抓与华为公司的背后的真相！
第三个张首晟先生是自杀还是被杀…… 明天我们将以轻松聊天的形式和大家直播．没有类似杨兰找钥匙的节目．关心未来的人请观看直播！关心男欢女爱的人请不要浪费时间！😹😹😹一切都是刚刚开始✊️✊️✊️")))
           (:- "郭文(短视频): "
               (@ "https://www.guo.media/posts/157567")
               (@ "https://www.guo.media/posts/157471")
               (@ "https://www.guo.media/posts/157469")
               '(q () (pre () "
12月8日：就是这位美丽的女士被深圳警察差点给闷死的！她犯了什么错误！让那位警察像是强奸了他母亲的人那般狠……这就是中国梦……爹亲娘亲不如党的亲！

这位战友的意见非常好！视频原发者应该注入时间．地址！以便声讨……")))
           (:- "郭文(照片): "
               (@ "https://www.guo.media/posts/157467")
               (@ "https://www.guo.media/posts/157459")
               '(q () (pre () "
12月8日：伟大的战友99%都猜对了！1%文贵明天告诉大家！

12月8日：米沙妺．各位小哥！谁能说出来这两个与李源潮的合影是在哪里．那一年．每个人的身份！我明天给你们答䅁！"))
               (u (:- '(pre () "照片中人: 袁贵仁 李智勇 张首晟 李源潮 胡和平 薛其坤"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/157457")
               '(q () (pre () "
12月8日：伟大的米莎妺妹！您太历害了！完全正确！ 今天的马阿拉哥里里外外都特别的棒！到处都充满着圣诞节的气氛！"))
               (u (:- '(pre () "郭先生直播视频里提到劳斯莱斯时 提到的法国人 : Ismaël Emelien"))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=y5YWp9KbQzo" "郭文贵12月8日:船上跟大家聊聊天,文贵现在会捞鱼了..张首晟绝不会自杀!")
               '(small () "Youtube")
               (u (:- '(pre () "因为内容 法务团队 建议 明天在公海上直播 "))
                  (:- '(pre () "登船利益 鞋袜"))
                  (:- '(pre () "劳斯莱斯SUV 定制"))
                  (:- '(pre () "衬衣 心疼自己挣的钱 节俭不浪费 包子 Kiss班农"))
                  (:- '(pre () "网上说得 孟晚舟 张首晟 都是错的 误导的"))
                  (:- `(pre () "G20之前发信息 说要出大事") " "
                      (@ "https://www.guo.media/posts/151427"))
                  (:- '(pre () "8.1 8.2 8.3 发的信息 对一对"))
                  (:- '(pre () "南华早报 什么时候发出信息 说 阿根廷的G20  中美达成和解"))
                  (:- '(pre () "南华邮报 什么时候发出信息 说 纳瓦罗 参与G20会议"))
                  (:- '(pre () "张首晟 和清华谁的关系 在斯坦福和谁在一起 被哪个中共领导接待过 什么时候去过北京 和马云啥关系 贵州大数据什么关系 和上海科技大学啥关系"))
                  (:- '(pre () "和 张首晟 很熟  在秘密场合 多次见过面"))
                  (:- '(pre () "1999在 斯坦福大学边上 住了近6个月"))
                  (:- '(pre () "在 硅谷柱了4个月"))
                  (:- '(pre () "最不想谈的就是华为的事 跟华为 曾经有承诺"))
                  (:- '(pre () "南华邮报 是 中共的"))
                  (:- '(pre () "3扣西装 西装边 裤线"))
                  (:- '(pre () "NSO以色列集团 对 郭媒体有帮助"))
                  (:- '(pre () "美国 对 社交媒体 的 立法")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2018.12.8")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/157079")
               '(q () (pre () "
12月7日：高手在民间．这位战友是好人……高人！"))
               (u (:- '(pre () "郭文图片: 战友对张首晟死亡的猜测"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/156885")
               '(q () (pre () "
12月7日：政事小哥快破解第三个秘密了㊙️……快找到第三把钥匙🔑啦！历害！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/156859")
               '(q () (pre () "
12月7日：今天的会议上有人问了一个有趣的问题！关于华为的！挺震撼的！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/156768")
               '(q () (pre () "
12月7日：尊敬的战友们好！你们健身了吗！一切都是刚刚开始！这两天一直在开会！所以有些战友的私信没有回复！文贵万分抱歉！昨天我发的两台劳斯莱斯SUV轿车引起了很多战友们的关注！也想问我很多该车的问题！这两台车不是我买的！但是我是世界上第一个这个车的定制客户！一次定了四台！下周才能收到！我曾经在2017年刚刚上推时！发过当时我定车的时候的照片！由于该车的选配不同……可以从30万美元至90万美元的价格差异！这台红车就是72万美元．而白的确是62万美元！向关心该车的战友们汇报完毕……大家千万别忘了．挖王健之死．海航的真相哟！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2018.12.7")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/156428")
               '(q () (pre () "
🙏🙏🙏12月6日：对上了．对上了．找着两个钥匙了🔑伟大的天使．战友西行小宝！视频里的5个大秘密㊙️一个小秘密……已经被！大卫小哥．政事小哥．西行小宝．解了两个了……伟大伟大！")))
           (:- "郭文(照片): " (@ "https://www.guo.media/posts/156291")
               '(q () (pre () "12月6日：新款．美国第一辆劳斯莱斯SUV！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/156275")
               '(q () (pre () "12月6日：任正菲先生的女儿．90％的可能不会被引渡到美国！因为这是美国的战略……也是现实！千万千万别低估了B．G．Y．在美国的力量！"))
               (u (:- `(cite ()
                             ,(@ "https://www.theglobeandmail.com/canada/article-canada-has-arrested-huaweis-global-chief-financial-officer-in/"
                                 "Canada arrests Huawei’s global chief financial officer in Vancouver")
                             (small () "2018.12.5 The Global and Mail"))
                      (u (:- `(cite () "中文参考: "
                                           ,(@ "https://www.voachinese.com/a/REPORT-CANADA-HUAWEI-ARREST-20181205/4688446.html"
                                               "加拿大应美国要求逮捕华为首席财务官 中国外交部：立即放人")
                                           (small () "2018.12.6 美国之音")))))))
           (:- "郭文: " (@ "https://www.guo.media/posts/156238")
               '(q () (fpre () "
12月6日：每次回到这个教堂⛪️都让我感慨万千……我现在感觉到了上天众神已经回到了！被抛弃的14亿中国人民心中！没有信仰的人民．国家！什么都不是！什么都不会拥有！12月6日：每次回到这个教堂⛪️都让我感慨万千……我现在感觉到了上天众神已经回到了！被抛弃的14亿中国人民心中！没有信仰的人民．国家！什么都不是！什么都不会拥有！"))
               (u (:- '(pre () "郭先生 到了 佛罗里达州的海湖庄园"))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/156195")
               '(q () (pre () "
12月2日一4日：因为雾霾多少孩子．老人👵住进了医院🏥她们．他们．付的起医药费吗？那些药都是真的吗？"))
               (u (:- '(pre () "华北地区 遭遇 严重雾霾")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2018.12.6")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/155836")
               '(q () (pre () "
巛周恬恬（鲁艳丽）报案以后，教堂底下死了个人，在中午的小镇上还是会沸沸扬扬的。华镔、维亚克跟王健都算有头脸的生意人、年岁大资格老、亲密喝酒的一拨，无论出于情分还是装模作样，也该去现场，之所以根本不去现场，看都不看一眼尸体，就赶紧找警察、找媒体，就是知道王健必死、己死，赶紧善后……》鲁艳丽是酒店登记的名字．周恬恬是一这个翻译可以确定的！她俩是一个人吗！如果是一个人．为什么有两个完全不同姓氏的名字呢……伟大的战友们已经快挖出真相了！🙏🙏🙏🙏🙏🙏😘😘😘😘😘😘")))
           (:- "郭文: " (@ "https://www.guo.media/posts/155683")
               '(q () (pre () "
12月5日：伟大的战友伟大的智慧！虽然这个答案还不能确定……但是凡是！关注深挖王健之死的真相的！都是我们最伟大的战友！"))
               (u (:- '(pre () "这个答案(郭文图片): 死的是王宁 墓地里埋得不是王健")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2018.12.5")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/155546")
               '(q () (pre () "
12月5日：这股票咋又绿了……这经济都脱裤子了！下一步呢……一切都是刚刚开始！"))
               (u (:- `(cite ()
                             ,(@ "https://www.nytimes.com/2018/12/04/business/stephen-bannon-guo-wengui-china.html#click=https://t.co/1wvvS3QTaX"
                                 "Steve Bannon and a Fugitive Billionaire Target a Common Enemy: China")
                             (small () "2018.12.4 The New York Times")))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/155089")
               '(q () (pre () "
12月4日：正在研究设计的郭战友领导是如何的特别！让凯琳及设计师．法毕奥告诉大家！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/155078")
               '(q () (pre () "
12月4日：CCP的经济无法阻止下行也无法阻止人民币．港币的贬值．崩溃…………就像所谓的海外民运永无做为……永远骗捐……永不团结……永远让人看不起一样！没救！")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/154917")
               '(q () (pre () "
12月4日：里根总统当时问军方．我们需要多少年干掉苏联！答案是40年！里根总统说我只能干8年！而且我必须在8年内干掉他们……结果美国用了9年干掉了苏联……解放了14亿东欧人民！"))
               (u (:- `(cite () "视频: "
                             ,(@ "https://d57iplyuvntm7.cloudfront.net/uploads/videos/2018/12/vid_1543940403_62131.MOV")
                             (small () "GUO.MEDIA"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2018.11.4")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/154541")
               '(q () (pre () "
12月3日：我生气啦！我痛苦不堪……因为我的SNOW自从吸了大麻被双规后！茶饭不思寝食难安……我担心……天到处闻来闻去！……不就是找大麻吗……就像……孟维参〈韦石＞屎偌．夏夜凉．李宏宽．家宝胜……欺民贼一样！肛毛里找屎吃……天哪我特别受不了！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/154167")
               '(q () (pre () "
12月3日：尊敬的战友们好．你们健身了吗！我手机里看到的信息都是．找钥匙钓舍头！大家都别被我们自己的周末快乐的直播．将我们的重点忘了！王健之死．海航真相！王岐山．孙力军．1120……拜托了战友们！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2018.12.3")
        (u (:- "视频: " (@ "https://www.youtube.com/watch?v=8yJ0o-IPbKA"
                           "杨澜找钥匙和G20会议的背后真相，开棺验王健的尸，谈谈王岐山，孟建柱，吴征。")
               '(small () "Youtube")
               (u (:- '(pre () "少儿不宜 杨澜 找钥匙 咬舌头 (道听途说)"))
                  (:- '(pre () "中共外交部长G20新闻发布会 \"请文贵发言\""))
                  (:- '(pre () "刘特佐 背景 "))
                  (:- '(pre () "星期天早上直播"))
                  (:- '(pre () "(32:00) G20"))
                  (:- '(pre () "1 三个月能解决它们的腐败 黑恶?"))
                  (:- '(pre () "2 17年的世贸规则破坏 一张合同能解决吗?"))
                  (:- '(pre () "3 美国还会给中共国下一个17年吗?"))
                  (:- '(pre () "4 习若推行桌面上桌面下的声明 能做到吗?"))
                  (:- '(pre () "5 若做到了 谁是最大受益者 ?: 所有人 "))
                  (:- '(pre () "6 若做不到 谁是赢家 ?: 我们 ?: 美国会拉倒吗!"))
                  (:- '(pre () "7 3个月长吗?"))
                  (:- '(pre () "川普总统G20之前 去了哪? 西边加州马里布 见了谁?"))
                  (:- '(pre () "纳瓦罗G20前两周在做什么?"))
                  (:- '(pre () "未来3个月 美国在 军事上 国家政策调整上 台湾香港问题上 知识产权上 货币政策上 会有什么举措"))
                  (:- '(pre () "共产党没了 中国不会乱 (我: 我认为不会乱 它们没了 我们哪还有时间陪着它们瞎折腾 早该干嘛干嘛去了 ...) "))
                  (:- '(pre () "马云 私营企业 国有化"))
                  (:- '(pre () "(57:00) 王健 开棺验尸 FBI立案调查 停尸房 司机 现场人的通话记录 王健的钱 死前的通话记录"))
                  (:- '(pre () "中共国政府 拒绝以国家名义 施压美国 禁止 11.20发布会 岐山同志不开心 亲自给华尔街朋友打电话 给白宫抗议 : 家人照片 贯军是私生子(但是发布会没有说 只说是神秘人) 飞行记录里有真有假(哪些是真的啊? 劳烦岐山同志指一指)"))
                  (:- '(pre () "王伟不让他的妻儿看尸体"))
                  (:- '(pre () "(1:19:00) 模仿问问题 后戴帽子 "))
                  (:- '(pre () "中国的现在的问题 就是那几个人的问题 解决它们 中国就能走向法治"))
                  (:- '(pre () "留学生的问题 反中共 不要反中国人"))
                  (:- '(pre () "英国朋友 香港回归 中国必将改变 西方对中共的看法已经大转弯")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2018.12.2")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/153346")
               '(q () (pre () "12月1日：股市行情即将开始上升🔝")))
           (:- "郭文: " (@ "https://www.guo.media/posts/152989")
               '(q () (pre () "
12月1日：尊敬的芦夫人好！我与班农先生非常希望能帮到您！如有任何需要我们做的！请用郭媒体私信与我联系！私信前加三个徐字！昨天下午班农先生已经与几个大媒体及几个有关部门交流此事！由于我的建议他们暂停了发布的联合声明！因为我不想给您和芦先生带来新的麻烦！如果这几天还不放人！我们将展开一糸列的行动！"))
               (u (:- `(cite () "卢夫人 推特: "
                             ,(@ "https://twitter.com/Xiaoli11032018"
                                 "@Xiaoli11032018")) )))
           (:- "郭文: " (@ "https://www.guo.media/posts/152871")
               '(q () (pre () "
12月1日：President Trump. Vice President Pence. And there is justice all over the world. People of conscience should take a look at this video! Our children are going to have this misery, too. There is no humane treatment! Please pay attention to all this!……为了我们的孩子！文贵拜请所有的战友！🙏🙏🙏🙏🙏🙏🙏😘😘尽一切力量转发给西方领导人！所有看过这个视频的西方朋友都很难过😫很愤怒😡因为这让任何人都无法接受！这是对所有人的威胁！"))
               `(cite () "视频: " ,(@ "https://www.youtube.com/watch?v=31UkYwhfC2s"
                                      "President Trump. Vice President Pence. And there is justice")
                      (small () "Youtube")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/152865")
               '(q () (pre () "
12月1日：我们伟大的战友将这个视频加上字幕后！我发给了很多重要的人！让他们知道！这就是比爹和娘还亲的CCP政府！每时每刻都在中国发生这样的事情！所有的回复都是＂FK＂CCP……")))
           (:- "郭文: " (@ "https://www.guo.media/posts/152780")
               (@ "https://www.guo.media/posts/152873")
               (@ "https://www.guo.media/posts/153121")
               '(q () (pre () "
亲爱的战友们：这是美国司法部对刘特佐JHO LOW的起诉书
1:中国的政府和孟建柱为什么将刘特佐使用国家领导人的级别在上海被保护。
2:为什么文贵在一年半以前就知道他们会不惜一切代价保护刘特佐。
为什么刘特佐和孟建柱.孙立军.吴征.王岐山一起合作，在美国不惜一切代价要遣返郭文贵，缠诉～造谣～妖魔化郭文贵
3:还有人相信郭文贵在大陆.香港遭受的一切的所谓的审判和有关文贵的各种案情吗！我可以负责任的告诉大家.这只不过只是刚刚开始，潘多拉的盒子还没有打开那，一切都是刚刚开始。"))
               (u (:- `(cite ()
                             "起诉书: "
                             ,(@ "https://www.justice.gov/opa/pr/malaysian-financier-low-taek-jho-also-known-jho-low-and-former-banker-ng-chong-hwa-also-known"
                                 "Malaysian Financier Low Taek Jho, Also Known As “Jho Low,” and Former Banker Ng Chong Hwa, Also Known As “Roger Ng,” Indicted for Conspiring to Launder Billions of Dollars in Illegal Proceeds and to Pay Hundreds of Millions of Dollars in Bribes")
                             (small () "2018.11.1 DOJ")))))
           (:- "郭文: " (@ "https://www.guo.media/posts/152658")
               '(q () (pre () "
12月1日：这个新闻太牛啦……这就是B．G．Y．这就是王山．孟建柱．孙力军……对文贵陷害的冰山一角！据说有一个说客一次从吴征．马云．江志诚那里就收了12亿美元！承诺百分百将我弄回去！并同时带着他们害怕的91绝密文件……大家想一想为什么从不认识我的刘特佐个敝孙．花这么大力气．这么多钱要弄我回去！为什么现在孟建柱孙力军使发吃奶的劲集一国之力．对抗美国．马来西亚．保护他……就像王岐山保护海航一样！今明两天还会有大新闻！这就是我说的一切都是刚刚开始！"))
               (u (:- `(cite ()
                             "新闻: "
                             ,(@ "https://www.wsj.com/articles/1mdb-scandal-ensnares-former-justice-department-employee-1543629053?mod=searchresults&page=1&pos=1"
                                 "1MDB Scandal Ensnares Former Justice Department Employee")
                             (small () "2018.11.30 The Wall Street Journal"))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2018.12.1")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/152289")
               '(q () (pre () "
11月30日：刚刚开了9个小时的会！趁进洗手间看一下手机！被部长吓到了！这是真的吗！"))
               (u (:- '(pre () "郭文图片: 从去年要求遣返 郭文贵 的联名信中 看都是些什么人签了名"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/151427")
               '(q () (pre () "
11月30日：请大家关注星期六的世界级媒体！G20可能要出大事！"))
               (u (:- '(pre () "(大事: 等待中...)")))))))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2018/11/guo-news-201811.html" "2018.11")))
 *news-topics-guo*)

(push
 (u (:- (@ "/testwebsite/articles/2018/10/guo-news-201810.html" "2018.10")))
 *news-topics-guo*)

(news-to-topic
 "郭文贵"    ;; (twb::human-date (get-universal-time))
 "2018.12.12 19:54:25"
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
