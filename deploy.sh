docker build -t abrahamjkwan/multi-client:latest -t abrahamjkwan/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t abrahamjkwan/multi-server:latest -t abrahamjkwan/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t abrahamjkwan/multi-worker:latest -t abrahamjkwan/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push abrahamjkwan/multi-client:latest
docker push abrahamjkwan/multi-server:latest
docker push abrahamjkwan/multi-worker:latest

docker push abrahamjkwan/multi-client:$SHA
docker push abrahamjkwan/multi-server:$SHA
docker push abrahamjkwan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=abrahamjkwan/multi-client:$SHA
kubectl set image deployments/server-deployment server=abrahamjkwan/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=abrahamjkwan/multi-worker:$SHA