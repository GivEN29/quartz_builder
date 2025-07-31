#--- Clone the repo and install the project dependencies into /quartz_build ---
FROM node:latest AS build
WORKDIR /app

# install your app’s dependencies
COPY package.json /app/
RUN mkdir /quartz_build && git clone https://github.com/jackyzha0/quartz.git /quartz_build && cd /quartz_build && npm install
RUN npm install

#--- Final image ---
FROM node:latest
EXPOSE 3000
WORKDIR /app

# copy your app code + its node_modules
COPY app.js package.json /app/
COPY --from=build /app/node_modules/ /app/node_modules/
COPY --from=build /quartz_build/ /quartz_build

# bring in the entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# set your envs & create directories
ENV OUTPUT_DIR=/output VAULT_DIR=/vault TIMER=20 FOLDER=/public
RUN mkdir -p $OUTPUT_DIR $VAULT_DIR

ENTRYPOINT ["/entrypoint.sh"]
CMD ["node", "/app/app.js"]
