
PGARGS=${PGARGS:=''}
postgres_commands=(psql createuser createdb dropdb dropuser)
for command ($postgres_commands) alias ${command}="${command} ${PGARGS}"

