#!/bin/sh

get_icon() {
    case $1 in
        # Icons for nerd-fonts
        01d) icon="";;
        01n) icon="";;
        02d) icon="";;
        02n) icon="";;
        03*) icon="";;
        04*) icon="";;
        09d) icon="";;
        09n) icon="";;
        10d) icon="";;
        10n) icon="";;
        11d) icon="";;
        11n) icon="";;
        13d) icon="";;
        13n) icon="";;
        50d) icon="";;
        50n) icon="";;
        *) icon="";

        # # Icons for weather-icons
        # 01d) icon="";;
        # 01n) icon="";;
        # 02d) icon="";;
        # 02n) icon="";;
        # 03*) icon="";;
        # 04*) icon="";;
        # 09d) icon="";;
        # 09n) icon="";;
        # 10d) icon="";;
        # 10n) icon="";;
        # 11d) icon="";;
        # 11n) icon="";;
        # 13d) icon="";;
        # 13n) icon="";;
        # 50d) icon="";;
        # 50n) icon="";;
        # *) icon="";

        # Icons for Font Awesome 5 Pro
        #01d) icon="";;
        #01n) icon="";;
        #02d) icon="";;
        #02n) icon="";;
        #03d) icon="";;
        #03n) icon="";;
        #04*) icon="";;
        #09*) icon="";;
        #10d) icon="";;
        #10n) icon="";;
        #11*) icon="";;
        #13*) icon="";;
        #50*) icon="";;
        #*) icon="";
    esac

    echo $icon
}

get_duration() {

    osname=$(uname -s)

    case $osname in
        *BSD) date -r "$1" -u +%H:%M;;
        *) date --date="@$1" -u +%H:%M;;
    esac

}

format_epoch_time() {

    osname=$(uname -s)

    case $osname in
        *BSD) date -r "$1" +%H:%M;;
        *) date --date="@$1" +%H:%M;;
    esac

}


KEY="968080a335b52d743ca1364a0f93aec8"
CITY="Vaudreuil-Dorion"
UNITS="metric"
#SYMBOL="" # weather-icons
SYMBOL="℃" # nerd font
LANGUAGE=fr

API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
    if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
        CITY_PARAM="id=$CITY"
    else
        CITY_PARAM="q=$CITY"
    fi

    current=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS&lang=$LANGUAGE")
    forecast=$(curl -sf "$API/forecast?appid=$KEY&$CITY_PARAM&units=$UNITS&lang=$LANGUAGE&cnt=5")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        current=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS&lang=$LANG")
        forecast=$(curl -sf "$API/forecast?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS&lang=$LANG&cnt=5")
    fi
fi

if [ -n "$current" ] && [ -n "$forecast" ]; then
    current_temp=$(echo "$current" | jq ".main.temp" | cut -d "." -f 1)
    current_icon=$(echo "$current" | jq -r ".weather[0].icon")

    forecast_temp=$(echo "$forecast" | jq -r ".list[3].main.temp" | cut -d "." -f 1)
    forecast_icon=$(echo "$forecast" | jq -r ".list[3].weather[0].icon")

    if [ "$current_temp" -gt "$forecast_temp" ]; then
        trend=""
    elif [ "$forecast_temp" -gt "$current_temp" ]; then
        trend=""
    else
        trend=""
    fi

    sun_rise=$(echo "$current" | jq ".sys.sunrise")
    sun_set=$(echo "$current" | jq ".sys.sunset")
    now=$(date +%s)

    if [ "$sun_set" -gt "$now" ]; then
        daytime="<span size=\"26pt\" rise=\"-6pt\"></span>$(format_epoch_time "$sun_set")"
    else
        daytime="<span size=\"26pt\" rise=\"-2pt\"></span>$(format_epoch_time "$sun_rise")"
    fi

    echo -n "<span size=\"26pt\" rise=\"-6pt\">$(get_icon "$current_icon")</span> $current_temp$SYMBOL <span size=\"26pt\" rise=\"-6pt\">$trend$(get_icon "$forecast_icon")</span> $forecast_temp$SYMBOL  $daytime"
fi
