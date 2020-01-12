docker build -t patrick3068/multi-client:latest -t patrick3068/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t patrick3068/multi-server:latest -t patrick3068/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t patrick3068/multi-worker:latest -t patrick3068/multi-worker:$SHA -f ./client/Dockerfile ./worker
docker push patrick3068/multi-client:latest
docker push patrick3068/multi-server:latest
docker push patrick3068/multi-worker:latest
docker push patrick3068/multi-client:$SHA
docker push patrick3068/multi-server:$SHA
docker push patrick3068/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=patrick3068/multi-server:$SHA
kubectl set image deployment/client-deployment server=patrick3068/multi-client:$SHA
kubectl set image deployment/worker-deployment server=patrick3068/multi-worker:$SHA