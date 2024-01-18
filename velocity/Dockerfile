FROM docker.io/redhat/ubi9-minimal

ARG VELOCITY=3.3.0
ARG BUILD=327

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV JAVA_HOME=/opt/graalvm-17

RUN microdnf install -y binutils tzdata openssl wget ca-certificates fontconfig glibc-langpack-en gzip tar \
    freetype dejavu-sans-mono-fonts \
    && microdnf clean all \
    && mkdir /opt/graalvm-17

RUN curl -L https://download.oracle.com/graalvm/17/latest/graalvm-jdk-17_linux-x64_bin.tar.gz | \
    tar --strip-components 1 \
    --ungzip \
    --extract \
    --directory "$JAVA_HOME" \
    && update-alternatives --install /usr/bin/java java "$JAVA_HOME"/bin/java 2000 \
    && update-alternatives --install /usr/bin/javac javac "$JAVA_HOME"/bin/javac 2000 \
    && update-alternatives --install /usr/bin/jar jar "$JAVA_HOME"/bin/jar 2000

RUN mkdir /app \
    && curl -L https://api.papermc.io/v2/projects/velocity/versions/${VELOCITY}-SNAPSHOT/builds/${BUILD}/downloads/velocity-${VELOCITY}-SNAPSHOT-${BUILD}.jar \
    -o /app/velocity.jar

WORKDIR /proxy
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]