(ql:quickload :cl-who)
(in-package :cl-user)
(defpackage swift0to1
  (:use :cl :cl-who)
  ;; (:nicknames :)
  (:export :generate)
  )
(in-package :swift0to1)

(setf (html-mode) :html5)

(defun generate ()
  (->file "articles/swift0to1.html" (site-html)))

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
          (what-and-how s)
          :br
          (swift s)
          :br)))

(defun what-and-how (stream)
  (with-html-output (stream nil :indent 2)
    (:div :class "topic" "编程"
          (:small "关键字: " "编程")
          (:pre
           "
- 做什么？ 提出问题
- 如何做？ 写程序 让计算机完成
- 现实的问题 进行抽象 让人理解 找到解决方法 然后 写成计算机理解方式 让计算机来解决
  - 计算机理解的方式 就是 计算方式（过程 步骤）
  - 表达这种计算方式 就是 编程语言
    - 写程序的方法 就是 语法 ： 代表什么 如何组合
    - 语法
      - 语句 分割符 关键字
    - 注释 ：给我们自己看的 辅助我们和他人理解程序
  - 把 解决方法 抽象 为计算（函数）： 输入 计算 输出
    - 程序 = 数据 + 算法 = 数据和结构 + 算法
    - 数据的表示 结构 组合 的表示 
    - 算法的表示
    - 输出 ：像素的组合 形成 字符(文字，数字) 图形 图像 动画
      - 把结果 转换为 人类理解的方式
  - 本质 0和1 表示 即二进制
  - 机器语言 - 汇编语言 - 高级语言（Lisp，C，Swift）
"
           ))))

(defun swift (stream)
  (with-html-output (s stream :indent 2)
    (:div :class "topic" "Swift"
          (:small "关键字: " "语法 程序")
          (:pre
           "
- 语法 ：表示的方式 贯穿整个语言
  - 注释
  - 语句 关键字 保留字 分割符
    - 分号 括号
  - 块 区域 ：作用域
  - 字面量
    - 数值 ：不同进制的表示 
    - 字符串 空字符串 多行字符串 特殊字符(转义) Unicode 标量格式 扩展字符串分隔符
  - 类型安全 ： 类型标注 类型推断
  - 类型别名
  - 操作符 运算符
    - 算术 赋值 逻辑 比较 条件(三元条件) 区间 溢出 合并空值(??)
    - 术语 ：一元、二元、三元 前缀 中缀 后缀
  - 语法糖
  - 特性 ：模式匹配 计算属性 观察属性
  - 可选 ：??
    - 可选项绑定 ： If 语句的强制展开
    - 隐式展开
")
          (:pre

           "
- 程序
  - 数据 ：对象 （数字 文字 逻辑 其他 ?）
    - 基本
      - 数 ： 整数 浮点数
        - 大小范围
")
          ;;:br :hr
          (:ul (num-integer s))
          ;;:hr :br 
          (:pre
           "
      - 逻辑 ： 真 假
        - Bool ： ture false
      - 字符 字符串
        - 编码 ： Unicode 
      - 有无 ：可选 空
        - nil ? !
    - 常量和变量
    - 类型
      - 类型转换
    - 数据结构 组合 ：元组 数组 字典 枚举 结构 类
    - 对象间的关系 ： 继承 协议 泛型
    - 改变 ：扩展 观察 通知 介入    
    - 比较
    - 作用域 生命周期
    - 值类型 引用类型
  - 计算 算法
    - 步骤 ：顺序执行 行 块
    - 过程 ：函数 运算符(语法糖)
    - 分支 ：二分 多分
      - 选择分支 通过 条件判断
    - 重复 ：循环 迭代 递归
    - 并发
    - 特定对象的计算
  - 输出 打印
  - 错误处理 调试
    - ? 为什么程序会出错
    - 运行期 ：捕捉 抛出 传递
    - 调试 ：断言 先决条件
  - 库
  - 工具
"))))

(defun num-integer (stream)
  (with-html-output (stream nil :indent 2)
    (:div :class "topic" "整数"
          (:small "关键字: " "整数")
          (:ul "字面量"
               (:ul (:li "十进制 : 3")
                    (:li "二进制 (0b) : 0b101")
                    (:li "八进制 (0o) : 0o21")
                    (:li "十六进制 (0x) : 0xfa1"))
               (:ul "示例: "
                    ;; 待实现... 导入示例代码片段 : (ex-code-> "整数 字面量")
                    ))
          (:ul "类型"
               (:ul (:li "有符号 : Int")
                    (:li "无符号 : UInt")
                    (:li "位数 : 8 16 32 64"))
               (:ul "说明: " "位数 等同 平台本地字长")
               (:ul "示例: "
                    (:pre "
let signedInt8:Int8 = 127
let unsignedInt32:UInt32 = 32
"))))))
