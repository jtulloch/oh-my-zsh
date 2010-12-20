#
# In your local config, define PGARGS which should be applied to postgres commands
#
PGARGS=${PGARGS:=''}

postgres_commands=(psql createuser createdb dropdb dropuser)
for command ($postgres_commands) alias ${command}="${command} ${PGARGS}"

