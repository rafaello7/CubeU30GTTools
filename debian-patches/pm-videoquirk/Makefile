videqquirk: videqquirk.c
	gcc videqquirk.c -o videqquirk

clean:
	rm -f videqquirk

install:
	install videqquirk /etc/pm/sleep.d/30videquirk
	install -m 644 pm-videoquirk.service /etc/systemd/system/
	systemctl enable pm-videoquirk

uninstall:
	rm -f /etc/pm/sleep.d/30videquirk
	systemctl disable pm-videoquirk
	rm -f /etc/systemd/system/pm-videoquirk.service
