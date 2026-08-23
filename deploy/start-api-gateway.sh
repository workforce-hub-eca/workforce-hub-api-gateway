#!/usr/bin/env bash
set -euo pipefail

# Validate required variables
if [ -z "${SPRING_PROFILES_ACTIVE:-}" ]; then
  echo "ERROR: SPRING_PROFILES_ACTIVE is not set."
  exit 1
fi
if [ -z "${CONFIG_SERVER_URL:-}" ]; then
  echo "ERROR: CONFIG_SERVER_URL is not set."
  exit 1
fi
if [ -z "${API_GATEWAY_EUREKA_URL:-}" ]; then
  echo "ERROR: API_GATEWAY_EUREKA_URL is not set."
  exit 1
fi
if [ -z "${API_GATEWAY_CORS_ALLOWED_ORIGINS:-}" ]; then
  echo "ERROR: API_GATEWAY_CORS_ALLOWED_ORIGINS is not set."
  exit 1
fi

check_service() {
  local name="$1"
  local url="$2"
  echo "Waiting for $name..."
  for i in {1..30}; do
    if curl -fsS "$url" 2>/dev/null | grep -q '"status":"UP"'; then
      echo "$name is up."
      return 0
    fi
    if [ "$i" -eq 30 ]; then
      echo "ERROR: $name did not start."
      exit 1
    fi
    sleep 2
  done
}

check_service "Eureka Server" "http://localhost:8761/actuator/health"
check_service "Config Server" "http://localhost:8888/actuator/health"
check_service "Department Service" "http://localhost:8081/actuator/health"
check_service "Employee Service" "http://localhost:8082/actuator/health"
check_service "Document Service" "http://localhost:8083/actuator/health"

echo "All dependencies healthy. Starting API Gateway..."
exec /usr/bin/java -jar /opt/workforce-hub/apps/api-gateway-0.0.1-SNAPSHOT.jar
