# MagicMirror² module development environment

This repository contains only the shared Docker development environment. Every
module below `modules/` is a separate Git repository and is deliberately ignored
by this repository.

## Requirements

- Docker Desktop with Docker Compose
- Git

## Start

```powershell
docker compose up --build
```

Open <http://localhost:8088>. A change to `config/config.js` restarts the server
and reloads connected browsers automatically. For module frontend and CSS
changes, reload the browser. After changing `node_helper.js`, restart with
`docker compose restart`. Stop a foreground instance with `Ctrl+C`, or run it
in the background using `docker compose up --build --detach`.

Copy `.env.example` to `.env` and enter private, machine-specific values there.
The `.env` file is ignored by Git. The aha module uses these variables:

```dotenv
AHA_MUNICIPALITY=Hannover
AHA_STREET=Beispielstraße
AHA_HOUSE_NUMBER=1
AHA_HOUSE_NUMBER_SUFFIX=
```

Port `8088` avoids common conflicts with other local development services. It
can be changed for one invocation, for example:

```powershell
$env:MAGICMIRROR_PORT = 8090
docker compose up --detach
```

## Add a module repository

Create a new, separately versioned module:

```powershell
New-Item -ItemType Directory modules/MMM-AhaAbfuhr
git -C modules/MMM-AhaAbfuhr init
```

Alternatively, clone an existing repository directly into `modules/`:

```powershell
git clone <repository-url> modules/<module-name>
```

Add the module to `config/config.js`, for example:

```js
{
  module: "MMM-AhaAbfuhr",
  position: "top_right",
  config: {},
},
```

Install a module's npm dependencies inside the same Linux environment in which
MagicMirror runs:

```powershell
docker compose exec -w /opt/magicmirror/modules/MMM-AhaAbfuhr magicmirror npm install
```

Run module-specific commands in the same way:

```powershell
docker compose exec -w /opt/magicmirror/modules/MMM-AhaAbfuhr magicmirror npm test
```

Generated `node_modules` remains inside the module repository and should be
ignored by that module's own `.gitignore`.

## Update MagicMirror²

Change `MAGICMIRROR_VERSION` and, if required by that release, `NODE_VERSION` in
`compose.yaml`, then rebuild:

```powershell
docker compose build --no-cache
docker compose up --detach
```
