sleep 10s; 

DISPLAY=:0.0 XAUTHORITY=/var/run/lightdm/root/:0 xwd -root -out /home/mdupuis/loginscreen.xwd; 

convert /home/mdupuis/loginscreen.xwd /home/mdupuis/loginscreen.png; 

rm /home/mdupuis/loginscreen.xwd
