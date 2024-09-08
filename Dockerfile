# use the official Bun image
# see all versions at https://hub.docker.com/r/oven/bun/tags
FROM oven/bun:1 AS base
WORKDIR /usr/src/app

# install dependencies into temp directory
# this will cache them and speed up future builds
FROM base AS install
RUN mkdir -p /temp/deps
COPY package.json bun.lockb /temp/deps/
RUN cd /temp/deps && bun install --frozen-lockfile && bun pm trust --all

# copy node_modules from temp directory
# then copy all (non-ignored) project files into the image
# and finally build the app
FROM base AS prod
WORKDIR /usr/src/app
COPY --from=install /temp/deps/node_modules node_modules
COPY . .
RUN bun run build

# run the app
USER root
EXPOSE 4173/tcp
CMD [ "bun", "run", "preview", "--host" ]
