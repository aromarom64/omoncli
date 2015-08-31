function _omonclibuild() {

declare CONFDIR="$HOME/.config/omoncli"
declare PROGNAME='omoncli'
declare MAINCONF=".${PROGNAME}"
declare TMPFILE=`mktemp /tmp/omoncli.XXXXXX`
declare STR=''

omoncli help | grep -e "omoncli" > ${TMPFILE} || { printf "Error while execute command omoncli help:%s\n" "$?"; return 1; }
cat ${TMPFILE} | cut -b 3- | cut -d' ' -f2 > ${CONFDIR}/${MAINCONF}

exec 3< ${TMPFILE}
while read LINE <&3 ; do
  STR=$(printf "%s" "$LINE" | grep -e "SUBCOMMAND")
  if [ -n "${STR}" ] ; then
    STR=$(printf "%s" "$LINE" | cut -b 3- | cut -d' ' -f2)
    omoncli help ${STR} | grep -e "omoncli" | cut -b 3- | cut -d' ' -f3 > ${CONFDIR}/${MAINCONF}.${STR}
    STR=''
  fi
done

if [ -f $TMPFILE ] ; then
  rm $TMPFILE
fi

return 0
}

function _omonclicomplete() {

declare CONFDIR="$HOME/.config/omoncli"
declare PROGNAME='omoncli'
declare MAINCONF=".${PROGNAME}"
declare PREV=${COMP_WORDS[COMP_CWORD-1]}
declare CUR=${COMP_WORDS[COMP_CWORD]}
declare TASKS=''
declare STR=''

if [ "${PROGNAME}" == "${PREV}" ] ; then
  STR=$CONFDIR/$MAINCONF
  if [ -f "${STR}" ] ; then
    TASKS=$(cat "${STR}")
  fi
else
  STR=$CONFDIR/$MAINCONF.$PREV
  if [ -f "${STR}" ] ; then
    TASKS=$(cat "${STR}")
  fi
fi

COMPREPLY=($(compgen -W "${TASKS}" -- ${CUR}))

return 0
}

function _omonclicomplete1() {

declare PREV=${COMP_WORDS[COMP_CWORD-1]}
declare CUR=${COMP_WORDS[COMP_CWORD]}

printf "prev:%s cur:%s\n" "$PREV" "$CUR" >> "$HOME/arom.log.file"

return 0
}

complete -F _omonclicomplete omoncli
