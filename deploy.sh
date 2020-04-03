docker build -t suspicioushaibt/fib-client-for-k8s:latest -t suspicioushaibt/fib-client-for-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t suspicioushaibt/fib-server:latest -t suspicioushaibt/fib-server:$SHA -f ./server/Dockerfile ./server
docker build -t suspicioushaibt/fib-worker:latest -t suspicioushaibt/fib-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push suspicioushaibt/fib-client-for-k8s:latest
docker push suspicioushaibt/fib-server:latest
docker push suspicioushaibt/fib-worker:latest

docker push suspicioushaibt/fib-client-for-k8s:$SHA
docker push suspicioushaibt/fib-server:$SHA
docker push suspicioushaibt/fib-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=suspicioushaibt/fib-client-for-k8s:$SHA
kubectl set image deployments/server-deployment server=suspicioushaibt/fib-server:$SHA
kubectl set image deployments/worker-deployment worker=suspicioushaibt/fib-worker:$SHA
