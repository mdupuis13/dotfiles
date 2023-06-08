#!/bin/sh

TOKEN="ab5dc4bd4669b1bd7b8ed48a82865c4f73a04913"
CITY="canada/montreal/sainte-anne-de-bellevue"

API="https://api.waqi.info/feed"
prefix=""

if [ -n "$CITY" ]; then
    aqi=$(curl -sf "$API/$CITY/?token=$TOKEN")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        aqi=$(curl -sf "$API/geo:$location_lat;$location_lon/?token=$TOKEN")
    fi
fi

if [ -n "$aqi" ]; then
    if [ "$(echo "$aqi" | jq -r '.status')" = "ok" ]; then
        aqi=$(echo "$aqi" | jq '.data.aqi')

        foreground="#a3be8c"
        if [ "$aqi" -le 50 ]; then
            foreground="#a3be8c"
        elif [ "$aqi" -le 100 ]; then
            foreground="#e5c07b"
        elif [ "$aqi" -le 150 ]; then
            foreground="#fab387"
        elif [ "$aqi" -le 200 ]; then
            foreground="#e06c75"
        elif [ "$aqi" -le 300 ]; then
            foreground="#c678dd"
        else foreground="#ef3d59"
        fi

        echo -n "<span foreground=\"$foreground\">$prefix $aqi</span>"
    else
        echo -n "$aqi" | jq -r '.data'
    fi
fi
