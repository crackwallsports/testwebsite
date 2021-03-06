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
  (->file "articles/iMovie-Know.html" (site-html)))

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
- iMovie : 是 Apple 推出的视频剪辑软件 : https://www.apple.com.cn/imovie/
  - 剪辑支持 : 4K 30fps, 1080p 720p >=30fps
- Help 帮助 : 自带帮助文档
  - 在线 (中文) : https://help.apple.com/imovie/mac/10.1/?lang=zh-%20cn#/
- UI 界面 (位置记忆)
  - 项目内 : 资源库列表 片段浏览器 检视器(预览片段) 剪辑区(时间线)
  - 项目视图 : 播放 复制 分享 删除
- 资源库 : 存放 媒体素材(片段) : 利用 事件 项目 标记 等 分类和整理 素材片段, 方便查找和引用
  - 项目 : 片段 组合 的 一种可能性
    - 类型: 影片 或 预告片
    - 项目配置 : 由第一个 插入 时间线的片段 决定
    - 保存 : 自动 实时
  - 导入 : 复制到库
  - 事件 : 分类素材
- 结构 : 单一资源库 多项目共享 每个项目对应一个影片
  - 资源库位置(默认) : ~~/Movies/iMovie Library.imovielibrary
    - 改变 : [[https://support.apple.com/kb/PH22822?locale=en_US&viewlocale=zh_CN][用于 Mac 的iMovie: 配合多个资源库进行工作]] via Apple Support
- 片段浏览器
  - 搜索 筛选 视图 排序(View - Sort _ by)
  - 设定范围 添加片段 (黄线 表示 已使用的片段范围) : (参考: 剪辑) 
  - 标记 (标记菜单 Mark) : favorite(喜爱 绿线) reject(拒绝 红线) unrate(取消) : f Del u
  - 播放 (显示菜单 View) : 指针(浏览头) (竖线)
    - 播放 : Space
      - 从头 : \
        - 片段 头尾 (时间线) : 方向键 上 下 
      - 选择的范围 : /
      - 后退 停止 前进 : j k l  (双击倍速) 
        - 单帧 : 左右方向键 or 按住 k 按 j 或 l
    - 循环 (开关) : Cmd+l 
    - 全屏 : Cmd+F
- 时间线 - 磁性 : 调整片段顺序 相互吸附
  - 播放头 浏览头
    - 浏览头对齐边缘 Snapping
  - 空间
    - 上 : B-roll : 吸附在主线上 (最多一视频 + 一字幕 )
    - 中 : 主线 : 一条
    - 下 : 音频线 : 吸附在主线上 (多条 可重叠)
    - 最低 : 背景音频线 : 一条
- 剪辑
  - 选择 : 点选 拖拽矩形 连续(Shift) 间隔(Cmd) ...(Edit - Select ...)
  - 设定范围 (时间线 or 片段浏览器)
    - 入点 出点 : i o
    - Or: 按住r 并 拖动光标
    - Or: 拖动黄色边框
  - 插入 (从片段浏览器)
    - 到空白位置 : 拖拽
    - 末尾 浏览头位置 上方 : e w q
    - 选择操作 (替代, 替代从头, 替代从尾, 插入, 取消) : 拖拽到片段上
  - 移动 : [选择] 拖拽 (连同吸附部分)
    - 修改B-roll吸附点 : Opt+Cmd 点 B-roll片段
  - Trim 修剪
    - 拖拽边缘 : 头尾
      - 片段 只是引用, 仍然可以拖动两边 改变剪辑点
      - 单帧 缩短 延长 : 在边缘 , . (!注意: 英文输入法下) 
    - 修剪器 (开关: Windwo - Show Clip Trimmer : Cmd+\)
    - 精确度编辑器 (开关: Windwo - Show Precision Editor : Cmd+/)
      - 微调 片段起始时间, 片段间转场时间长度
      - 拆分编辑 : 片段的音频和视频具有不同起始点或结束点的编辑 (音频延续到下一个开头部分片段)
  - Split 拆分 : Cmd+b
    - 片段间隙
      - 黑线 : 调整过 不连续
      - 间隙小 : 连续 (可恢复: 删除(Del) 间隙)
    - 切去 浏览头 前或后 : Opt+/
  - 复制 粘贴
    - 拖动片段复制 : 按Opt 拖动 (不包括吸附)
    - 粘贴设置 : Edit - Paste Adjustments
- Theme 主题 : Apple 预设的内容样式 (改变: Window - Theme Chooser 或 项目设置内)
- Transitions 转场
  - 插入 : 双击
  - 选中 片段 则 首尾都加
    - 头尾添加 交叉叠化(Cross Disslove) : Cmd+t
  - 改变 : 选中 双击其他转场
  - 修改持续时间 : 默认(iMovie - Preferences), 指定(双击转场)
- Titles 字幕 (占据 B-roll 不可重叠)
  - 添加 : 拖拽到空白, 拖拽到片段吸附 (位置 决定 持续时间)
  - 改变样式 : 选中 双击其他字幕效果 (修改的内容保留)
  - 修改字幕属性 : 检视器 上方 T(字幕设置)
  - 修改持续时间 : 拖动边缘 or 剪到浏览头(Opt+/)
  - 自动保持在 图层最上层
- Background 背景 : Map 动画地图, 单色
- Audio 音频
  - 调整音量 : 拖动
    - 失真(黄色) 严重失真(红色)
    - 部分 : 设置范围
    - 关键帧 : 添加(Cmd+点击) 删除(Ctr+点击)
    - 渐强和渐弱 : 头尾
  - 录音
  - 分离音频 : Opt+Cmd+b
  - 音频设置
    - 音频掠过 Audio Skimming : (开关: S) 移动指针同时 播放音频
    - 检视器上方
      - Volume : 自动(增强平均音量), 音量控制条, 降低其他片段音量
      - 降噪(百分比:减少量) 均衡器
      - 音频效果 (如: Robot)
- Color 颜色 (检视器上方)
  - 自动, 匹配, 白平衡, 肤色平衡
  - 手动调整 : 阴影(黑色滑块) 亮度(灰色滑块) 对比度(半月形滑块) 高亮(白色滑块) 颜色饱和度 色温
- Crop 裁剪 (检视器上方)
  - 还原 : F
  - 旋转
  - Ken Burns 效果 : 放大或缩小动画
- 防抖 修正卷帘快门失真
  - 卷帘快门失真 : 校正 录制时移动太多 或 快动作 导致的图像失真
- 视频效果
  - Filter 滤镜 : 检视器上方, Settings - Filter
  - 渐变效果 : Modify - Fade to
  - 闪现并冻结帧效果 : Modify - Flash and Freeze Frame
  - 静帧 : (开关) Modify - Add Freeze Frame (Opt+f)
  - 叠加设置
    - 覆盖 : 透明度 渐变
    - 蓝绿抠像
    - 分屏
    - 画中画
- Speed 速度 (检视器上方)
  - 加减速 (兔子和乌龟) : 保留高音 (减速将调低音频的音高 加速将调高音高 声音失真)
  - 倒转
  - 即时重放或倒回效果 : Modify - Instant Replay, Rewind
- Info 信息
  - 显示 片段等 信息
  - 修改 持续时间
- 分享 导出
"
           ))))

