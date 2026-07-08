# MagicMirror² module development environment

This repository is a generic Docker development environment for MagicMirror²
modules. It does not contain or version any module. Every directory below
`modules/` is a separate Git repository and is ignored by this repository.

## Requirements

- Linux with Docker Engine and the Docker Compose plugin
- Git

## Start

Create the local MagicMirror configuration once:

```bash
cp config/config.js.example config/config.js
```

`config/config.js` is intentionally ignored, so each developer can activate and
configure local modules without adding them or private values to this repository.

```bash
docker compose up --build
```

Open <http://localhost:8088>. A change to `config/config.js` restarts the server
and reloads connected browsers automatically. For module frontend and CSS
changes, reload the browser. After changing `node_helper.js`, restart with
`docker compose restart`. Stop a foreground instance with `Ctrl+C`, or run it
in the background using `docker compose up --build --detach`.

Port `8088` avoids common conflicts with other local development services. It
can be changed for one invocation, for example:

```bash
MAGICMIRROR_PORT=8090 docker compose up --detach
```

## Add a module repository

Create a new, separately versioned module:

```bash
mkdir -p modules/MMM-MyModule
git -C modules/MMM-MyModule init
```

Alternatively, clone an existing repository directly into `modules/`:

```bash
git clone <repository-url> modules/<module-name>
```

Add the module to `config/config.js`, for example:

```js
{
  module: "MMM-MyModule",
  position: "top_right",
  config: {},
},
```

Install a module's npm dependencies inside the same Linux environment in which
MagicMirror runs:

```bash
docker compose exec -w /opt/magicmirror/modules/MMM-MyModule magicmirror npm install
```

Run module-specific commands in the same way:

```bash
docker compose exec -w /opt/magicmirror/modules/MMM-MyModule magicmirror npm test
```

Generated `node_modules` remains inside the module repository and should be
ignored by that module's own `.gitignore`.

## Update MagicMirror²

Change `MAGICMIRROR_VERSION` and, if required by that release, `NODE_VERSION` in
`compose.yaml`, then rebuild:

```bash
docker compose build --no-cache
docker compose up --detach
```
