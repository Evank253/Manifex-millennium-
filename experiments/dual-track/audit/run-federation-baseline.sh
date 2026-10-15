#!/usr/bin/env bash
set -Eeuo pipefail

IMAGE="manifex-federation-baseline:001"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
EVIDENCE_DIR="${EVIDENCE_DIR:-$PWD/federation-baseline-evidence}"

mkdir -p "$EVIDENCE_DIR"
EVIDENCE_DIR="$(cd "$EVIDENCE_DIR" && pwd)"

echo "Building pinned federation runner image..."
docker build \
  --file "$SCRIPT_DIR/Dockerfile.federation-baseline" \
  --tag "$IMAGE" \
  "$SCRIPT_DIR"

echo
echo "Running federation baseline measurements..."
docker run --rm \
  --mount "type=bind,source=$EVIDENCE_DIR,target=/evidence" \
  "$IMAGE" \
  --output-dir /evidence

echo
echo "Evidence directory: $EVIDENCE_DIR"
echo "Review JSON and Markdown reports; process success is not a test verdict."
