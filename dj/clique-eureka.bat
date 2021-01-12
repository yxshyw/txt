@echo off
C:
cd /
cd dj
cd clique-eureka
for /f "tokens=4" %%i in ('svn info ^| find "Last Changed Rev"') do (set cnt=%%i)
for /f "tokens=4" %%i in ('svn info http://202.105.139.114:8888/svn/DIC-XN-IT-LOC-PRO/PRO-JAVA/Project/00_PartyBuilding/SourceCode/1_Develop/Java/partybuilding/clique-eureka ^| find "Last Changed Rev"') do (set cnt1=%%i)
if %cnt% neq %cnt1% (
	svn update
	for /f "tokens=5" %%i in ('netstat -ano ^| findstr 0.0.0.0:9761') do (
    	taskkill /f /pid %%i
   	)
	mvn clean package -DskipTests
	cd target
	start "clique-eureka 9761" /min java -jar clique-eureka-0.0.1-SNAPSHOT.jar
)
