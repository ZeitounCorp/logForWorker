#!/bin/bash


#---------Defining colors for the outputs
RED='\033[0;31m'
BLUE='\033[0;34m'
GREY='\033[1;30m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
#---------End defining colors area

#----------Global Variable definition area
currentTime=`date +%T`
dayDate=`date '+%A %d-%B, %Y'`

#---------Check if the user closed his previous session
lastOutput=`tail -1 ~/.logWorkHistory.txt`
lastAction=`cut -c 12-16 <<< ${lastOutput}`
startedHour=`cut -c 35-39 <<< ${lastOutput}`

#--------allowedValues: ['start', 'stop']
action=$1

if [ "$1" != "start" ] && [ "$1" != "stop" ]
then
  echo -e "${RED} Allowed values are ['start', 'stop'] ${NC}"
fi
#----------End variable def area

#------Check that the user doesn't try to create a new session while one is still active

if [ "$lastAction" == "start" ] && [ "$1" == "start" ] 
then 
  echo -e "${GREY}You can't start a new session while one is still performing${NC}"
  echo -e "${WHITE}!!! Don't forget to run${NC} ${RED}[./logForWorker stop]${NC} ${WHITE}when you finish your session !!!${NC}"
fi

#------Check that the user doesn't try to stop a non-existing session

if [ "$lastAction" == "stopp" ] && [ "$1" == "stop" ] 
then 
  echo -e "${GREY}No session currently running,${NC} ${RED}did you mean[./logForWorker start] ?${NC}"
fi

#-----If the user want to start a new session and no session is currently running 

if [ "$1" == "start" ] && [ "$lastAction" != "start" ]
then
  echo -e "${RED}Today is:${NC} $dayDate" >> ~/.logWorkHistory.txt 
  echo -e "${BLUE}You started working at${NC} $currentTime" >> ~/.logWorkHistory.txt

  echo -e "${GREY}Thanks for starting a new session ${NC}"
  echo -e "${WHITE}!!! Don't forget to run${NC} ${RED}[./logForWorker stop]${NC} ${WHITE}when you finish your session !!!${NC}"
fi

#-----If user want to stop session

if [ "$1" == "stop" ] && [ "$lastAction" != "stopp" ]
then
  echo -e "${RED}Today is:${NC} $dayDate" >> ~/.logWorkHistory.txt 
  echo -e "${BLUE}You stopped your working session at${NC} $currentTime" >> ~/.logWorkHistory.txt
  
  echo -e "${GREY}Thanks for logging off your session ${NC}"
  echo -e "${WHITE}Your last session started at:${NC} ${BLUE}$startedHour${NC} ${WHITE}and endded at:${NC} ${RED}$currentTime-($dayDate)${NC}"
fi

#------If no parameter past to the script or if values not authorized

if [ "$1" == "" ]
then
  echo -e "${RED}No parameter provided, allowed values are ['start', 'stop'] ${NC}"
fi
