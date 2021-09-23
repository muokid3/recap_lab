install: build release deploy test

k3d:
	k3d cluster create recap-lab --config k3d-config.yaml

down:
	k3d cluster delete recap-lab

build:
	docker build --tag muokid3/recap_lab .

run:
	docker run -d --name recap_lab -p 8080:80 muokid3/recap_lab

release:
	docker push muokid3/recap_lab

deploy:
	kubectl -n recap_lab apply -f ./k8s

delete:
	kubectl -n recap_lab delete -f ./k8s

test:
	@echo "Running tests -- wont take long, just hello world from node"
	@./test.sh > /dev/null
	@echo "Passed"