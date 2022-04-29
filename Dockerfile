FROM python:3.8-slim as base

# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

RUN pip install pipenv
EXPOSE 5000/tcp

FROM base AS python-deps

# Install pipenv and compilation dependencies
RUN apt-get update && apt-get install -y --no-install-recommends gcc

# Install python dependencies in /.venv
COPY src/Pipfile .
COPY src/Pipfile.lock .
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy --ignore-pipfile

FROM base AS runtime

# Create and switch to a new user
RUN useradd --create-home appuser
WORKDIR /home/appuser

# Install application into container
COPY src/. .

# Copy virtual env from python-deps stage
COPY --from=python-deps .venv /.venv
RUN chown -R appuser:appuser /home/appuser
ENV PATH="/.venv/bin:$PATH"

USER appuser

# Run the application
ENTRYPOINT ["/bin/sh", "run_app.sh"]
