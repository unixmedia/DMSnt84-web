Domotika IOBoards-web
===========

Web GUI for Domotika I/O Boards

To compile a new webgui execute the script "Convert_Webpages_To_Mpfs2.sh" with the name
of the firmware that match the web gui you are upgrading and the language
as argument from the base directory of the WebGUI scripts

for example:

./Convert_Webpages_To_Mpfs2.sh relaymaster84 it

If you omit the language option by default "en" is selected.

You will need following dependencies on a Linux machine:

 - yui-compressor installed in $PATH
 - python and python-slimmer module package installed 
 - MPFS2.exe binary from Microchip MAL utilities installed and working under Wine

You MUST NOT change anything in ajax.xml, ioconf.xml and all *.cgi files, or they will
not work with the firmware.

The git branche will match the same versions as the firmware, or use master if no other branches are on git.

Be carefull about the size of your web pages: the EEPROM space on the DMSnt84 board is limited, the resulting binary file,
after compression, can't be more than 28KB.

After compilation, you will find a file called MPFS2-[lang].bin in the [firmware_name] directory. Upload this file on the board 
by point your browser to http://[ip_of_your_board]/uploadweb


Translations can be changed by editing dmtranslation.py file.
