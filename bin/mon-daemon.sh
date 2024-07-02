i=0
prev=0
while true; do
    for status in /sys/class/drm/*/status; do
        stat="$(<"$status")"
        case "$stat" in
            "connected")
                i=$((i+1))
                ;;
            *)
                ;;
        esac
    done

    if [ "$i" != "$prev" ]; then
        MONS_NUMBER="$i" sh "$1"
    fi
    echo "$i"
    prev="$i"; i=0
    sleep 2
done
