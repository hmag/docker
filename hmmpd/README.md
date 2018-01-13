This builds an image called hmmpd.  
The aim is to provide a MPD (Music Player Daemon) service.  
Requirements :  
  * to have a "mpd" user on the host system
  * to have following folders, belonging to mpd user :
	* /var/mpd/music
	* /var/mpd/log
	* /var/mpd/playlists
  * possible issues :
	* impossible to create mpd user in the image with same uid as mpd user on host
		* Workaround : either change uid on host or on image
	* mpd.conf can require changes if soundcard change is required

How to use :  
  * to build: run Build.sh will create an image hmmpd
  * to run : run_hmmpd.sh will run the container
