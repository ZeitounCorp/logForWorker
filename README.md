# logForWorker
Tool for monitoring your employee's working hours
## Requirement(s)

* A bash instance (terminal) (Mac-Os || Linux already have it integrated by default)

## Why this repository ?

I created this tool in order to better understand how my developers spent their time 

## Installation

* Download logForWorker.sh
* Place it inside your ```bin``` folder
* ```mv logForWorker.sh ./logForWorker```
* ```chmod u+x ./logForWorker```
* Edit your .bash_profile by executing ```vim ~/.bash_profile```and add the following function
``` 
check_if_active_session() {
  local lastOutput=`tail -1 ~/.logWorkHistory.txt`
  local lastAction=`cut -c 12-16 <<< ${lastOutput}`
   if [ "$lastAction" == "start" ]
    then
      echo '(active working session) '
   fi
}
```
* Edit your PS1 by adding in it: ```\[\033[32m\]\$(parse_git_branch)\[\033[00m\]```
* By adding this, your prompt will change depending on if there is a current working session or not


## ENJOY 😉 

Made by @Zcorp with 🖤
