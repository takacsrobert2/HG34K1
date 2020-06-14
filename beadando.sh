#!/bin/bash

trap 'do_menu' 2

. ./beadando.sh

show_menu()
{
echo "####Könyvtár####"
echo "1. Könyv hozzáadása"
echo "2. Könyv keresése"
echo "3. Könyv törlése"
echo "k. Kilepes a könvtárból"

ndo=$(date +"%m-%d-%Y-%T")
echo "Idö : $ido"
echo -en "...Válaszd ki a művelete1-3 ,k):"
}

do_menu()
{
 i=-1

 while [ "$i != "k" ]; do
  show_menu
  read i
  i =`echo $i | tr '[A-Z]' '[a-z]'`
  case "$i" in 
	 "1")
	 add_item
 	 ;;
 	 "2")
  	 list_items
 	 ;;
 	 "3")
  	 remove_item
 	 ;;
 	 "k")
 	 echo "Viszontlátásra"
 	 exit 0
 	 ;;
 	 *)
 	 echo "Valami nem jó"
 	 ;;
  esac
 done
}


if [ ! -f $TAROLO ]; then
	echo "Hiba $TAROLO készítése közben"
	touch $TAROLO
fi


if [ ! -r $TAROLO ]; then
	echo "$TAROLO nem olvasható"
	exit 1
fi

if [ ! -w $TAROLO ]; then
	echo "$TAROLO nem írható"
	exit 2
fi

do_menu







