#
# Import and expose environment variables
#
cnf ?= .env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

#
# Main
#
.PHONY: help prune config my-ciapp

help:
	@echo
	@echo "Usage: make TARGET"
	@echo
	@echo "Redis Dockerize project automation helper for Windows version 2.0"
	@echo
	@echo "Targets:"
	@echo "	build		build custom image"
	@echo "	up  		start the server"
	@echo "	down 		stop the server"	
	@echo "	ps 		show running containers"
	@echo "	logs		server logs"
	@echo "" 
	@echo "	cmd		start cmd on primary"
	@echo "	cli		start redis-cli on primary"
	@echo "	info		replication info"
	@echo "	role		replication role"
	@echo "	master		replication master"
	@echo "	config		edit configuration"

#
# build custom image
#
build:
	docker-compose build

#
# start the server
#
up:
	xcopy /S /Y /V conf.bak conf 
	docker-compose up -d --remove-orphans

#
# stop the server
#
down:
	docker-compose down -v

#
# show running containers 
#
ps:
	docker-compose ps

#
# server logs
#
logs:
	docker-compose logs

#
# start cmd on primary
#
cmd:
	docker-compose exec primary cmd

#
# start redis-cli on primary
#
cli:
	redis-cli --user ${AUTH_USER} --pass ${AUTH_PASS} --no-auth-warning 

#
# Replication info
#
info:
	redis-cli --user ${AUTH_USER} --pass ${AUTH_PASS} --no-auth-warning info replication

#
# Replication role
#
role:
	redis-cli --user ${AUTH_USER} --pass ${AUTH_PASS} --no-auth-warning role

#
# replication master
#
master:	
	redis-cli -p 5000 SENTINEL get-master-addr-by-name myprimary

#
# edit configuration
#
config:
	nano .env

#
# EOF (2024/07/04)
#
