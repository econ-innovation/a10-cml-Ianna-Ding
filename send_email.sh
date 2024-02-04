#!/bin/bash

# 提供收件邮箱
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 recipient_email"
    exit 1
fi

# 设置收件邮箱
recipient="$1"

# 设置邮件主题
subject="Assignment10"

# 设置邮件正文
body="This is an email used to prove that I did my homework. Whoever reads this email, wish you all the best.\n\nBest regards,\n丁岩钧"

# 请求头
#email_content="Subject: $subject\nFrom: yanjunding1998@163.com\nTo: $recipient\n\n$body"

# 发送邮件
#echo -e "$email_content" | msmtp "$recipient"

# 配置了mutt后
echo "$body" | mutt "$recipient" -s "$subject" 
