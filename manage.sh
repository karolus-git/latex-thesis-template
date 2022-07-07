#!/bin/bash

# $1 is the option provided in the command string

IMAGE=thesis_latex_daemon

# If the start option is given
if [[ $1 == "start" ]]; then
    echo "Start the daemon"
    exec docker run -d --rm --name thesis_latex_daemon -i --net=none -t -v $PWD/thesis:/thesis "$IMAGE" /bin/sh -c "sleep infinity"

# If the stop option is given
elif [[ $1 == "stop" ]]; then
    echo "Stop the daemon"
    exec docker stop thesis_latex_daemon

# If the build option is given
elif [[ $1 == "build" ]]; then
    echo "Build the image"
    exec docker build -t thesis_latex_daemon .

elif [[ $1 == "compile" ]]; then
    echo "Compiling the latex sources"
    find ./ -type f \( -name "*.log" -o -name "*.aux" -o -name "*.bcf" -o -name "*.ilg" -o -name "*.log" -o -name "*.maf" -o -name "*.mtc" -o -name "*.mtc0" -o -name "*.nlo"  -o -name "*.nls" -o -name "*.out" -o -name "*.bbl" -o -name "*.blg" -o -name "*.toc" -o -name "*.bak" -o -name "*.mtc1" -o -name "*.lof" -o -name "*.lot" \) -exec rm -rf {} \;
    
    docker exec -it thesis_latex_daemon bash -c 'pdflatex thesis.tex';
    docker exec -it thesis_latex_daemon bash -c 'makeindex thesis.nlo -s nomencl.ist -o thesis.nls';
    docker exec -it thesis_latex_daemon bash -c 'biber thesis';
    docker exec -it thesis_latex_daemon bash -c 'pdflatex thesis.tex';
    docker exec -it thesis_latex_daemon bash -c 'pdflatex thesis.tex';
else
    echo "Please provide an option in [build|start|stop|compile]"
fi