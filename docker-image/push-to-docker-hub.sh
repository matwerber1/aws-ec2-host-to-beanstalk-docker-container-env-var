docker build -t eb-ec2-metadata-container:latest .
docker tag eb-ec2-metadata-container:latest:latest berbs/eb-ec2-metadata-container:latest
docker push berbs/eb-ec2-metadata-container:latest