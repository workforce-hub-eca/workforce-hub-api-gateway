# API Gateway 🌐

| | |
|---|---|
| **Student** | L.K.H. Manuth Lakdiw |
| **Student Number** | 241722018 |
| **Batch** | GDSE-72 |
| **GCP Project** | `workforce-hub-cloud` |

## Project Description

The API Gateway is the single entry point for all external client traffic into the WorkForceHub microservice ecosystem. It dynamically routes requests to the appropriate backend services using Eureka-based service discovery and Spring Cloud LoadBalancer. A custom Servlet-based `CorsFilter` handles cross-origin preflight requests for the frontend application.

## 🛠️ Technology Stack

- **Java**: 25
- **Spring Boot**: 4.1.0
- **Spring Cloud**: 2025.1.2
- **Spring Cloud Gateway** (WebMVC)
- **Spring Cloud LoadBalancer**
- **Netflix Eureka Client**

## 📍 API Routes

| Route Pattern | Target Service |
|---|---|
| `/api/v1/departments/**` | Department Service |
| `/api/v1/employees/**` | Employee Service |
| `/api/v1/documents/**` | Document Service |

## ✨ Architecture Highlights

- **Dynamic Routing**: Routes are resolved through Eureka service discovery using load-balanced URIs rather than hardcoded IP addresses.
- **CORS Handling**: A native Servlet `CorsFilter` intercepts and manages frontend preflight traffic, replacing legacy WebFlux global CORS configuration.
- **Health Monitoring**: Spring Boot Actuator exposes `/actuator/health` for readiness checks.

## 🚀 Running Locally

- **Port**: `8080`
- Ensure Config Server and Eureka Server are running and healthy before starting this service.

```bash
mvn spring-boot:run
```

## ☁️ Production Deployment

- **Public URL**: `http://136.68.81.254`
- **Load Balancer**: `lb-workforce-hub-api-gateway`
- **Runtime**: Regional Managed Instance Group (`workforce-hub-backend-mig`)
- **Region**: `asia-south1`
- **Zones**: `asia-south1-a` and `asia-south1-b`

Production traffic from the frontend and external clients is load balanced across MIG instances. The load balancer forwards requests to the API Gateway, which then routes them to the appropriate microservice on the same VM via Eureka.
