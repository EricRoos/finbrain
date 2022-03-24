build:
	docker build . --build-arg RAILS_MASTER_KEY=${FIN_BRAIN_ENCKEY} -f Dockerfile -t fin_brain
run:
	docker run -p 5000:3000 -e RAILS_MASTER_KEY=${FIN_BRAIN_ENCKEY} --rm -ti fin_brain:latest
bash:
	docker run -e RAILS_MASTER_KEY=${FIN_BRAIN_ENCKEY} --rm -ti fin_brain:latest bash
prod_console:
	ssh DateFeed -t docker run -e RAILS_MASTER_KEY=${FIN_BRAIN_ENCKEY} --rm -ti ericroos13/fin_brain:latest bundle exec rails c
new_prod_console:
	ssh DateFeed -t docker-compose run --rm app bundle exec rails c
create_db:
	ssh DateFeed -t docker run -e RAILS_MASTER_KEY=${FIN_BRAIN_ENCKEY} --rm -ti ericroos13/fin_brain:latest bundle exec rake db:create
migrate_db:
	ssh DateFeed -t docker run -e RAILS_MASTER_KEY=${FIN_BRAIN_ENCKEY} --rm -ti ericroos13/fin_brain:latest bundle exec rake db:migrate
push_image:
	docker tag fin_brain:latest ericroos13/fin_brain && docker tag fin_brain:latest ericroos13/fin_brain && docker push ericroos13/fin_brain
deploy:
	ssh DateFeed "cd /home/ec2-user/deployables/fin_brain && ./update-service.sh"
circle_ci_deploy:
	ssh ec2-user@54.224.120.0 /home/ec2-user/deploy.sh
deploy_pipeline:
	make build push_image deploy
circleci_deploy_pipeline:
	make build push_image migrate_db circle_ci_deploy
edit_prod_secret:
	EDITOR=vim bundle exec rails credentials:edit --environment production

