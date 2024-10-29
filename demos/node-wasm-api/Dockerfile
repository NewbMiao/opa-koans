FROM node:22-bullseye-slim AS build
WORKDIR /app
COPY package.json /app/
RUN npm install --prefer-offline --frozen-lockfile
COPY . /app
RUN npm run build && npm prune --production

FROM gcr.io/distroless/nodejs20-debian11
COPY --from=build /app /app
WORKDIR /app
EXPOSE 3001
CMD ["dist/main.js"]

# sh build.sh to build docker image
# docker run -it -p 3001:3001 node-wasm-api