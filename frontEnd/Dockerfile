FROM nginx
COPY . /usr/share/nginx/html
# add init script do docker-entrypoint.d repo to execute it at start
COPY init.sh /docker-entrypoint.d 
# make it executable, otherwise will not work
RUN chmod +x /docker-entrypoint.d/init.sh