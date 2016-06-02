#!/bin/bash

# Fill in your own information here
STUDENTNUMBER=
PASSWORD=
COURSECODE=  # e.g. BIO1140
SEMESTERCODE=  # e.g. 20159


while [ 1 -eq 1 ]; do
	sleep 60
	curl -sS -b ~/.cookies.txt -c ~/.cookies.txt -F "name=$STUDENTNUMBER" -F "pass=$PASSWORD" -F "form_build_id=form-e89e463019185eb2fae4b034459425ea" -F "form_id=user_login" -F "op=Log+In" "http://uozone.uottawa.ca/en/search/timetable/course?CourseCode=$COURSECODE&SessionCode=$SEMESTERCODE" > ~/.file1.html
	sleep 60
	curl -sS -b ~/.cookies.txt -c ~/.cookies.txt -F "name=$STUDENTNUMBER" -F "pass=$PASSWORD" -F "form_build_id=form-e89e463019185eb2fae4b034459425ea" -F "form_id=user_login" -F "op=Log+In" "http://uozone.uottawa.ca/en/search/timetable/course?CourseCode=$COURSECODE&SessionCode=$SEMESTERCODE" > ~/.file2.html
	if [[ $(diff ~/.file1.html ~/.file2.html) ]]; then
		if [ `diff ~/.file1.html ~/.file2.html | wc -l` -lt 50 ]; then
			echo " " && echo "Change recorded `date`"
			diff ~/.file1.html ~/.file2.html | colordiff
			osascript -e "set volume output volume 100 --100%"
			sleep 2
			say "There were changes to the places available page\!"
			sleep 2
		fi
	fi
done