(defun shortcuts (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "topic" "Shortcuts 快捷键"
          (:small "关键字: " "快捷键")
          (:pre
           "
- 播放 : Space
  - 从头 : \
    - 片段 头尾 (时间线) : 方向键 上 下 
  - 选择的范围 : /
  - 后退 停止 前进 : j k l  (双击倍速) 
    - 单帧 : 左右方向键 or 按住 k 按 j 或 l
  - 循环 (开关) : Cmd+l 
  - 全屏 : Cmd+F
- 标记 (标记菜单 Mark) : favorite(喜爱 绿线) reject(拒绝 红线) unrate(取消) : f Del u
- 设定范围 (时间线 or 片段浏览器)
  - 入点 出点 : i o
  - Or: 按住r 并 拖动光标
  - Or: 拖动黄色边框
- 剪辑
  - 插入 (从片段浏览器) : 末尾 浏览头位置 上方 : e w q
  - 修改B-roll吸附点 : Opt+Cmd 点 B-roll片段
  - 修剪
    - 单帧 缩短 延长 : 在边缘 , . (!注意: 英文输入法下) 
    - 修剪器 (开关: Windwo - Show Clip Trimmer : Cmd+\)
    - 精确度编辑器 (开关: Windwo - Show Precision Editor : Cmd+/)
  - 拆分 : Cmd+b
    - 切去 浏览头 前或后 : Opt+/
  - 拖动片段复制 : 按Opt 拖动 (不包括吸附)
- 还原 重置 : F
"))))
