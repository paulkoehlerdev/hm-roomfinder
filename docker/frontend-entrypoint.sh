#!/bin/bash

# get flutter dependencies
flutter pub get

# Define the named pipe
PIPE=/tmp/flutter_pipe

# Create the named pipe if it doesn't exist
if [[ ! -p $PIPE ]]; then
    mkfifo $PIPE
fi

# Start the Flutter process in the background, reading from the named pipe
flutter run -d web-server --web-renderer=auto --web-port=5173 --web-hostname=0.0.0.0 < $PIPE &

# Use a background process to send terminal input to the pipe
# This allows you to input manually to the Flutter process
tee /dev/null <&0 >$PIPE &

# Use `entr` to watch for changes in the specified folder and send "r" to the pipe
# Replace "your_folder" with the folder you want to watch
while true; do
    find /app/lib/ | \
      ENTR_INOTIFY_WORKAROUND=1 entr -d sh -c 'echo "File triggered reload" && echo "r" > '"$PIPE"' || echo "Error writing to pipe"'
done