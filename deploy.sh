docker build -t pratish420/multi-client:latest -t pratish420/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pratish420/multi-server:latest -t pratish420/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pratish420/multi-worker:latest -t pratish420/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pratish420/multi-client:latest
docker push pratish420/multi-server:latest
docker push pratish420/multi-worker:latest
docker push pratish420/multi-client:$SHA
docker push pratish420/multi-server:$SHA
docker push pratish420/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=pratish420/multi-client:$SHA
kubectl set image deployments/server-deployment server=pratish420/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=pratish420/multi-worker:$SHA