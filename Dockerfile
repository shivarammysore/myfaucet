FROM faucet/faucet

ENV FAUCET_EVENT_SOCK=0
ENV FAUCET_CONFIG_STAT_RELOAD=true
ENV FAUCET_LOG=STDOUT
ENV FAUCET_EXCEPTION_LOG=STDERR

RUN apk add --update supervisor && rm  -rf /tmp/* /var/cache/apk/*

mkdir -p /var/log/supervisor

COPY faucet.yaml /etc/faucet/

COPY supervisord.conf /etc/supervisord.conf 

# Override Faucet container EXPOSE with our ports to include port
# for hello.  Note 9302 is for Prometehus metrics
#
EXPOSE 9953 9302 8888

CMD /usr/bin/supervisord --configuration /etc/supervisord.conf
