python3_cx-oracle
-----------------------------------------------------------------------------
Dockerfile to create container including CentOS 6.8 / Python3.4.5 / Oracle Instant Client 11.2.0.4.0-1 / Python cx_Oracle extension
<br/>

**Usage 1 - for simple scripts**:
- prepare "tnsnames.ora" file
```
<NET_SERVICE_NAME> =
 (DESCRIPTION =
   (ADDRESS_LIST =
     (ADDRESS = (PROTOCOL = TCP)(HOST = <ORACLE_SERVER_ADDRESS>)(PORT = 1521))
   )
 (CONNECT_DATA =
   (SERVICE_NAME = <ORACLE_SERVICE_NAME>)
 )
)
```
- write python code
```
import cx_Oracle
...

con = cx_Oracle.connect("<USERNAME>/<PASSWORD>@<NET_SERVICE_NAME>")
...
```
- run docker container for simple scripts
```
docker run -it --rm --name <CONTAINER NAME> -v "$PWD"/tnsnames.ora:/usr/lib/oracle/11.2/client64/network/admin/tnsnames.ora -v "$PWD":/usr/src/myapp -w /usr/src/myapp chenshenyou/python3_cx-oracle python3 <PYTHON SCRIPT> <SCRIPT PARAMETERS>
```


**Usage 2 - create a Dockerfile**:
```
FROM chenshenyou/python3_cx-oracle:1.0

...

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY tnsnames.ora /usr/lib/oracle/11.2/client64/network/admin/

COPY requirements.txt /usr/src/app/
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

ENTRYPOINT ["python3", "<PYTHON SCRIPT>"]

```


**References**:

- oracle instant client rpm files
http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html

- oracle instant client installation guide
http://www.oracle.com/technetwork/database/features/instant-client/index-097480.html

- cx_oracle installation reference
https://www.mylinuxplace.com/install-cx_oracle-on-centos-7/

