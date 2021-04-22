docker build -t ps901/multi-client:latest -t ps901/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t ps901/multi-server:latest -t ps901/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t ps901/multi-worker:latest -t ps901/multi-server:$SHA -f ./worker/Dockerfile ./worker
docker push ps901/multi-client:latest
docker push ps901/multi-server:latest 
docker push ps901/multi-worker:latest
docker push ps901/multi-client:$SHA
docker push ps901/multi-server:$SHA 
docker push ps901/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ps901/multi-server:$SHA 
kubectl set image deployments/client-deployment client=ps901/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ps901/multi-worker:$SHA