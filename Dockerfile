FROM node:lts-alpine3.13

WORKDIR /workspace

RUN npm install -g \
    grunt-cli \
 && npm install \
    autoprefixer \
    cssnano \
    fibers \
    grunt \
    grunt-contrib-concat \
    grunt-contrib-copy \
    grunt-contrib-jshint \
    grunt-contrib-less \
    grunt-contrib-uglify \
    grunt-mkdir \
    @lodder/grunt-postcss \
    grunt-sass \
    node-sass \
    pixrem \
    postcss \
 && npm cache clean --force

VOLUME /workspace/node_modules

LABEL org.opencontainers.image.source=https://github.com/ingenerator/asset-builder

ENTRYPOINT ["grunt"]

CMD ["--help"]
