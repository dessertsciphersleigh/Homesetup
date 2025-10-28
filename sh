#!/bin/bash

# Example function that simulates a long-running process
# writing data gradually to an output file
generate_data() {
  for i in {1..10}; do
    echo "Line $i" >> output.txt
    sleep 2
  done
}

# Clean the output file before starting
> output.txt

# Launch the long process in the background
generate_data &
PID=$!

# While the process is still running, show file size in one line
while kill -0 $PID 2>/dev/null; do
  SIZE=$(du -h output.txt | cut -f1)
  echo -ne "Current size: $SIZE\r"
  sleep 1
done

# Once the process finishes, show final size
SIZE=$(du -h output.txt | cut -f1)
echo -e "\nProcess finished. Final size: $SIZE"