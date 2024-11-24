#!/command/with-contenv sh

START_NUXT=${START_NUXT:-NO}
if [ "$START_NUXT" = "YES" ]; then
    touch /etc/s6-overlay/s6-rc.d/user/contents.d/nuxt3
fi

START_ELASTICSEARCH=${START_ELASTICSEARCH:-NO}
if [ "$START_ELASTICSEARCH" = "YES" ]; then
    touch /etc/s6-overlay/s6-rc.d/user/contents.d/elasticsearch
fi

START_STATIC_BUILDER=${START_STATIC_BUILDER:-NO}
if [ "$START_STATIC_BUILDER" = "YES" ]; then
    touch /etc/s6-overlay/s6-rc.d/user/contents.d/static_builder
fi

if [ -f "/etc/ca/minica.pem" ] && [ ! -f "/usr/local/share/ca-certificates/minica.crt" ]; then
    echo "adding dev CA cert"
    ln -s /etc/ca/minica.pem /usr/local/share/ca-certificates/minica.crt
    update-ca-certificates
fi
