# dotfiles

## Other Useful Things

### Touchpad

Run `xinput` to find the device name of the touchpad:

```
 xinput
⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
⎜   ↳ PIXA3854:00 093A:0274 Mouse             	id=8	[slave  pointer  (2)]
⎜   ↳ PIXA3854:00 093A:0274 Touchpad          	id=9	[slave  pointer  (2)]
⎜   ↳ ImExPS/2 Generic Explorer Mouse         	id=11	[slave  pointer  (2)]
⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ Video Bus                               	id=6	[slave  keyboard (3)]
    ↳ Power Button                            	id=7	[slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard            	id=10	[slave  keyboard (3)]
```

Find more info about the specific device:

```
xinput list-props "PIXA3854:00 093A:0274 Touchpad"
```

Enable/disable properties:

```
xinput set-prop "PIXA3854:00 093A:0274 Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "PIXA3854:00 093A:0274 Touchpad" "libinput Natural Scrolling Enabled" 1
```

Config:

`/etc/X11/xorg.conf.d/30-touchpad.conf`:

```
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lmr"
    Option "Natural Scrolling" "on"
EndSection
```

Mouse config:

Taken from: https://github.com/i3/i3/issues/3598#issuecomment-660125105

`/etc/X11/xorg.conf.d/99-mouse.conf`:

```
Section "InputClass"
    Identifier "Logitech G Pro"
    MatchDriver "libinput"
    MatchProduct "Logitech G Pro"
    MatchIsPointer "on"
    Option "AccelProfile" "flat"
    Option "AccelSpeed" "-0.1"
EndSection
```
