FROM library/node:alpine

WORKDIR /workspace

RUN npm install -g \
    grunt-cli \
    && npm install \
    grunt \
    grunt-behat \
    grunt-contrib-clean \
    grunt-contrib-concat \
    grunt-contrib-connect \
    grunt-contrib-copy \
    grunt-contrib-jshint \
    grunt-contrib-less \
    grunt-contrib-qunit \
    grunt-contrib-uglify \
    grunt-contrib-watch \
    grunt-mkdir \
    grunt-phpunit \
    grunt-qunit-junit \
    && npm cache clean --force

VOLUME /workspace/node_modules

ENTRYPOINT ["grunt"]

CMD ["--help"]
