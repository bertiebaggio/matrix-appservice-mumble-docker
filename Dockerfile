FROM node:14-alpine as mambuild

COPY --chown=node . ./mam/
WORKDIR mam/
RUN npm install && ./build.sh && chown node:node build/ -R
WORKDIR build/
      
FROM mambuild as mamrun
VOLUME /config/
USER node
EXPOSE 8090

ENTRYPOINT ["node", "main.js", "-c", "/config/mumble-config.yaml", "-f", "/config/mumble-registration.yaml"]
