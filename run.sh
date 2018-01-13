
docker stop DBA
docker build -t mojtest27 .
docker run -d --name DBA --rm  mojtest27 
docker exec -it DBA "/tmp/skrypt.sh" list

