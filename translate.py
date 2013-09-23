#!/usr/bin/python
import sys, os
sys.path.append(os.path.abspath(os.path.dirname(sys.argv[0])))
import dmtranslations as l

ln='en'
if(len(sys.argv) > 3):
   if sys.argv[3] in l.LANGS.keys():
      ln=sys.argv[3]

if os.path.isfile(sys.argv[1]):
   print 'Translate '+sys.argv[1]+' to '+sys.argv[2]+' in '+ln+' lang'
   f=open(sys.argv[1], "r")
   text=f.read()
   f.close()
   for w in l.LANGS[ln].keys():
      text=text.replace("${{"+w+"}}$", l.LANGS[ln][w])

   text=text.replace("${{", "")
   text=text.replace("}}$", "")

   f=open(sys.argv[2], "w")
   f.write(text)
   f.close()



