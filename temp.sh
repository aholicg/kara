 for i in /sys/class/hwmon/hwmon*/temp*input; do echo "$(<$(dirname $i)/name): $(cat ${i%}label 2>/dev/null || echo $(basename ${i%})) $(readlink -f $i)"; done 
