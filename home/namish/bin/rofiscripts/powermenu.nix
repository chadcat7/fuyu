_:
''
  #!/usr/bin/env bash

  ## Author : Aditya Shakya (adi1090x)
  ## Github : @adi1090x
  #
  ## Rofi   : Power Menu
  #

  ## Available Styles
  #
  ## style-1   style-2   style-3   style-4   style-5

  # Current Theme

  # CMDs
  host=`hostnamectl hostname`

  # Options
  shutdown='襤 Shutdown'
  reboot=' Reboot'
  lock=' Lock'
  suspend='⏾ Suspend'
  logout=' Logout'
  yes='Yes'
  no='No'

  # Rofi CMD
  rofi_cmd() {
  	rofi -dmenu -p "$host" 
  }

  # Confirmation CMD
  confirm_cmd() {
  	rofi -theme-str 'window {location: center; anchor: northeast; fullscreen: false; width: 250px; x-offset: -6px; y-offset: 44px;}' \
  		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
  		-theme-str 'listview {columns: 2; lines: 1;}' \
  		-theme-str 'element-text {horizontal-align: 0.5;}' \
  		-theme-str 'textbox {horizontal-align: 0.5;}' \
  		-dmenu \
  		-p 'Confirmation' \
  		-mesg 'Are you Sure?' \
  }

  # Ask for confirmation
  confirm_exit() {
  	echo -e "$yes\n$no" | confirm_cmd
  }

  # Pass variables to rofi dmenu
  run_rofi() {
  	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
  }

  # Execute Command
  run_cmd() {
  	selected="$(confirm_exit)"
  	if [[ "$selected" == "$yes" ]]; then
  		if [[ $1 == '--shutdown' ]]; then
  			  poweroff
  		elif [[ $1 == '--reboot' ]]; then
  			  reboot
  		elif [[ $1 == '--suspend' ]]; then
          systemctl suspend
  		elif [[ $1 == '--logout' ]]; then
          loginctl kill-user $USER
  		fi
  	else
  		exit 0
  	fi
  }

  # Actions
  chosen="$(run_rofi)"
  case $\{chosen\} in
      $shutdown)
  		  run_cmd --shutdown
          ;;
      $reboot)
  		  run_cmd --reboot
          ;;
      $lock)
        lock;;
      $suspend)
  		  run_cmd --suspend
          ;;
      $logout)
  		  run_cmd --logout
          ;;
  esac

''
