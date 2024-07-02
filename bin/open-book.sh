path="/home/sawyer/books"

zathura "$path/$(ls "$path" | dmenu -i -fn 'JetBrainsMono-10' -l 10 -c)" &
