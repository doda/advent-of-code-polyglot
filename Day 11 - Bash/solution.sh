#!/bin/bash

IFS=',' read -ra steps
for dir in "${steps[@]}"; do
    case $dir in
        n) ((y++)); ((z--)) ;;
        s) ((y--)); ((z++)) ;;
        ne) ((x++)); ((z--)) ;;
        nw) ((x--)); ((y++)) ;;
        se) ((x++)); ((y--)) ;;
        sw) ((x--)); ((z++)) ;;
    esac
    let distance="((x<0?-x:x)+(y<0?-y:y)+(z<0?-z:z))/2"
    let highest="highest<distance?distance:highest"
done
echo Part 1: $distance
echo Part 2: $highest
