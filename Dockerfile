FROM alpine:3.20 AS postfix

COPY ./ssl/mail.internal.key /etc/ssl/certs/mail.internal.key
COPY ./ssl/mail.internal.crt /etc/ssl/certs/mail.internal.crt
COPY ./postfix/aliases /etc/postfix/aliases
COPY ./dovecot /etc/dovecot

RUN apk update && apk add postfix mailx dovecot dovecot-pop3d \
    && mkdir -p /usr/libexec/dovecot/lmtp \
    && touch /var/log/maillog \
    && postalias /etc/postfix/aliases \
    && mkdir -p /var/spool/postfix /var/mail \
    && mkdir -p /var/mail/mail.internal/gray \
    && chown -R vmail /var/mail && chmod -R 700 /var/mail \
    && mkdir -p /var/log && chmod 1644 /var/log \
    && chgrp -R postdrop /var/spool/postfix/public \
    && chgrp -R postdrop /var/spool/postfix/maildrop \
    && chown root:dovecot /etc/dovecot/users && chmod 640 /etc/dovecot/users

EXPOSE 25 587 110 143 993

# 启动Postfix服务并保持容器运行
CMD ["sh", "-c", "postfix start && dovecot -F"]


# FROM alpine:3.20 AS dovecot

# COPY ./ssl/mail.internal.key /etc/ssl/certs/mail.internal.key
# COPY ./ssl/mail.internal.crt /etc/ssl/certs/mail.internal.crt
# COPY ./dovecot /etc/dovecot

# RUN apk update && apk add dovecot dovecot-pop3d && mkdir -p /usr/libexec/dovecot/lmtp

# RUN addgroup -S postfix && adduser -S postfix -G postfix

# EXPOSE 110 143 993

# CMD ["dovecot", "-F"]
