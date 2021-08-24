FROM node:16-alpine
WORKDIR /usr/src/app
ENV PORT=3001
ENV NATS_SERVER="nats:4222"
ENV DASHBOARD_URL="dashboard.lamp.digital"
ENV APP_GATEWAY="app-gateway.lamp.digital"
ENV REDIS_HOST="redis://message_queue:6379/0"
ENV PUSH_API_KEY="n1WHtGTpRByGjeOP"
ENV SCHEDULER="on"
ENV LAMP_SERVER="api-staging.lamp.digital"
ENV LAMP_AUTH="admin:726bbf90893fd3ad9a934bc3494605bdf4a3f14ac7f3732467eb99e19b1f4942"
COPY package*.json ./
RUN npm install
COPY . .
RUN cd ./node_modules/lamp-core && npm run build
RUN cd ..
RUN cd ..
RUN npm run build
EXPOSE 3001
CMD ["node", "-r", "source-map-support/register", "./build/app.js"]
