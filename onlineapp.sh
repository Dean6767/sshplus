#!/bin/bash
#roubeidokiritobaiano
fun_online() {
    _ons=$(ps -x | grep sshd | grep -v root | grep priv | wc -l)
    [[ -e /etc/openvpn/openvpn-status.log ]] && _onop=$(grep -c "10.8.0" /etc/openvpn/openvpn-status.log) || _onop="0"
    [[ -e /etc/default/dropbear ]] && _drp=$(ps aux | grep dropbear | grep -v grep | wc -l) _ondrp=$(($_drp - 1)) || _ondrp="0"
    _onli=$(($_ons + $_onop + $_ondrp))
    _onlin=$(printf '%-5s' "$_onli")
    CURRENT_ONLINES="$(echo -e "${_onlin}" | sed -e 's/[[:space:]]*$//')"
    echo "{\"onlines\":\"$CURRENT_ONLINES\",\"limite\":\"1000\"}" > /var/www/html/server/online_app
    echo $CURRENT_ONLINES  > /var/www/html/server/online
}
while true; do
    echo 'verificando...'
	fun_online > /dev/null 2>&1
	sleep 15s
done
