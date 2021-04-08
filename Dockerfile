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
    grunt-postcss \
    grunt-sass \
    node-sass \
    pixrem \
 && npm cache clean --force

VOLUME /workspace/node_modules

ENTRYPOINT ["grunt"]

CMD ["--help"]
