# AWS Assignment 2 — Application Load Balancer

## Overview
In this assignment, I deployed two EC2 instances across multiple 
availability zones behind an Application Load Balancer on AWS. 
I built a production-grade architecture with public and private 
subnets, a NAT Gateway for private instance outbound access, and 
proper security group isolation ensuring EC2 instances are only 
accessible via the ALB. The setup demonstrates high availability 
load balancing with dynamic hostname verification.

## Architecture Diagram
![Architecture Diagram](screenshots/aws-assignment-2.png)

## What I Built
- Custom VPC (10.0.0.0/16)
- 2 public subnets across 2 availability zones
- 2 private subnets across 2 availability zones
- Internet Gateway for public subnet internet access
- NAT Gateway for private subnet outbound access
- Public and private route tables with correct routing
- 2 EC2 instances in private subnets with Apache via user-data
- Application Load Balancer across both public subnets
- Target group with both instances registered
- Health checks on root path /
- Security groups enforcing ALB-only access to EC2 instances
- Dynamic hostname response proving load balancing
- Route 53 custom domain (fnaqvi.com) with alias record pointing to ALB
- ACM SSL certificate covering apex and www subdomain
- HTTPS:443 listener on ALB with ACM certificate
- HTTP to HTTPS redirect (301) on ALB

## Infrastructure Details

| Resource | Value |
|---|---|
| VPC CIDR | 10.0.0.0/16 |
| Public Subnet AZ-a | 10.0.1.0/24 (eu-west-2a) |
| Public Subnet AZ-b | 10.0.2.0/24 (eu-west-2b) |
| Private Subnet AZ-a | 10.0.3.0/24 (eu-west-2a) |
| Private Subnet AZ-b | 10.0.4.0/24 (eu-west-2b) |
| Region | eu-west-2 |

## User Data Script
```bash
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello from $(hostname -f)</h1>" > /var/www/html/index.html
```

## Architecture Decisions

**Why multi-AZ deployment?**
Deploying EC2 instances and subnets across two availability zones 
ensures high availability. If one AZ experiences an outage the 
ALB automatically routes all traffic to the healthy instance in 
the remaining AZ. Single AZ deployments create a single point 
of failure unacceptable in production environments.

**Why private subnets for EC2 instances?**
EC2 instances are deployed in private subnets with no public IP 
addresses. All traffic routes through the ALB - the only public 
entry point. Direct internet access to instances is blocked at 
both the subnet and security group level. This follows the 
principle of least privilege - resources should never be more 
exposed than necessary.

**Why a NAT Gateway?**
Private instances need outbound internet access to pull package 
updates and install Apache via user-data. NAT Gateway allows 
outbound connections without exposing instances to inbound 
internet traffic. It sits in the public subnet to use the 
Internet Gateway route on behalf of private instances.

**Why dynamic hostname in user-data?**
Using $(hostname -f) dynamically returns each instance's actual 
hostname at launch time rather than hardcoded text. This proves 
the ALB is genuinely routing to different instances — a more 
accurate verification of load balancing behaviour reflecting 
how engineers verify this in production.

**Why reference ALB security group in EC2 security group?**
Rather than allowing HTTP from anywhere (0.0.0.0/0) on EC2 
instances, the security group references the ALB security group 
as the source. Only traffic originating from the ALB is permitted 
— direct internet access to instances is blocked entirely.

## Screenshots

### VPC Created
![VPC](screenshots/vpc.png)

### Subnets — 4 across 2 AZs
![Subnets](screenshots/subnets1.png)
![Subnets](screenshots/subnets2.png)

### Internet Gateway
![IGW](screenshots/igw2.png)

### NAT Gateway
![NAT Gateway](screenshots/nat-gateway.png)

### Route Tables
![Route Tables](screenshots/route-tables1.png)
![Route Tables](screenshots/route-tables2.png)

### EC2 Instances Running in Private Subnets
![EC2 Instances](screenshots/ec2-instances.png)

### ALB Created and Active
![ALB](screenshots/alb1.png)

### Target Group — Both Instances Healthy
![Target Group](screenshots/target-group-healthy.png)

### Traffic Alternating — Instance 1
![Instance 1](screenshots/instance-1.png)

### Traffic Alternating — Instance 2
![Instance 2](screenshots/instance-2.png)

## What I Learned

**Networking must be configured before infrastructure**
The most important lesson from this assignment. VPC, subnets, 
Internet Gateway, NAT Gateway and route tables must all be 
fully configured before launching any compute resources. 
Infrastructure depends on networking — not the other way around. 
The correct order is: IGW → public route table → NAT Gateway → 
private route table → then EC2, ALB, everything else.

**NAT Gateway dependency chain**
NAT Gateway requires a fully configured Internet Gateway and 
public subnet route table before it can function. Launching 
NAT Gateway before IGW is attached and routes are configured 
causes it to fail silently — no internet access for private 
instances. Understanding the dependency chain prevents this.

