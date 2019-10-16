# cmdbuild-3.1.1need to talk
need to talk with a pg db 


* ENV POSTGRES_USER postgres
* ENV POSTGRES_PASS postgres
* ENV POSTGRES_PORT 5432
* ENV POSTGRES_HOST cmdbuild_db
* ENV POSTGRES_DB cmdbuild_db31
* ENV CMDBUILD_DUMP demo


docker run --name cmdbuild_db -p 5432:5432 -d itmicus/cmdbuild:db-3.0
docker run -d -p 8080:8080 -e POSTGRES_HOST='172.17.0.2' cavamagie/cmdbuild-3.1.1
