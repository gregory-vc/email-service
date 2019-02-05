build:
		go get github.com/gregory-vc/email-service
		go mod vendor
		git add --all
		git diff-index --quiet HEAD || git commit -a -m 'fix'
		git push origin master