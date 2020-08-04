# FIM
File Integrity Monitoring script in bash.

This script monitor sentive files for modifications, and create a baseline.  If this baseline is modified, this script will be notify by email to people (sysadmins, audit team, etc).

This script use '''sSMTP''' in GNU/Linux system (ssmtp package must be installed on the system). Please, configure sSMTP with your mail account. As an example, the configuration for GMAIL is shown below:
* mailhub=smtp.gmail.com:587 
* AuthUser=myEmail@gmail.com 
* AuthPass=myP4ssw0rd 
* UseTLS=YES 
* UseSTARTTLS=YES

Please, see follow recomendations for configure the script:
* Configure el paths of file to will be monitoring in array "files_to_monitor" at line 16.
* Configure CRON for run periodically the script.
* In line 44, you will found the emails to notifications.
* If you can modify the monitoring files, you have to delete baseline file: /tmp/fim/baseline.md5


