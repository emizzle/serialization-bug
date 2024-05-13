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

if [ -d "./vendor/${dep}" ]; then
  echo "2. Dependency ${dep} already exists. Skip adding."
else
  echo "2. Add submodule at ${project_root}/vendor/${dep}"
  git submodule add "${remote}" "./vendor/${dep}"

  echo "2a. Checkout nested submodules."
  git submodule update --init --recursive
fi

cd "./vendor/${dep}"
echo "3. Switch submodule to ${revision}."
git checkout "${revision}"
cd ../..

echo "4. Update nim.cfg."
rm -rf nim.cfg 
for i in $(ls ./vendor/); do 
  echo '--path:'\"./vendor/$i\"'' >> ./nim.cfg; 
done;

echo "Done."

