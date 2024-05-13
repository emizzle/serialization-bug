#!/usr/bin/env bash
set -e

dep="${1}"

project_root="${PWD}"

mkdir -p "./vendor"

cd "${codex_root}/vendor/${dep}"

echo "1. Inspect dependency ${dep}:"
revision=$(git rev-parse --short HEAD)
remote="$(git remote get-url origin)"

echo "  - revision: ${revision}"
echo "  - remote: ${remote}"

cd "${project_root}"

echo "2. Add submodule at ${project_root}/vendor/${dep}"
git submodule add "${remote}" "./vendor/${dep}"
cd "./vendor/${dep}"

echo "3. Switch submodule to ${revision}."
git checkout "${revision}"
cd ..

echo "Done."

