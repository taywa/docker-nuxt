#!/command/with-contenv sh

START_NUXT=${START_NUXT:-NO}
if [ "$START_NUXT" = "YES" ]; then
    touch /etc/s6-overlay/s6-rc.d/user/contents.d/nuxt3
fi

START_ELASTICSEARCH=${START_ELASTICSEARCH:-NO}
if [ "$START_ELASTICSEARCH" = "YES" ]; then
    touch /etc/s6-overlay/s6-rc.d/user/contents.d/elasticsearch
fi
