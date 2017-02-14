#! /bin/sh

# 
# Let readers know that the output is generated automatically
#
echo // This file is automatically generated
echo // There is no point in editing manually--edit the .r file instead
echo

#
# 1) tr '\r' '\n'
#	 The file is probably using Mac OS line delimiters, which grep and
#	 sed won't understand, so convert to Unix line delimiters.
#    If the file already uses Unix line delimiters no harm is done,
#	 If the file has MS/DOS line delimiters, the result will just have
#	 some empty lines to ignore
#
# 2) grep "#define LPobj"
#	 Modified 19-Feb-08
#	 This is a simplistic regexp that copies lots of #defines
#	 (Previously the regexp was "LPobj[CVS]")
#    It is not a big problem that some other lines are copied, in fact
#	 I now want to have more of the #defines available for the plist generator.
#
# 3) sed 's/\"//g'
#	 Kills the quote marks needed by Rez but so unhelpful for Info.plist
#
tr '\r' '\n' | grep "#define LPobj" |sed 's/\"//g'

#
# The rest of the script adds precompiler code to #define LPobjBundle as we
# need it
#
echo
echo \#ifdef LPobjStarter
echo $'\t'\#define LPobjBundle All Bundles
echo \#else
echo $'\t'\#define LPobjBundle Pro Bundle
echo \#endif
