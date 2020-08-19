FROM ossec_server:3.6.0

COPY decoder.xml /var/ossec/etc/decoder.xml
COPY ossec.conf /var/ossec/etc/ossec.conf
COPY local_rules.xml /var/ossec/rules/local_rules.xml
COPY docker-entrypoint.sh /tmp/docker-entrypoint.sh
RUN chmod +x /tmp/docker-entrypoint.sh
RUN chmod 444 /var/ossec/etc/client.keys
