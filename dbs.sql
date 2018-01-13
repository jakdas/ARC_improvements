use master
go
select Name from sysdatabases
 where Name not in ('master','tempdb','model','msdb')
go

