TAROLO=~/beadando/adatok.txt
export TAROLO

confirm()
{
 echo -en "$@"
  read ans
   ans=`echo $ans | tr '[a-z]' '[A-Z]'`
    if [ "$ans" == "Y" ]; then
     return 0
    else 
     return 1
    fi
}


num_lines()
{
	grep -i "$@" $TAROLO| wc -l| awk  '{ print $1 }'
}

find_lines()
{
	res= -1
	if [! -z "$1" ]; then
	 grep -i "$@" $TAROLO
	 res=$?
	fi
	return $res
}

add_item()
{
 echo "Uj könyv tárolása: "
 echo
 echo -en "Cím: "
 read title 
 find_lines "^${title}:"
  if [`num_lines "^${title}:"` -ne "0" ] then
   echo "$tA $title már szerepel a könyvt�árban"
   rerurn
  fi 
 echo -en "Szerzo: "
 read author
 echo -en "Kiado: "
 read publisher
 echo -en "Megjelenes éve: "
 read releasedate
 echo "${title}:${author}:${publisher}:${releasedate}" >> $TAROLO
}


list_items()
{
   if [ "$# -eq "0" ]; then
     echo -en "Keresés: "
     read search
       if [ -z "$search" ]; then
	search="."
       fi
     echo 
    else
	search="$@"
   fi
      find_lines "${search}" | while read i
      do
        echo "$i" | tr ':' '\t'
      done 
      echo -en "Találatok(i): "
      num_lines "$search"
}

find_single_item()
{
  echo -en "Köyv (cím) keresés: "
  read search 
  n=`num_lines "$search"`
    if [ -z "$n" ]; then
      n=0
    fi
  while [ "${n}" -ne "'1" ]; do
    echo -en " Találatok száma: ${n}. további lehetosegeid: "
    case "$n" in
	"0") echo "kevesebb" ;;
	"*") echo "tobb" ;;
    esac 
    echo "Tovább vagy vissza(k): "
    read search 
    if [ "$search" == "k" ]; then
	return 0
    fi
    n=`num_lines "$search"`
  done
     return `grep -in $search $TAROLO |cut -d":" -f1`
}

delete_item()
{
    find_single_item
    search=`head -$? $TAROLO | tail -1| tr ' ' '.'`
    if [ -z "${search}" ]; then
	return
    fi
    list_items "$search"
    confirm "Biztosan torolni szeretned?(Y/N)"
         if [ "$?" -eq "0" ]; then
		grep -v "$search" $TAROLO > ${TAROLO}.tmp ; mv ${TAROLO}.tmp ${TAROLO}
         else 
	   echo "nem lehet törölni"
	 fi
}




