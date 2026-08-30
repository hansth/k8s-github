# base layer
FROM python:3.13-alpine AS builder

# install uv from other image
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# change the working directory to the `app` directory
WORKDIR /app

# install dependencies into cache layer, to speed-up build process
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project --no-editable 

# copy the project files into the `app` directory
COPY . /app

# sync the project and install it
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-editable --no-dev
    # --no-dev: exclude dev dependencies

# final layer
FROM python:3.13-alpine

# create a non-root user and group
RUN addgroup -S -g 1000 app && adduser -S -u 1000 -G app app

# copy env-vars from the builder `app` directory
COPY --from=builder --chown=app:app /app/.venv /app/.venv

# switch to non-root user
USER app

# expose the container port
EXPOSE 22111

# run the application
CMD ["/app/.venv/bin/study-tracker-frontend"]
