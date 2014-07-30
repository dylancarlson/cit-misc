@ECHO OFF
REM this batch file is a quick n dirty scheme for Cit+<>Cit86 netting
REM all it does is a rudimentary check for files to determine if
REM the Cit+ called in and then proceeds accordingly
REM this assumes this batch file is called from an event most likely
REM once per day.
REM this must be run from the main directory, it copies and deletes
REM packets as necessary
REM
REM change NodeName "POOP_NODE" to the Cit+ nodename
REM change incoming pkt "INCOMING.000"
REM and outgoing (up to 5) as "OUTGOING.*"
REM and also directory names as needed...
REM 		
cd\cit\poop                                       
if exist OUTGOING.000 goto goodo
if not exist OUTGOING.000 goto ohwell
REM
REM files were picked up
REM
:goodo
del INCOMING.*
goto both
REM
REM files not picked up
REM
:ohwell
if exist INCOMING.005 del INCOMING.005
if exist INCOMING.004 ren INCOMING.004 INCOMING.005
if exist INCOMING.003 ren INCOMING.003 INCOMING.004
if exist INCOMING.002 ren INCOMING.002 INCOMING.003
if exist INCOMING.001 ren INCOMING.001 INCOMING.002
if exist INCOMING.000 ren INCOMING.000 INCOMING.001
goto start
REM
REM fetch msgs
REM
:start
REM						<**** directory change
cd\cit
MSGOUT POOP_NODE INCOMING.000
REM						<**** directory change
copy INCOMING.000 \cit\poop
del INCOMING.000
goto end
REM
REM fetch and incorporate
REM
:both
REM						<**** directory change
cd\cit
MSGOUT POOP_NODE INCOMING.000
REM						<**** directory change
copy INCOMING.000 \cit\poop
del INCOMING.000
REM						<**** directory change
copy \cit\poop\OUTGOING.000
del \cit\poop\OUTGOING.000
MSGADD POOP_NODE OUTGOING.000
DEL OUTGOING.000
:end
