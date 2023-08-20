FROM docker.io/redhat/ubi9-minimal

ARG GRAALVM_VERSION=22.3.2
ARG JAVA_VERSION=java17
ARG VELOCITY=3.2.0
ARG BUILD=264

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV JAVA_HOME=/opt/graalvm-ce-$JAVA_VERSION-$GRAALVM_VERSION

RUN microdnf install -y binutils tzdata openssl wget ca-certificates fontconfig glibc-langpack-en gzip tar \
    freetype dejavu-sans-mono-fonts \
    && microdnf clean all

RUN curl -L https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-$JAVA_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz | tar -zxvC /opt/ \
    && update-alternatives --install /usr/bin/java java "$JAVA_HOME"/bin/java 2000 \
    && update-alternatives --install /usr/bin/javac javac "$JAVA_HOME"/bin/javac 2000 \
    && update-alternatives --install /usr/bin/jar jar "$JAVA_HOME"/bin/jar 2000

RUN mkdir /app \
    && curl -L https://api.papermc.io/v2/projects/velocity/versions/${VELOCITY}-SNAPSHOT/builds/${BUILD}/downloads/velocity-${VELOCITY}-SNAPSHOT-${BUILD}.jar -o /app/velocity.jar

WORKDIR /proxy
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]