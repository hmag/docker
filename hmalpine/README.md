This is a webserver.  
Based on Alpine Linux, exposing webserver Apache on port 80.  
Included : all modules to be able to run NextCloud.  
Good to know :
  * uses userID 33 to run server ('apache' in Alpine, 'www-data' in debian/ubuntu)
  * uses /var/www from hosts, expects default virtualhost files to be in /var/www/html
  * uses an init process (s6-overlay) but it's not mandatory if only one server is exposed (ie : if no openssh, ...)
  * logs are stored in the host folder : /var/log/apache2

How to use :  
  * to build : use Build.sh, it will build an image
  * to run : use run_hmalpine.sh
