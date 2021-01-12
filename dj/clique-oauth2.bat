@echo off
C:
cd /
cd dj
cd clique-oauth2
for /f "tokens=4" %%i in ('svn info ^| find "Last Changed Rev"') do (set cnt=%%i)
for /f "tokens=4" %%i in ('svn info http://202.105.139.114:8888/svn/DIC-XN-IT-LOC-PRO/PRO-JAVA/Project/00_PartyBuilding/SourceCode/1_Develop/Java/partybuilding/clique-oauth2 ^| find "Last Changed Rev"') do (set cnt1=%%i)
if %cnt% neq %cnt1% (
	svn update
	for /f "tokens=5" %%i in ('netstat -ano ^| findstr 0.0.0.0:9099') do (
    	taskkill /f /pid %%i
   	)
	mvn clean package -DskipTests
	cd target
	start "clique-oauth2 9099" /min java -jar clique-oauth2-0.0.1-SNAPSHOT.jar
)
