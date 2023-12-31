FROM docker.io/eclipse-temurin:17.0.8.1_1-jdk-ubi9-minimal as build

RUN microdnf install findutils git -y && microdnf clean all \
    && git config --global user.name "Automated build" && git config --global user.email "build@example.com" \
    && git clone https://github.com/MultiPaper/MultiPaper.git -b dev/1.20.1

WORKDIR /MultiPaper

RUN ./gradlew applyPatches && ./gradlew shadowjar createReobfPaperclipJar

FROM docker.io/redhat/ubi9-minimal as production

ARG GRAALVM_VERSION=22.3.2
ARG JAVA_VERSION=java17

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV JAVA_HOME=/opt/graalvm-ce-$JAVA_VERSION-$GRAALVM_VERSION

RUN microdnf install -y binutils tzdata openssl wget ca-certificates fontconfig glibc-langpack-en gzip tar \
    freetype dejavu-sans-mono-fonts && microdnf clean all

RUN curl -L https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-$JAVA_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz | tar -zxvC /opt/ \
    && update-alternatives --install /usr/bin/java java "$JAVA_HOME"/bin/java 2000 \
    && update-alternatives --install /usr/bin/javac javac "$JAVA_HOME"/bin/javac 2000 \
    && update-alternatives --install /usr/bin/jar jar "$JAVA_HOME"/bin/jar 2000

RUN mkdir /app && echo "eula=true" > /app/eula.txt

COPY --from=build /MultiPaper/build/libs/multipaper-paperclip-*-*-SNAPSHOT-reobf.jar /app/multipaper.jar
COPY --from=build /MultiPaper/MultiPaper-Master/build/libs/multipaper-master-*-all.jar /app/multipaper-master.jar

WORKDIR /server
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]