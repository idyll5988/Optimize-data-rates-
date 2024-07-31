#!/system/bin/sh
[ ! "$MODDIR" ] && MODDIR=${0%/*}
check_reset_prop() {
local NAME=$1
local EXPECTED=$2
local VALUE=$(resetprop $NAME)
[ -z $VALUE ] || [ $VALUE = $EXPECTED ] || resetprop -n $NAME $EXPECTED
}
android_properties="
ro.config.hw_fast_dormancy=1
ro.config.combined_signal=true
telephony.lteOnCdmaDevice=1
ro.ril.enable.5g.prefix=1
ro.ril.hspaclass=15
ro.ril.lteclass=15
ro.ril.gprsclass=34
ro.ril.hsupa.category=10
ro.ril.hsdpa.category=30
ro.ril.lte.category=10
ro.ril.ltea.category=30
ro.ril.enable.a50=1
ro.ril.enable.a56=1
ro.ril.enable.a57=1
ro.ril.enable.a58=1
ro.ril.enable.a59=1
ro.ril.enable.a60=1
persist.wpa_supplicant.debug=false
persist.rmnet.data.enable=true
persist.data.wda.enable=true
persist.data.df.dl_mode=5
persist.data.df.ul_mode=5
persist.data.df.agg.dl_pkt=10
persist.data.df.agg.dl_size=4096
persist.data.df.mux_count=8
persist.data.df.iwlan_mux=9
persist.data.df.dev_name=rmnet_usb0
"
echo "$android_properties" | while IFS= read -r prop; do
prop_name="${prop%%=*}"
prop_value="${prop#*=}"
check_reset_prop "$prop_name" "$prop_value"
done
