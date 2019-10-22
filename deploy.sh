docker build -t saivnct/multi-client:latest -t saivnct/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t saivnct/multi-server:latest -t saivnct/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t saivnct/multi-worker:latest -t saivnct/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push saivnct/multi-client:latest
docker push saivnct/multi-server:latest
docker push saivnct/multi-worker:latest

docker push saivnct/multi-client:$GIT_SHA
docker push saivnct/multi-server:$GIT_SHA
docker push saivnct/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=saivnct/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=saivnct/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=saivnct/multi-worker:$GIT_SHA