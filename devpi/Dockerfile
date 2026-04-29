FROM aashipov/docker:debian13-python AS builder
ARG DUMMY_USER=dummy
ARG DUMMY_UID=10001
ARG DUMMY_GID=10001
COPY --chown=${DUMMY_UID}:${DUMMY_GID} build.sh /${DUMMY_USER}/build.sh
COPY --chown=${DUMMY_UID}:${DUMMY_GID} requirements.txt /${DUMMY_USER}/requirements.txt
USER ${DUMMY_USER}
RUN /${DUMMY_USER}/build.sh

FROM builder AS devpi
