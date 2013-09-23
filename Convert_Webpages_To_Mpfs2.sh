#!/bin/bash 
if [ -d DomotikaWeb ] ; then
   rm -rf DomotikaWeb
fi

pages=$1
if [ x"$2" != x"" ] ; then
   language=$2
else
   language="en"
fi


mypath=`dirname $0`

if [ x"$1" = x"" ] ; then
   echo "Specify pages to be created"
   exit 1
fi

mypages=$mypath/$pages/Pages
myproj=$mypath/$pages

if [ \! -d $myproj ] ; then
   echo "$myproj doesn't exists"
   exit 1
fi 


if [ \! -d $mypages ] ; then
   echo "$mypages doesn't exists"
   exit 1
fi

cd $myproj

if [ -d DomotikaWeb ] ; then
   rm -rf DomotikaWeb
fi

rsync Pages/ DomotikaWeb -a --copy-links -v

find ./DomotikaWeb -name '.svn' -type d -exec rm -rf {} \; 2>/dev/null 

#if [ -x /usr/bin/yui-compressor ] ; then
if [ -f ../compiler.jar ] ; then
   echo "Convert html2js files..."
   for i in `find ./DomotikaWeb -name "*.html2js" -type f`
   do
      html2js $i.converted $i
      cat $i.converted >> ./DomotikaWeb/js/d.js
      rm $i.converted
   done
   
   echo "Add prepend js files..."
   for i in `find ./DomotikaWeb -name "*.js.prepend" -type f`
   do
      mv ./DomotikaWeb/js/d.js ./DomotikaWeb/js/d.js.orig
      mv "$i" ./DomotikaWeb/js/d.js
      cat ./DomotikaWeb/js/d.js.orig >> ./DomotikaWeb/js/d.js
      rm ./DomotikaWeb/js/d.js.orig
   done

   echo "Add postpend js files..."
   for i in `find ./DomotikaWeb -name "*.js.postpend" -type f`
   do
      cat "$i" >> ./DomotikaWeb/js/d.js
      rm "$i"
   done


   echo "Translate files..."
   for i in `find ./DomotikaWeb -iname "*.htm" -or -iname "*.xml" -or -iname "*.js" -or \
         -iname "*.css" -or -iname '*.html' -or -iname '*.cgi'`
   do
        ../translate.py "${i}" "${i}" $language
   done
   

   echo "Compress css and js files with yui-compressor"
   for i in `find ./DomotikaWeb -name "*.js" -type f`
   do
      java -jar ../compiler.jar --js $i --js_output_file $i.compressed
      mv $i.compressed $i
   done
   for i in `find ./DomotikaWeb -name "*.css" -type f`
   do
      yui-compressor -o $i.compressed $i
      mv $i.compressed $i
   done
   echo "Compress xml/html files with python-slimmer"
   for i in `find ./DomotikaWeb -name "*.htm" -type f`
   do
      ../tools/htmcompress $i $i.compressed
      mv $i.compressed $i
   done
   for i in `find ./DomotikaWeb -name "*.html" -type f`
   do
      ../tools/htmcompress $i $i.compressed
      mv $i.compressed $i
   done
   for i in `find ./DomotikaWeb -name "*.xml" -type f`
   do
      ../tools/htmcompress $i $i.compressed
      mv $i.compressed $i
   done
   for i in `find ./DomotikaWeb -name "*.inc" -type f`
   do
      ../tools/htmcompress $i $i.compressed
      mv $i.compressed $i
   done

else
   echo "You don't seem to have yui-compressor installed"
fi
mpfs2 --mpfs2 -h "*.htm,*.html,*.xml,*.cgi,*.bin"  "DomotikaWeb" "." "MPFSImg2-$language.bin"
mpfs2 --mpfs2 -h "*.htm,*.html,*.xml,*.cgi,*.bin" --C18 "DomotikaWeb" "." "MPFSImg2.c"
mpfs2 --mpfs2 -h "*.htm,*.html,*.xml,*.cgi,*.bin" --ASM30 "DomotikaWeb" "." "MPFSImg2.s"
