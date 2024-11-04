
#!/bin/bash
retries=0
max_retries=999999

while ! pod install; do
    ret=$?  # Save the exit code
    retries=$((retries+1))  # Retry a couple of times
    echo -n "Command failed with an error"
    if [[ $retries -lt $max_retries ]]; then
        echo ", retrying."
    else
        echo ", exit."
        exit 1
    fi
done

echo "Command completed with status $ret"
