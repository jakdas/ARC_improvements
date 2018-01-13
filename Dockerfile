FROM microsoft/mssql-server-linux
MAINTAINER jakub
RUN touch blabla.txt
RUN echo "aaa\nzzz\n" > blabla.txt
RUN sed -i -e "s/aaa/bbb/" blabla.txt
RUN mkdir TESTOWY
COPY KGR/* /tmp/KGR/
COPY skrypt.sh /tmp/
COPY dropdb.sql /tmp/
COPY dbs.sql /tmp/
COPY dbsize.sql /tmp/
COPY showSD.sql /tmp/
COPY settings.txt /tmp/
COPY table_size.sql /tmp/
COPY partitions.sql /tmp/
COPY tables_count.sql /tmp/
COPY wait.sh /tmp/
COPY compare.sh /tmp/
COPY gen_stat_sql.sql /tmp/
COPY last_tasks.sql /tmp/

ENTRYPOINT ["/bin/bash","/tmp/wait.sh"]




