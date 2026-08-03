# Docker Multi-Container Flask Application

## Overview

This project is a containerised multi-service web application built to strengthen my understanding of Docker, container networking, orchestration, scalability, and DevOps fundamentals.

The application consists of:
- A Flask web application
- A Redis database used for persistent visitor counting
- NGINX for load balancing
- Docker Compose for orchestration

The project evolved from a simple single-container Flask app into a scaled multi-container setup with persistence, environment variables, and load balancing.

This repository forms part of my growing DevOps portfolio and will later be extended with CI/CD pipelines, cloud deployment, and Kubernetes.

---

# What I Built

## Flask Web Application
The Flask app contains two routes:

### `/`
Displays a welcome message and identifies which container handled the request.

<img width="479" height="296" alt="Image" src="https://github.com/user-attachments/assets/f0552d7d-7201-499f-b096-ccc6bd9db779" />

### `/count`
Tracks and increments visitor count using Redis.

<img width="535" height="348" alt="Image" src="https://github.com/user-attachments/assets/654a01c7-1f0f-4583-a01d-0b770971e691" />

Example:
```text
You are visitor number: 15
```

---

## Redis Database
Redis is used as a key-value store to persist the visitor counter.

I configured Docker volumes so Redis data remains available even after containers are stopped or restarted.

---

## Docker Containerisation
The application was fully containerised using Docker.

I created:
- A Dockerfile for the Flask application
- A Docker Compose configuration for orchestrating services
- Networking between containers using Docker service names

---

## Scaling & Load Balancing
The Flask service was scaled to run multiple containers using Docker Compose.

NGINX was added to distribute traffic across multiple Flask containers, helping me understand how load balancing works in practice.

Example architecture:

```text
User
  ↓
NGINX
  ↓
Flask Containers (Scaled)
  ↓
Redis
```

---

# My Approach

I started by building a basic Flask application locally before gradually containerising each component.

My workflow was:
1. Build and test the Flask application
2. Create a Dockerfile
3. Run the application inside a container
4. Add Redis integration
5. Use Docker Compose to orchestrate services
6. Configure persistent Redis storage using volumes
7. Add environment variables for cleaner configuration
8. Scale the Flask application
9. Configure NGINX for load balancing

I focused on understanding how each part worked rather than simply following tutorials.

---

# What I Learnt

This project helped me develop practical understanding of:

- Docker images vs containers
- Writing Dockerfiles
- Container networking
- Service discovery using Docker Compose
- Environment variables and configuration management
- Data persistence using Docker volumes
- Scaling containerised services
- Load balancing with NGINX
- Debugging container and networking issues
- Multi-container application architecture

I also gained much more confidence using the command line and debugging runtime issues.

---

# Challenges & Solutions

## 1. Redis Connection Errors
### Problem
The Flask container could not connect to Redis.

### Cause
I initially attempted to connect using `localhost`, which does not work between separate containers.

### Solution
I updated the Redis host to use the Docker Compose service name:

```python
host='redis'
```

This taught me how Docker networking and service discovery works.

---

## 2. Missing Python Dependencies
### Problem
The Flask container failed with:

```text
ModuleNotFoundError: No module named 'redis'
```

### Cause
The dependency was missing from `requirements.txt`.

### Solution
I added the missing package and rebuilt the Docker image.

This helped me understand dependency management inside containers.

---

## 3. Port Conflicts When Scaling
### Problem
Scaling the Flask service caused port allocation errors.

### Cause
Multiple containers cannot bind to the same host port.

### Solution
I changed the architecture to use NGINX as the public entry point while Flask containers communicated internally using Docker networking.

This improved my understanding of scaling and load balancing.

---

## 4. Data Persistence
### Problem
Redis data was lost whenever containers were removed.

### Solution
I configured Docker volumes:

```yaml
volumes:
  - redis_data:/data
```

This allowed Redis data to persist across restarts.

---

# Technologies Used

- Python
- Flask
- Redis
- Docker
- Docker Compose
- NGINX

---

# Future Improvements

Planned improvements include:
- CI/CD pipelines using GitHub Actions
- Cloud deployment
- Monitoring and logging
- Health checks
- Kubernetes deployment
- Infrastructure as Code (Terraform)

---

# How to Run the Project

## Build and Start Containers

```bash
docker compose up --build
```

## Scale Flask Containers

```bash
docker compose up --scale web=3
```

## Access the Application

```text
http://localhost:8080
```

---

# Final Thoughts

This project helped bridge the gap between theory and real-world DevOps workflows. The most valuable part was debugging and solving real issues around networking, scaling, persistence, and container orchestration.

It gave me practical experience with technologies and concepts commonly used in modern cloud and DevOps environments.
