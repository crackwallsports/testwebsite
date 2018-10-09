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

(defun @ (title link)
  `(a (:href ,link) ,title))

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
.btn-link {color: #0f175d }
.btn-link:hover {text-decoration:none}"))
    :content
    `(,(site-header)
       (main (:class "content")
             ;; 
             (div (:class "accordion" :id "topic-accordion"
                          :style "width: 80%; font-size: 150%")
                  ;; ,@(loop for v being the hash-values of *news-topics*
                  ;;      collect v)
                  ,@(nreverse *news-topics*)))
       ,(site-footer))
    :scripts `((script (:src "/testwebsite/js/jquery-3.2.1.min.js"))
               (script (:src "https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
                             :integrity "sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
                             :crossorigin "anonymous"))))))

(news-to-topic "郭文贵" "2018.10.08 20:55:26" "")

(news-to-topic
 "中美" "2018.10.09 19:03:05"
 (u (:- '(small () "2018.11")
        "川普 联大演讲")
    (:- '(small () "2018.10.8")
        "美国国务卿 蓬佩奥 访问中共国")
    (:- '(small () "2018.10.4")
        "美国副总统 彭斯 哈德逊演讲")))

(news-to-topic "中共国" "2018.10.08 20:55:26" "")

(news-to-topic
 "美国" "2018.10.09 19:03:05"
 (u (:- '(small () "2018.9.26")
        "川普 联大演讲")))

(news-to-topic
 "中共国 供应链 恶意芯片植入 事件" "2018.10.08 23:01:57"
 (u (:- "主"
        (u (:- '(small () "2018.10.8")
               (@ "Comment: Four more reasons it’s now inconceivable Apple lied about Chinese spy chips"
                  "https://9to5mac.com/2018/10/08/chinese-spy-chip-2/")
               (u (:- "Reasons:"
                      (u (:- "1. " (@ "GCHQ statement" "https://9to5mac.com/2018/10/05/spy-chip/"))
                         (:- "2. " (@ "Department Homeland Security echoed"
                                      "https://9to5mac.com/2018/10/07/department-of-homeland-security-apple-spy-chip/"))
                         (:- "3. " (@ "Reuters reports" "https://www.reuters.com/article/us-china-cyber-apple/apple-tells-congress-it-found-no-signs-of-hacking-attack-idUSKCN1MH0YQ"))
                         (:- "4. " (@ "security researcher Brian Krebs said" 
                                      "https://krebsonsecurity.com/2018/10/supply-chain-security-is-the-whole-enchilada-but-whos-willing-to-pay-for-it/")))))))
        (u (:- '(small () "2018.10.4")
               (@ "What Businessweek got wrong about Apple"
                  "https://www.apple.com/newsroom/2018/10/what-businessweek-got-wrong-about-apple/")
               '(p () "Apple has never found malicious chips
\“hardware manipulations\” or vulnerabilities purposely planted in any server. Apple never had any contact with the FBI or any other agency about such an incident. We are not aware of any investigation by the FBI, nor are our contacts in law enforcement."))))
    (:- "相关"
        (u (:- '(small () "2017.2.23")
               (@ "Apple Severed Ties with Server Supplier After Security Concern" "https://www.theinformation.com/articles/apple-severed-ties-with-server-supplier-after-security-concern?jwt=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiYWR4dDNAZ21haWwuY29tIiwiZXhwIjoxNTcwMjIwNzkyLCJuIjoiR3Vlc3QiLCJzY29wZSI6WyJzaGFyZSJdfQ.ls8yD0SpK1SYLoC7TAaPBL8GPEu9Nd8mutWz0EEdU6o&unlock=ac889c2a9c7ed1fa"))))
    (:- "补充"
        (u (:- '(small () "2018.10.4")
               (@ "The China SuperMicro Hack: About That Bloomberg Report"
                  "https://www.lawfareblog.com/china-supermicro-hack-about-bloomberg-report"))))))
