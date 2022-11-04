
printf " \n\n******** Supression en force des container 'star' ...************ \n\n"
docker rm -f $(docker ps -a --filter name=star* -q);


printf " \n\n******** Build and deploy de l'API ...************ \n\n"
docker build ./backEnd -t python-alpine-flask && docker run -d --name star-data-api -p 5000:5000 python-alpine-flask ;

printf " \n\n******** Build and deploy du front ... ************ \n\n"
docker build ./frontEnd -t nginx-dashboard-front && docker run --name star-data-dashboard -d -p 8080:80 nginx-dashboard-front ;
