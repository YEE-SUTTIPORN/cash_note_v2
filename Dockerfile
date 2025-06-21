# Stage 1
FROM node:18 AS build
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .
RUN npm run build --prod

# Stage 2
FROM nginx:alpine
COPY --from=build /app/dist/frontend /usr/share/nginx/html
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
