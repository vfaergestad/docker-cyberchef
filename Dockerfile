FROM node:latest as build

RUN chown -R node:node /srv

USER node
WORKDIR /srv
RUN git clone https://github.com/gchq/CyberChef.git
RUN cd CyberChef
RUN npm install

ENV NODE_OPTIONS="--max_old_space_size=2048"
RUN npx grunt prod

FROM nginx:latest as app

COPY --from=build /srv/build/prod /usr/share/nginx/html

EXPOSE 80/tcp
