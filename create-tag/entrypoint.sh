#!/bin/sh

set -eu

if [ -z "${INPUT_TAG}" ]; then
  echo "[create-tag] No tag supplied"
  exit 1
fi

# Initialise variables
TAG="${INPUT_TAG}"
SHA=${INPUT_COMMIT_SHA:-${GITHUB_SHA}}

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

# Create tag
echo "[create-tag] Create tag '${TAG}'."

git tag "${TAG}" "${SHA}"

if [ -n "${INPUT_GITHUB_TOKEN}" ]; then
  git remote set-url origin "https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
fi

# Push tag
echo "[create-tag] Push tag '${TAG}'."
git push origin "${TAG}"