# KMonad Configuration

## Install service

```
sudo cp ./kmonad /usr/bin/kmonad
```

```
sudo touch /etc/systemd/system/kmonad.service
```

```
[Unit]
Description=KMonad for usb-AONE_Varmilo_Keyboard-event-kbd
[Service]
Restart=always
RestartSec=3
ExecStart=/usr/bin/kmonad /home/james/.config/kmonad/usb-AONE_Varmilo_Keyboard-event-kbd.kbd
Nice=-20
[Install]
WantedBy=default.target
```

```
sudo systemctl start kmonad.service
sudo systemctl enable kmonad.service
```
