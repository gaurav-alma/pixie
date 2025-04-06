#!/bin/sh

# Function to run PEM and check its exit code
run_pem() {
    while true; do
        /pem "$@"
        exit_code=$?

        if [ "$exit_code" -ne 100 ]; then
            echo "PEM exited with code $exit_code, not restarting." >&2
            exit "$exit_code"
        fi

        echo "$(date '+%Y-%m-%d %H:%M:%S') - PEM exited with code 100, restarting..." >&2
        sleep 1
    done
}

trap "echo 'Received termination signal, exiting.'; exit" SIGTERM SIGINT

run_pem "$@"
