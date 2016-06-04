#!/bin/bash

# Prompt for settings
echo "Please enter your student number:"
read STUDENTNUMBER
echo "Please enter your InfoWeb password:"
read PASSWORD
echo "Please enter the coursecode (e.g. BIO1140):"
read COURSECODE
echo "Please enter the semester code (e.g. 20159):"
read SEMESTERCODE  # e.g. 20159
echo "Please enter your Twitter handle (without the @ symbol):"
read TWITTER

t dm @$TWITTER "Starting change tracking for $COURSECODE" > /dev/null 2>&1

while [ 1 -eq 1 ]; do
	sleep 900
	curl -sS -b ~/.cookies.txt -c ~/.cookies.txt -F "name=$STUDENTNUMBER" -F "pass=$PASSWORD" -F "form_build_id=form-e89e463019185eb2fae4b034459425ea" -F "form_id=user_login" -F "op=Log+In" "http://uozone.uottawa.ca/en/search/timetable/course?CourseCode=$COURSECODE&SessionCode=$SEMESTERCODE" | html2text > ~/.file1.html
	sleep 900
	curl -sS -b ~/.cookies.txt -c ~/.cookies.txt -F "name=$STUDENTNUMBER" -F "pass=$PASSWORD" -F "form_build_id=form-e89e463019185eb2fae4b034459425ea" -F "form_id=user_login" -F "op=Log+In" "http://uozone.uottawa.ca/en/search/timetable/course?CourseCode=$COURSECODE&SessionCode=$SEMESTERCODE" | html2text > ~/.file2.html
	if [[ $(diff ~/.file1.html ~/.file2.html) ]]; then
		if [ `diff ~/.file1.html ~/.file2.html | wc -l` -lt 50 ]; then
			echo " " && echo "Change recorded `date`"
			diff ~/.file1.html ~/.file2.html | colordiff
			t dm @$TWITTER "Changes found for watch on $COURSECODE" > /dev/null 2>&1
		fi
	fi
done
