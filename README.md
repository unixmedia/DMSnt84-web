DMSnt84-web
===========

Web GUI for DMSnt84 I/O Boards

To compile a new webgui execute the script "Convert_Webpages_To_Mpfs2.sh" from the base directory of the WebGUI scripts

You will need following dependencies on a Linux machine:

 - yui-compressor installed in $PATH
 - python and python-slimmer module package installed 
 - MPFS2.exe binary from Microchip MAL utilities installed and working under Wine

You MUST NOT change anything in ajax.xml, ioconf.xml and all *.cgi files

Be carefull about the size of your web pages: the EEPROM space on the DMSnt84 board is limited, the resulting binary file,
after compression, can't be more than 28KB.
