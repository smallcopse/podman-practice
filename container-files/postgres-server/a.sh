# if first arg looks like a flag, assume we want to run postgres server
if [ "${1#-}" != "$1" ]; then
	set -- haproxy "$@"
fi
echo "$@"
if [ "${1:0:1}" = '-' ]; then
	set -- postgres "$@"
fi
echo "$@"