**Security group ordering and referencing**
Creating the ALB security group first, then referencing it as 
the source in the EC2 security group, is cleaner and more 
secure than opening ports broadly and restricting later. 
Security groups can also be changed on running instances 
without termination — EC2 → Actions → Security → Change 
Security Groups.

**How ALB health checks work**
ALB continuously checks the health of registered targets by 
sending HTTP requests to the configured path — / in this case. 
Only healthy instances receive traffic. If an instance fails 
its health check the ALB automatically stops routing to it 
until it recovers.

**Multi-AZ load balancing**
The ALB automatically distributes traffic across registered 
instances in multiple AZs using round robin by default. 
Refreshing the page shows different hostnames confirming 
traffic is genuinely reaching different instances in 
different availability zones.

## Challenges and How I Solved Them

**Challenge:** NAT Gateway failing — private instances had 
no internet access
**Root cause:** Launched NAT Gateway before Internet Gateway 
was attached to VPC and public subnet route table was 
configured. NAT Gateway had no path to the internet.
**Solution:** Attached Internet Gateway to VPC, configured 
public subnet route table with IGW route, then NAT Gateway 
functioned correctly.
**Lesson:** Always complete the full networking layer first. 
The dependency chain is: IGW → public route table → NAT 
Gateway → private route table → EC2 instances. Breaking 
any link causes downstream failures.

**Challenge:** Had to terminate and recreate EC2 instances 
to fix security group configuration
**Root cause:** Created EC2 security group allowing HTTP 
from anywhere initially. Should have restricted to ALB SG 
only from the start. Also didn't realise security groups 
can be changed without termination.
**Solution:** Terminated instances, created new ones with 
correct security group referencing ALB SG directly.
**Lesson:** Create ALB and its security group first, then 
reference it in EC2 security group before launching instances. 
Security groups can be changed on running instances without 
termination — Actions → Security → Change Security Groups.

## What I'd Do Differently
- Configure all networking before launching any infrastructure
- Create ALB security group first and reference it in EC2 
  security group from the start — avoid terminating instances
- Enable auto-assign public IP at subnet level where needed 
  rather than managing per instance
- Tag all resources consistently from the start for easier 
  identification and cleanup

## How To Reproduce
1. Create VPC with CIDR 10.0.0.0/16
2. Create public subnet 10.0.1.0/24 in eu-west-2a
3. Create public subnet 10.0.2.0/24 in eu-west-2b
4. Create private subnet 10.0.3.0/24 in eu-west-2a
5. Create private subnet 10.0.4.0/24 in eu-west-2b
6. Create and attach Internet Gateway to VPC
7. Create public route table — add route 0.0.0.0/0 to IGW
8. Associate public subnets with public route table
9. Allocate Elastic IP
10. Create NAT Gateway in public subnet 10.0.1.0/24
11. Create private route table — add route 0.0.0.0/0 to NAT Gateway
12. Associate private subnets with private route table
13. Create ALB security group — allow HTTP port 80 from 0.0.0.0/0
14. Create EC2 security group — allow HTTP port 80 from ALB SG only
15. Launch EC2 instance in 10.0.3.0/24 with user-data script
16. Launch EC2 instance in 10.0.4.0/24 with user-data script
17. Create target group — HTTP port 80, health check on /
18. Register both EC2 instances to target group
19. Create ALB — internet facing, across 10.0.1.0/24 and 10.0.2.0/24
20. Add HTTP listener on port 80 forwarding to target group
21. Visit ALB DNS name — verify traffic alternates between instances
22. Register a domain in Route 53 or transfer an existing one
23. Create an alias record pointing your domain to the ALB DNS name
24. Request a certificate in ACM for both apex and www subdomain
25. Validate certificate via DNS — click "Create record in Route 53" in ACM
26. Wait for certificate status to change to Issued
27. Add HTTPS:443 listener to ALB - forward to target group, attach ACM certificate
28. Edit HTTP:80 listener — change action to redirect to HTTPS (301)
29. Add a second alias record in Route 53 for www subdomain pointing to ALB
30. Visit https://yourdomain.com — verify padlock and HTTPS

## Bonus Tasks

### Route 53 — Custom Domain
Registered `fnaqvi.com` via Route 53 and created an **alias record** 
pointing to the ALB DNS name. Used an alias record rather than a CNAME 
because alias records work at the zone apex and are free for AWS resources.

### HTTPS with ACM Certificate
Requested a certificate from **AWS Certificate Manager (ACM)** covering 
both `fnaqvi.com` and `www.fnaqvi.com`. Validated via DNS by adding the 
CNAME validation records to Route 53. Once issued:
- Added a **HTTPS:443 listener** to the ALB with the ACM certificate attached
- Configured the **HTTP:80 listener** to redirect all traffic to HTTPS (301)
- Added a Route 53 alias record for `www.fnaqvi.com` pointing to the ALB

### Services Added
- Route 53 (DNS + alias records)
- ACM (SSL/TLS certificate)

## Resources Used
- AWS ALB Documentation
- AWS VPC Documentation
- CoderCo DevOps Course
