echo "Test email body" | mail -s "Test Subject" root@mail.internal2

postqueue -p

```bash
# 创建私钥
openssl genrsa -out /etc/ssl/private/internal.mailer.key 2048

# 创建证书签名请求 (CSR)
openssl req -new -key /etc/ssl/private/internal.mailer.key -out /etc/ssl/certs/internal.mailer.csr

# 创建自签名证书
openssl x509 -req -days 365 -in /etc/ssl/certs/internal.mailer.csr -signkey /etc/ssl/private/internal.mailer.key -out /etc/ssl/certs/internal.mailer.crt

```

gray@mail.internal
password_gray
