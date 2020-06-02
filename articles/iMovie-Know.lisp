(ql:quickload :cl-who)
(in-package :cl-user)
(defpackage imovie-know
  (:use :cl :cl-who)
  ;; (:nicknames :)
  (:export :generate)
  )
(in-package :imovie-know)

(setf (html-mode) :html5)

(defun generate ()
  (->file "articles/imovie-know.html" (site-html)))

(defun ->file (path str)
  (with-open-file (stream path
                          :direction :output
                          :if-exists :supersede
                          :external-format :utf-8)
    (format stream str)))

(defun site-html ()
  (with-html-output-to-string (s nil :indent 2 :prologue t)
    (:html :lang "en"
           (:head (:meta :charset "utf-8")
                  (:link :rel "stylesheet" :href "/testwebsite/css/style.css")
                  (:style "
.content {
 padding: 10px;
}
.topic {
  border: 1px dashed black;
  padding: 3px;
}
small {
  font-size: 60%;
}
html {
  font-size: 90%;
}"))
           (:body (site-header s)
                  (site-main s)))))

(defun site-header (stream)
  (with-html-output (s stream :indent 2)
    (:header :class "side-header"
             (:a :class "logo" :href "/testwebsite/index.html"
                 (:img :src "/testwebsite/resource/carrot.PNG"))
             (:nav :class "contact" :role "navigation"
                   (:ul
                    (:li (:a :href "https://twitter.com/iamnotXt3" "Twitter"))
                    (:li (:a :href "mailto:crackwallsports@gmail.com" "Email")))))))

(defun site-main (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "content"
          (imovie s)
          :br
          (shortcuts s)
          :br)))

(defun iMovie (stream)
  (with-html-output (stream nil :indent 2)
    (:div :class "topic" "iMovie"
          (:small "关键字: " "iMovie")
          (:pre
           "
- 资源库 : 媒体(素材)
  - 事件 : 分类素材
- 片段浏览器 检视器
  - 浏览器中 (黄线 表示 已添加部分)
  - 设定剪辑点 (i o : 入点 出点)
  - 标记 (f u : like unlike (绿线 红线))
- 项目
  - 保存 : 自动 实时
  - 第一个导入视频 决定项目设置
- 时间线 - 磁性 : 调整片段顺序 相互吸附
  - 播放头 浏览头
  - 片段 只是引用 仍然可以拖动两边改变剪辑点
  - 片段间隙
    - 黑线 : 调整过 不连续
    - 间隙小 : 连续 (Del键 可恢复)
  - B-roll : 时间线上方的片段
  - 只支持 两条视频线
    - 主 : 磁性吸附 首尾相连
    - 副 : 吸附在 主线上
  - 音频线
    - 背景线
    - 吸附 多轨
  - 复制 粘贴
    - 粘贴设置 : Edit - 粘贴调整
- Transitions 转场
  - 头尾添加默认转场 : Cmd+t
- Titles 字幕
  - 双击字幕效果 可变更效果而保留已修改的内容
- Audio 音频
  - 设置选择的范围 可单独调整音量
- Speed 速度 (Cmd+t)
  - 倒转
  - 保留高音 (快放慢放的时候 声音失真 勾选能够让高音保留 让声音不会失真)
- 其他
  - 图片合成
"
           ))))

(defun shortcuts (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "topic" "Shortcuts 快捷键"
          (:small "关键字: " "快捷键")
          (:pre
           "
- Shortcuts
  - 播放 : Space
    - Cmd+l : 循环片段
    - \ / : 从头 选择的
  - 导航 (控制浏览头)
    - 后退 停止 前进 : j k l  (双击倍速) 
    - 左右方向键 后退 前进 : 单帧
      - 按住 k 按 j 或 l
    - 上下方向键 : 片段 头尾
  - 设定剪辑点 : i o : 入点 出点
  - 插入片段 :  e w q :  末尾 浏览帧位置 上方
  - 标记 : f u : like unlike (绿线 红线)
  - 设定选择范围 : 按住 r
  - 剪辑
    - Cmd+b : 切开 (在首尾 至少3帧 才能使用)
    - , . : 单帧调整 缩短 or 延长 视频 (!注意: 英文输入法下)
    - Opt+/ : 切去 前面 (若设定了选择范围 则去掉未选择部分)
  - 复制
    - 拖动片段复制 : Opt+Drag
  - 修改B-roll吸附点 : Opt+Cmd 点 B-roll片段
"))))
