# cmdbuild-3.1.1 need to talk talk with a pg db 9.4-10


* ENV POSTGRES_USER postgres
* ENV POSTGRES_PASS postgres
* ENV POSTGRES_PORT 5432
* ENV POSTGRES_HOST cmdbuild_db
* ENV POSTGRES_DB cmdbuild_db31
* ENV CMDBUILD_DUMP demo



_step
* docker run --name cmdbuild_db -p 5432:5432 -d itmicus/cmdbuild:db-3.0
* docker run --name cmdbuild_run --link cmdbuild_db  -p 8080:8080 -d cavamagie/cmdbuild-3.1.1
