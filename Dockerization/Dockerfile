FROM postman/newman:5.3-alpine

# Update and upgrade the image packages
RUN apk update && apk upgrade --no-cache

# Install required node module globally
RUN npm install -g newman-reporter-csvallinone

# Install extra packages
RUN apk add --no-cache curl zip ping
RUN apk add curl zip ping

# Set explicit DNS servers
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf \
    && echo "nameserver 1.1.1.1" >> /etc/resolv.conf

# Remove installation cache
RUN rm -rf /var/cache/apk/*

# Set environment variable
ENV NODE_PATH=/usr/local/lib/node_modules

# Set working directory
WORKDIR /etc/newman

# Set entry point
ENTRYPOINT ["newman"]


# ##########################################
#  VMs => Docker => No Space left on device
#  /var/docker/overlay
# podman images
# 1.12 
#  df -h 
#  du -sh */