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
 (u (:- '(small () "2019.2.7")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/174855")
               '(q () (pre () "
2月7日：这纯属巧合！郭骗子蒙对了而已……【蓬佩奥在回答记者采访时说了很多关于中美之间的情况，重点是蓬偑奥的最后一句――他说，他坚信川普总统会在接下来的一年内打败中国（显然，他这里所说的中国应该指的是中共国。）这与文贵爆料革命的既定的喜马拉雅时间不谋而合啊！ 是真的不谋而合还是根本就是有谋而合？这是一个问题，亦是一个天机！】")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=IU63W9OCPLs"
                           "2月6日文贵、班农、凯琳 回答战友们对春晚爆料的问题")
               '(small () "Youtube")
               (u (:- '(pre () "孙立军 每年春节 都给 孟建柱 找处女  吃阴枣 开处  无知 愚蠢 对人类对摧残 (我: 别说班农和凯琳匪夷所思 我都崩溃啊 不是对事惊奇 国内吃胎盘 各种以形补形 多了去了 我崩溃的是它们人 你党这么有权有势也有钱的人 也受过良好教育的人 怎么都这样啊 要玩你也玩点高级的啊 干嘛老做这种禽兽不如的事呢)"))
                  (:- '(pre () "(14:45) 白宫 遣返郭文贵的信 有没有习的亲笔签名 ? "))
                  (:- '(pre () "网友 赞 香港翻译姐姐 太厉害了"))
                  (:- '(pre () "(24:55) 川普总统在昨天 国情咨文中提到的 结构性改革 班农先生是如何理解的 ?")
                      (u (:- `(cite () "美国总统 川普 美国时间2月五日晚 在国会 发表 国情咨文演说 : "
                                    ,(@ "https://www.youtube.com/watch?v=RwrnbSC32sw"
                                        "美国总统特朗普国情咨文特别节目")
                                    (small () "2019.2.5 Youtube (美国之音 中文同声传译)")))
                         (:- '(pre () "川普总统 希望 美国 和 中国 的经济都能够向好 这对世界是最好的 要中共国发生结构性改革 才能真正让中国经济变好"))))
                  (:- '(pre () "(31:30) 能够为 法治基金做什么 以及 如何 捐款 ?")
                      (u (:- '(pre () "提供中共国内的信息 把正在发生的事通过媒体爆出来 联合起来 获得关注"))
                         (:- '(pre () "(33:35) 法治基金 捐款账号"))))
                  (:- '(pre () "不是翻译姐姐 是翻译奶奶"))
                  (:- '(pre () "(40:00) 中共在海外的渗透 盗国 腐败  以及 是否可以使用 RICO法案 对付 中共 ?"))
                  (:- '(pre () "(1:08:40) 休息时间  插播视频: 选择  中共宗教迫害  诉讼进展 "))
                  (:- '(pre () "(1:28:00) 凯琳女士 参与到爆料革命来 感到危险吗 以及 未来要从政的话 先生支持吗 ?"))
                  (:- '(pre () "(1:40:00) 文贵看春晚 在中共国的反应 ? ")
                      (u (:- '(pre () "两个核心问题 : 中共十大罪恶  文贵看春晚十大贡献"))
                         (:- '(pre () "十罪: 不敬天 不敬大地 不孝敬(背叛父母 爹亲娘亲不如党亲) 不忠诚爱情 不忠于兄弟姐妹(不重手足之情) 不忠于自己的国家(共产主义 马克思 列宁) 不诚实 不相信上天(无信仰) 不重仁义 不遵守承诺(失信于天下)"))
                         (:- '(pre () "仁义礼智信 忠孝廉耻勇"))
                         (:- '(pre () "输出到西方"))
                         (:- '(pre () "不反中国人 反中共"))
                         (:- '(pre () "班农先生 让西方能够知道中共的邪恶"))
                         (:- '(pre () "十大贡献:  打开了西方 国际大门 把战场拉到国际上来 让西方强烈的认识到 中共对西方的 政治 经济 文化 军事 宗教信仰 是最大的威胁  然后 西方要什么呢 要 行动 团结 彻底反对中共而不是中国 让全世界 有良知的政治家们知道 反共才是未来 只有反共 只有没掉中共 中国才是世界和平的力量"))))
                  (:- '(pre () "(2:00:00) 中共国 是否可用 委内瑞拉的这种模式革命 ?")
                      (u (:- '(pre () "为什么 中共的一些领导 如 王岐山  在世界上受到推崇 为什么没人说它们盗国贼 ? "))
                         (:- '(pre () "班农先生 是第一个西方政要 公开批评 王岐山 的人 赞班农先生"))))
                  (:- '(pre () "一个欧洲领导人打电话 说 退休领导人俱乐部 都看了 文贵看春晚  还有 梵蒂冈教宗的组织人也看了"))
                  (:- '(pre () "班农先生 来自草根 关心草根 才不关心 什么政要精英喜不喜欢自己"))
                  (:- '(pre () "(2:25:25) 是否会调查起诉 美国之音 以及 台长 阿曼达 ?")
                      (u (:- '(pre () "司法部官员腐败 为中共 为什么没有大肆报道 ?"))
                         (:- '(pre () "班农先生 接受 美国之音的采访 但没有播出  因为说太多中共的压迫百姓的事 谈太多 王岐山 习近平"))))
                  (:- '(pre () "(2:44:50) 为什么 美国的精英 奉承王岐山 不谈论中共的问题 ? ")
                      (u (:- '(pre () "精英们 帮助了 中共   帮凶   要说出来 让人们知道 负起责任 不要再帮助中共"))))
                  (:- '(pre () "法治基金 需要帮助的请联系"))
                  (:- '(pre () "翻译奶奶 实际上 很年轻 特别漂亮 但为了保证她的私生活不受打扰 故不让她出镜 特会穿衣打扮  特善良 特勇敢"))
                  (:- '(pre () "凯琳最美 翻译奶奶最棒 班哥哥最帅 郭先生最调皮"))
                  (:- '(pre () "平民运动"))
                  (:- '(pre () "以人为本"))
                  (:- '(pre () "谢谢")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.6")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/174617")
               '(q () (pre () "
2月5日．尊敬的战友们好！明天2月6日紐約時間上午9點，文贵班農先生．凱琳女士．sara女士．路德先生！共同三方同时直播答戰友提問有关文贵看春晚节目中的有关问题！一切都是刚刚开始！")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=WOMxXzKuy7A"
                           "2/5/2019 文贵先生、SARA、路德大年初一给大家拜年直播")
               '(small () "Youtube")
               (u (:- '(pre () ""))))
           (:- "郭文: " (@ "https://www.guo.media/posts/174571")
               '(q () (pre () "
2月5号：尊敬的战友们好！稍后我会在郭媒体试直播，因为我们已经购买了昨天借用的全部的福克斯专用的视频设备！和翻译系统！现在我们将试用新设备！为了不浪费大家时间！请不要观看，谢谢！！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/174552")
               '(q () (pre () "
2月5日：这是文贵看春晚刚刚开始直播一小时后的数据……这也是美国数据流量统计中显示中国的部分数据……仅仅一小时就到了3千多万……这就是真相的历量！爆料革命的价值！一切都是刚刚开始！"))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.5")
        (u (:- "郭文(照片): " (@ "https://www.guo.media/posts/174443")
               '(q () (pre () "
2月5号：文贵在刚刚在跨过了纽约的农历新年的这一刻！衷心地祝福14亿中国同胞！和所有的战友们及家人！2019年平安健康！🥰🥰🥰一切都是刚刚开始！🙏🙏🙏🙏🙏🙏🙏🙏🙏❤️❤️❤️❤️❤️❤️❤️❤️❤️😍😍😍😍😍😍😍😍😍😘😘😘😘😘😘😘😘😘✊✊✊✊✊✊✊✊✊😻😻😻😻😻😻😻😻😻😻😻🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏🙏")))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/174405")
               '(q () (pre () "2月4日：赶饺子🥟皮！感恩美国感恩战友！感恩上天！🙏🙏🙏🙏🙏🙏🙏🙏🙏"))
               (u (:- '(pre () "围裙 : 秋田犬"))))
           (:- "郭文: " (@ "https://www.guo.media/posts/174379")
               '(q () (pre () "
2月4日：登喜录的196几年的古董雪茄！奖励自己的反共卓越贡献……猜猜我与谁一起享受呢！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: Wifi FBICyberCrimeVan"))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=qBsUEkLhXNc"
                           "2019 文贵看春晚 Miles Guo & Stephen K. Bannon view 2019 Chinese New Year")
               '(small () "Youtube")
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=VS3y9V4mddc"
                                    "主持人登场")
                             (small () "Youtube")))
                  (:- '(pre () "央视春晚 洗脑 欺骗 (我: 蠢完了)"))
                  (:- '(pre () "班农先生 凯琳女士  握手"))
                  (:- '(pre () "班农先生讲述细节 : 白宫遣返郭文贵  吴征 杨澜  王岐山"))
                  (:- '(pre () "民族主义"))
                  (:- '(pre () "凯琳女士  天主教徒  去中共国的经历 天津 湖南男朋友(分手了) "))
                  (:- '(pre () "班农先生 : 香港 自由法治的丧失"))
                  (:- '(pre () "香港 经济 文化 交流分享 自由法治"))
                  (:- '(pre () "一国两制50年不变 过去式"))
                  (:- '(pre () "凯琳女士 : 中英联合声明 渗透香港 没有落实承诺"))
                  (:- '(pre () "班农先生 : 香港没有法治 没有司法保障 谁还敢投资 创业  香港面临的问题不可容忍 全世界应该联合起来做一些事情"))
                  (:- '(pre () "(58:30) 尊者 达赖喇嘛 视频  2014.12")
                      (u (:- '(pre () "郭先生 按 孟建柱 马健 以及 最高领导习近平 的要求 在东京 安排了此次采访"))
                         (:- '(pre () "采访者(中共海外情报机构 外派的间谍): 郑浩(主持) 王继言(台长) 李淼(驻东京记者站记者) 等 凤凰卫视成员"))
                         (:- '(pre () "(1:09:30) 尊者 达赖喇嘛 给习近平的亲笔信"))
                         (:- '(pre () "原件在郭先生那 (我: 郭先生太英明了 保留下了原件)"))
                         (:- '(pre () "大西藏 中间道路 自治 驱赶汉人 转世 自焚 等问题"))
                         (:- '(pre () "郭先生说 当把这些交给孟建柱后 孟说要杀了达赖喇嘛 (我:脏字自己看视频 不再此记录) (我: 如果达赖喇嘛死了 那这份信的内容 就将让西藏人民遵从达赖喇嘛的意思 中共扶植自己的达赖喇嘛成为西藏的新的宗教领袖 西藏人民将不再反抗 完全控制西藏)"))))
                  (:- '(pre () "中共骗了 达赖喇嘛 60年"))
                  (:- '(pre () "郭先生 也被它们 玩了 以为是帮助 达赖喇嘛 回到西藏 让西藏恢复信仰 让中国人有信仰 但却被中共给利用了"))
                  (:- '(pre () "西藏人民已经做出了最大的最诚实的承诺 任何人再反对西藏 再侮辱西藏 都是我们的敌人 世界上有信仰的人的敌人  必须看清除共产党的本质 欺骗欺骗 永远不兑现 "))
                  (:- '(pre () "班农先生 和 凯琳女士 对这封信和视频的感受"))
                  (:- '(pre () "梵蒂冈 教皇 还会相信中共? (我: 与其说中共是给梵蒂冈送钱去了 我觉得 是送了个新神去了)"))
                  (:- '(pre () "美国还能和中共签协议吗 ?: 班农先生 : 中共一小撮人 奴隶一个国家人民 相信美国政府能够认识到这一切 能够醒悟 来帮助14亿人 看明白这封信 中共的欺骗  梵蒂冈也要了解真相"))
                  (:- '(pre () "郭先生 当时问 孟建柱 是否 习近平会正式表态 让达赖喇嘛回国 ?: 孟回答说 : 如果习让他回来 那他就不叫习近平了 习近平将会创造一个最伟大的历史 他将名照千古  孟绝不希望会达到这封信和视频原来的目的 让尊者回国 孟不希望习这么做 "))
                  (:- `(cite () "(2:29:00) 视频: "
                             ,(@ "https://www.youtube.com/watch?v=qOUG3CwGr60"
                                 "宗教信徒是我们的敌人么")
                             (small () "Youtube"))
                      (u (:- '(pre () "凯琳女士 和 班农先生 的感受  信仰自由"))
                         (:- '(pre () "(我: 外交部说 \"中共国有信仰自由 人们想信什么信什么\" 太不要脸了 睁着眼睛说瞎话 这就是中共 用善言掩恶信 掩耳盗铃 我们真蠢 骗的这么直白 我们居然这都信)"))
                         (:- '(pre () "世界的所有信徒 都和 国内的教徒们 在一起 我们不会放弃你们 不会抛弃你们 也不会忘记你们  是我们的信友 教友 也是战友"))))
                  (:- '(pre () "(2:40:00) 香港 绝密文件")
                      (u (:- `(cite () "赴港秘密执法" ,(@ "https://www.youtube.com/watch?v=NtfIYMaWxI0"
                                                          "秘密执法")
                                    (small () "Youtube")))
                         (:- '(pre  () " 合伙人 曲国姣   肖建华"))
                         (:- `(cite () "干预香港司法" ,(@ "https://www.youtube.com/watch?v=Dh2QXVRTwJg"
                                                          "干预司法")
                                    (small () "Youtube")))
                         (:- '(pre  () "曾荫权"))
                         (:- `(cite () "支持香港中资企业 政商双轨制" ,(@ "https://www.youtube.com/watch?v=emwYwzQZAQk"
                                                                         "支持香港中资企业")
                                    (small () "Youtube")))
                         (:- '(pre  () "人民币国际化 党支部 国企化 通过香港企业渗透国外"))
                         (:- '(pre  () "班农先生和凯琳女士 的感受  钱没有真正用到国内 都撒币了"))))
                  (:- '(pre () "(3:0:00) 台湾 绝密文件")
                      (u (:- `(cite () "涉台文件" ,(@ "https://www.youtube.com/watch?v=HT_p-JJ4yug"
                                                      "涉台")
                                    (small () "Youtube")))
                         (:- '(pre  () "中共 担心 蔡英文不承认92共识"))
                         (:- '(pre  () "另外两个文件 暂时不播 给刚刚发信息来的人面子  文件中 涉及到 台湾一些具体的家族 收受中共利益 "))
                         (:- '(pre  () "班农先生和凯琳女士 的感受 "))))
                  (:- '(pre () "(3:08:40) 向 金正恩和金与正 发出的警告")
                      (u (:- '(pre  () "文件的很多附件 会直接发给 北朝鲜当时接待郭先生的朋友"))
                         (:- '(pre  () "文件: 埃利奥特·布洛伊迪(Elliott Broidy) 发给 司法部长的邮件"))
                         (:- '(pre  () "中共高层 5月用 金家 在澳门的账户资产信息给了美国  7月把 金正恩的指纹 生理信息 交给了 美国  用来交换 郭文贵"))
                         (:- '(pre  () "班农先生和凯琳女士 的感受 "))))
                  (:- '(pre () "刘特佐 孟建柱 高盛"))
                  (:- '(pre () "(3:34:00) 恭贺新年"))
                  (:- '(pre () "上天一定灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党 灭掉共产党  共产党会消失 绝对同意"))
                  (:- '(pre () "过去的文贵已经死了 我不会再为金钱活着 我见过钱什么样 我也不会让共产党把我吓倒 我必须为我死去的八弟负责任 29年前向弟弟的骨灰发过誓 一定干掉共产党 我永不妥协 永不改变 无论发生什么事情 都无法改变 过去29年 每时每刻 我都在问自己 我能做到吗 29年的努力 用我的实力 和 我听从上天的召唤 我有绝对的信心 干掉中国共产党 .."))
                  (:- '(pre () "(4:0:40) 失踪的人们")
                      (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=opHH0BmuPvQ"
                                           "失踪的人们")
                                    (small () "Youtube")))
                         (:- '(pre  () "被抓 被失踪 被自杀 "))
                         (:- '(pre  () "网传 王岐山言论 20万被枪毙 (我: 没你党 有法治 哪用得着20万就枪毙 腐败哪有那么猖獗 要用如此极刑)"))
                         (:- '(pre  () "班农先生和凯琳女士 的感受和想法  法治基金  为什么中共国那么多名人死或失踪 却没有任何世界媒体关注? 帮凶 责任  家人 "))
                         (:- '(pre  () "电视认罪"))
                         (:- '(pre  () "钱去哪了"))
                         (:- '(pre  () "王岐山 领导反腐 干掉一千万家庭  魔鬼 灭绝人性  以贪反贪"))
                         (:- '(pre  () "刘鹤父亲 受文革迫害跳楼自杀"))
                         (:- '(pre  () "强烈怀疑 这些文化大革命脑子受过伤的人 是不是 在报复全中国人民 全世界"))))
                  (:- '(pre () "(4:24:20) 人民群众是敌人吗?")
                      (u (:- '(pre  () "王岐山 强拆")
                             (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=yWJWCoVYF_Q"
                                                  "王歧山内部讲话完整版 党内新左王 惊悚建议官员回归原教旨")
                                           (small () "2015.4.13 王岐山书记 在加强 中央纪委派驻机构建设工作培训班 开幕式上 的辅导报告 ")
                                           (small () "2016.2.24 Youtube ")))))
                         (:- '(pre  () "岐山跟郭先生说过 中国人民就是傻X 根本就没有什么文化 一百年都开不了智 对中国人就得虐待 高压维稳"))
                         (:- '(pre  () "王岐山老婆 89年就是美国绿卡 在美国持有大量房产"))
                         (:- '(pre  () "它用事实证明 中国人该打不开智 抓你100万人 千万家庭破灭 500精英死或失踪 没一个敢放屁的 "))
                         (:- '(pre  () "法治基金 RICO法案 保护 立法"))
                         (:- '(pre  () "班农先生和凯琳女士 的感受和想法  对待中国人民 猪狗不如  帮凶 负责  不分享权力 凌驾法律"))))
                  (:- '(pre () "感谢 很早就进入社会"))
                  (:- '(pre () "(4:42:00) 班农先生 介绍 法治基金未来要做什么  继续深入调查 那些失踪死亡的人 海航  让中国能够法治"))
                  (:- '(pre () "法治基金")
                      (u (:- `(cite () ,(@ "https://rolfoundation.org/index.html"
                                           "Rule of Law Foundation")))
                         (:- `(cite () ,(@ "https://rolsociety.org"
                                           "Rule of Law Society")))))
                  (:- '(pre () "..."))
                  (:- '(pre () "祈福"))
                  (:- '(pre () "..."))
                  (:- '(pre () "必须行动"))
                  (:- '(pre () "感谢大家 一切都是刚刚开始"))
                  (:- '(pre () "(未播放视频)")
                      (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=bcfvCSdj5Ls"
                                           "底层商贩是我们敌人么")
                                    (small () "Youtube")))
                         (:- `(cite () ,(@ "https://www.youtube.com/watch?v=It-HvxmPpNo"
                                           "案子进展")
                                    (small () "Youtube"))))))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.4")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/174132")
               '(q () (pre () "
2月3号．按着鬼仔六王岐山的这个说法，他本人应该被枪毙10兆次……鬼子六王岐山……永远用这种似是而非的吃草逻辑！和这种骗人的鬼学！厚黑思想蒙蔽9千万党员！玩弄14亿人民！视他人如猪狗！这是天下最大的恶魔！此人必将遭受上天最大的惩罚…")))
           (:- "郭文: " (@ "https://www.guo.media/posts/174126")
               '(q () (pre () "
2月3号明天直播的站桩已经配套完毕，真是万分感谢！【不尿你】【劳瑞奇】所有的员工们！和意大利总部的鼎力支持！加班加点的完成每套8件套装！一切都是刚刚开始！")))
           (:- "郭文: " (@ "https://www.guo.media/posts/174095")
               '(q () (pre () "
尊敬的战友们好：法治基金所有手续已经注册完毕！即日起全面运行！稍后有关系细节文贵会为大家做视频专门解释！这是官网相关信息，请大家多提意见！一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=nIAHNCucCkM"
                                    "法制基金网站介绍 - Rule of Law Foundation & Rule of Law Society")
                             (small () "Youtube")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=MbxAsQ271SQ"
                           "2019 文贵看春晚中英文双语频道收看方式/ 2019 Miles Guo & Steve Bannon's Chinese New Year Broadcasting Bilingual")
               '(small () "Youtube")
               (u (:- `(cite () "直播链接: " ,(@ "https://www.guo.media/broadcasts")))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=NhyQ0fSdJzU" "2月3号尊敬的战友们好：文贵在2018年的农历年的最后一天，向大家报平安直播。")
               '(small () "Youtube")
               (u (:- '(pre () "2018 经历 意义  说很容易 做真是太难"))
                  (:- '(pre () "文贵看春晚 排演 8小时"))
                  (:- '(pre () "重点: 圣者达赖喇嘛的视频 向北朝鲜金家传递的信息 王孟的新料"))
                  (:- '(pre () "纽约时间 7pm  今夜无人入眠"))
                  (:- '(pre () "防骇客 防攻击"))
                  (:- '(pre () "郭战服 已寄出"))
                  (:- '(pre () "王健之死"))
                  (:- '(pre () "国内\"劝说\"的又来了 郭先生: 要觉得文贵还有恐惧和幻想 那就太不是郭文贵了 幻想不会再有 恐惧从来没有也不会有"))
                  (:- '(pre () "祈福"))
                  (:- '(pre () "全共皆兵 应对文贵爆料"))
                  (:- '(pre () "用真相让全世界人 看到中共的威胁 用真善狠 对它们的假丑恶")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.3")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/173924")
               '(q () (pre () "
2月2号．文贵衷心的感谢所有的战友发给文贵的各种信息－这些七律诗词！万分感激！一切都是刚刚开始！
")))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=BtYvR4MW8U8"
                           "2月2号尊敬的战友们好：你们健身了吗？文贵正在准备着文贵看春晚的节！正在高度关注委内瑞拉的局势变化！和3月20号习近平先生的访问梵蒂冈！川金会川习会！一切都是刚刚开始！")
               '(small () "Youtube")
               (u (:- '(pre () "2,3月 是 大日子  川金会  川习会(会不会发生呢?)"))
                  (:- '(pre () "宗教 3.20 习近平访问梵蒂冈"))
                  (:- '(pre () "欧洲某国总理 说 以个人担保 政府担保 要接郭先生去 他们国家和梵蒂冈演讲"))
                  (:- '(pre () "美国某地的天主教聚会 想让郭先生去 2月底 连续3,4天"))
                  (:- '(pre () "委内瑞拉 变化 内部在讲数 勾兑  值得借鉴的经验"))
                  (:- '(pre () "中美贸易 原来预测的戏剧性 但还没结束"))
                  (:- '(pre () "每逢佳节倍思亲  保重身体")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.2")
        (u (:- "郭文(图片): "
               (@ "https://www.guo.media/posts/173796")
               (@ "https://www.guo.media/posts/173795")
               '(q () (pre () "
前美国司法部员工George Higginbotham 因腐败被公诉书

DOJ George Higginbotham Indictment"))
               (u (:- '(pre () ""))))
           (:- "视频: " (@ "https://www.youtube.com/watch?v=DpoaPWqlXz4"
                           "2月1号尊敬的战友们好。你们健身了吗！一切都是刚刚开始！文贵来谈谈海航王建被自己的生殖器戳死的法国解放报的报道……和昨天刘鹤．被羞辱后的自己的感受！")
               '(small () "Youtube")
               (u (:- '(pre () "开会 研究RICO法案  法治基金英文名"))
                  (:- '(pre () "文贵看春晚 团队彩排"))
                  (:- '(pre () "刘鹤 个人是不错的 但它效忠了魔鬼集团"))
                  (:- '(pre () "刘鹤 昨天在 总统办公室的情景  郭先生 感觉不舒服 心情不好  可怜 但美国没必要这么做 大国要有大国的风范  可悲 这样的人才落得如此下场  可恨 它们的骗和中共的厚黑学"))
                  (:- '(pre () "法国 解放报的报道 王健死 (我: 不懂法文 不知道是否翻译有误 关于生殖器插入腹腔  我看这报道时 是下身 是早先翻译错 还是理解错?) :")
                      (u (:- `(cite () 
                                    ,(@ "https://www.liberation.fr/france/2019/01/30/wang-et-la-chute-du-mur-de-bonnieux_1706487"
                                        "Wang et la chute du mur de Bonnieux")
                                    (small () "2019.1.30 Libération")))
                         (:- `(cite () 
                                    ,(@ "http://cn.rfi.fr/中国/20190131-海航前董事长王健死于意外还是谋杀"
                                        "海航前董事长王健死于意外还是谋杀？")
                                    (small () "2019.1.31 (2.1修改) 法广")))))
                  (:- '(pre () "郭先生 还没有亮王健死的证据 让它们先玩 先演"))
                  (:- '(pre () "祈福")))))))
 *news-topics-guo*)

(push
 (u (:- '(small () "2019.2.1")
        (u (:- "郭文: " (@ "https://www.guo.media/posts/173713")
               '(q () (pre () "
2月1日：好消息又来啦…… 美国司法部今天宣布，美国DC地方法院提起民事没收诉讼，要求没收和追回超过7300万美元的资金，这些资金与国际阴谋欺诈美国金融机构以及通过金融机构洗钱有关。 刘特佐．孟建柱的私生子……Jho Low，与孟建柱及孙立军还有吴征这个畜生都是一回事儿的搞事者……对爆料革命而言！这好事儿实在都应接不暇了！太搞笑了！共产党的政法委书记……还有他的秘书．搞政治保护的情报高官！公安部副部长孙力军！和一个天天带着老婆找钥匙的娱乐骗子吴征！搞了这么大一个国际腐败案件！这是对14亿中国人和中国450万政法战线的侮辱！"))
               (u (:- `(cite () "郭文图片: "
                             ,(@ "https://www.justice.gov/opa/pr/us-seeks-recover-over-73-million-proceeds-traceable-bank-fraud-conceal-involvement-jho-taek"
                                 "U.S. Seeks to Recover over $73 Million in Proceeds Traceable to Bank Fraud to Conceal the Involvement of Jho Taek Low")
                             (small () "2018.11.30 DOJ")))))
           (:- "郭文(图片): " (@ "https://www.guo.media/posts/173638")
               '(q () (pre () "
1月31号：尊敬的战友们．这是美国司法部！第一例涉及外国人的內部人员．乔治．辛吉波萨姆的腐败案件起诉书！美国的参与腐败者！就是共和党的筹款委员会成员之一．公关公司．艾立．搏一迪．外国人就是中国的孟建柱孙立军吴征！马来西亚的刘特佐！这是一个极其罕见震惊了美国司法界的具有代表性的案例！来自中共的蓝金黄的真实案例！很多细节和犯罪都和文贵及爆料有关！通过这个案件！可以看到共产党对文贵的打压迫害，恐惧到了什么程度！稍后我会将英文原版的起诉书也挂出来！这个案件是打开孟建柱孙立军．吴征！在美国及其他国家犯罪，洗钱，找钥匙🔑！😂😂😂行贿外国官员的证据之一！这其中的部分钱就有投资到了明镜媒体！及博讯媒体！和在西方的很多砸锅的所谓自媒体！以及支付缠讼文贵的律师费……所有的这些钱的去向都将会被一一．查清．这是天赐的礼物！一切都是刚刚开始！"))
               (u (:- '(pre () "郭文图片: 起诉书(中文版)"))))
           (:- "郭文(报平安 短视频): " (@ "https://www.guo.media/posts/173556")
               '(q () (pre () "
1月3 11号尊敬的战友们好：你们健身了吗？你们往身上泼水了吗！今天的纽约刚刚下过雪！阳光明媚！非常非常特别！非常非常的舒服！一切都是刚刚开始！"))
               (u (:- `(cite () ,(@ "https://www.youtube.com/watch?v=_hwPBCM0Edc&feature=youtu.be"
                                    "1月31日郭文贵详解美中談判 华盛頓的早餐相當不平靜")))
                  (:- '(pre () "华盛顿 都要求整出几张纸来 不要把话说绝了 互相欺骗 打太极"))
                  (:- '(pre () "战友的那些不能公开的话和信息 将成为追求法治自由信仰的中国 最最伟大的信息和资料  郭先生将永久保存"))
                  (:- '(pre () "春节 别大吃大喝 烂醉 太滥俗  珍惜自己和他人的生命健康"))
                  (:- '(pre () "收到 很多 韩文的信息 尽量明白 谢谢"))))
           (:- "郭文(短视频): " (@ "https://www.guo.media/posts/173435")
               '(q () (pre () "
1月30日：文贵衷心感谢战友之声和战友麦子！做的这个文贵看春晚的视频！万分感激！一切都是刚刚开始！"))
               (u (:- `(cite () "郭文视频: "
                             ,(@ "https://www.youtube.com/watch?v=_Km8rIQ4hg8"
                                 "喜迎文贵看春晚，战友们的春晚，中国人的春晚！战友之声视频剪辑组义工们太棒了！")
                             (small () "Youtube"))))))))
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
 "郭文贵"   ;; (twb::human-date (get-universal-time))
 "2019.02.07 20:44:34"
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
 "2019.02.07 20:43:53"
 (u (:- '(small () "2019.2.7") "美国总统 川普 美国时间2月五日晚 在国会 发表 国情咨文演说"
        (u (:- `(cite () ""
                      ,(@ "https://www.youtube.com/watch?v=RwrnbSC32sw"
                          "美国总统特朗普国情咨文特别节目")
                      (small () "2019.2.5 Youtube (美国之音 中文同声传译)")))))
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
