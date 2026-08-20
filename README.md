# API Gateway 🚦

The central entry point for all frontend traffic routing to backend microservices.

## 🛠️ Tech Stack
- **Java**: 25
- **Spring Boot**: 4.1.0
- **Gateway**: `spring-cloud-starter-gateway-server-webmvc`

## ✨ Architecture Highlights
- **Servlet-based Gateway**: Unlike traditional WebFlux Gateways, this utilizes the newer Spring Boot 4 WebMVC Gateway.
- **Global CORS Resolution**: Because this is an MVC application, WebFlux `CorsWebFilter` and YAML `globalcors` were deliberately bypassed. Instead, we explicitly implemented a standard Servlet `CorsFilter` inside `CorsConfig.java` to natively intercept and successfully resolve preflight `OPTIONS` requests from `http://localhost:5173`.
- **Dynamic Routing**: Routes `/api/v1/departments/**`, `/api/v1/employees/**`, and `/api/v1/documents/**` to their respective load-balanced instances via Eureka.

## 🚀 Running Locally
- Port: `8080`
- Ensure Config Server and Eureka are running before starting this service.
