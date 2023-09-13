FROM nginx:alpine

# Remove the default Nginx configuration
RUN rm -rf /etc/nginx/conf.d/*

# Copy the Nginx configuration file for your Angular app
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built Angular app from the previous stage
COPY /dist/employeemanagerapp /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]

# Expose the default Nginx port

EXPOSE 80


