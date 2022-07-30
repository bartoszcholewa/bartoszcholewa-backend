deploy:
	kubectl delete secret bartoszcholewa-secrets
	kubectl create secret generic bartoszcholewa-secrets --from-env-file=src/.env.prod
	docker build -t ghcr.io/bartoszcholewa/bartoszcholewa-backend-web:latest src/
	docker push ghcr.io/bartoszcholewa/bartoszcholewa-backend-web:latest
	kubectl delete -f k8s/django/bartoszcholewa-deployment.yaml
	kubectl apply -f k8s/django/bartoszcholewa-deployment.yaml
