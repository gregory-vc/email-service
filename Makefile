build:
		go get github.com/gregory-vc/email-service
		go mod vendor
		git add --all
		git diff-index --quiet HEAD || git commit -a -m 'fix'
		git push origin master

registry:
		docker build -t eu.gcr.io/my-project-tattoor/email-service:latest .
		gcloud docker -- push eu.gcr.io/my-project-tattoor/email-service:latest

deploy:
	go get github.com/gregory-vc/email-service
	sed "s/{{ UPDATED_AT }}/$(shell date)/g" ./deployments/deployment.tmpl > ./deployments/deployment.yml
	go mod vendor
	git add --all
	git diff-index --quiet HEAD || git commit -a -m 'fix'
	git push origin master
	docker build -t eu.gcr.io/my-project-tattoor/email-service:latest .
	gcloud docker -- push eu.gcr.io/my-project-tattoor/email-service:latest
	kubectl replace -f ./deployments/deployment.yml