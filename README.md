# mypsql

#docker psql commands:
https://docs.docker.com/get-docker/

ubuntu convinience script->
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

1.docker pull postgres
2.docker pull dpage/pgadmin4
3.docker run --name postgresql-container -p 5432:5432 -e POSTGRES_PASSWORD=iamadmin -d postgres
4.docker run -p 80:80 -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com' -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret' -d dpage/pgadmin4
