 !/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker ec2-user
    
    # Wait for docker to be ready
    sleep 10
    
    # Run nginx container
    sudo docker run -d -p 8080:80 --name nginx-server nginx:latest