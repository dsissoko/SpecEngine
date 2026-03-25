#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: specengine-new.sh [--yes] <PROJECT_NAME> <ORG_NAME> [DEST_DIR] [TEMPLATE_URL]

Create a new project instance from a SpecEngine template tarball.

Arguments:
  --yes        Run non-interactively (no confirmation prompt).
  PROJECT_NAME  Logical name of the service/product.
  ORG_NAME      Owning organisation or team.
  DEST_DIR      Optional. Target directory for the new project.
                Defaults to the current directory (".").
  TEMPLATE_URL  Optional. URL of the specengine-template-*.tar.gz archive.
                If omitted, SPECENGINE_TEMPLATE_URL or a built-in default
                are used.

The TEMPLATE_URL should typically point to a GitHub Release asset, e.g.:
  https://github.com/<org>/SpecEngine/releases/download/v0.1.0/specengine-template-v0.1.0.tar.gz
EOF
}

AUTO_YES="false"

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

# Parse optional --yes flag
if [[ "${1:-}" == "--yes" || "${1:-}" == "-y" ]]; then
  AUTO_YES="true"
  shift
fi

if [[ $# -lt 2 || $# -gt 4 ]]; then
  echo "Error: invalid number of arguments." >&2
  usage
  exit 1
fi

PROJECT_NAME="$1"
ORG_NAME="$2"
# Default destination directory: current directory if not provided
if [[ $# -ge 3 ]]; then
  DEST_DIR="$3"
else
  DEST_DIR="."
fi

TEMPLATE_URL_ARG="${4:-}"

if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required but not found in PATH." >&2
  exit 1
fi

if ! command -v tar >/dev/null 2>&1; then
  echo "Error: tar is required but not found in PATH." >&2
  exit 1
fi

resolve_template_url() {
  # 1. Explicit argument wins
  if [[ -n "$TEMPLATE_URL_ARG" ]]; then
    printf '%s\n' "$TEMPLATE_URL_ARG"
    return 0
  fi

  # 2. Environment variable
  if [[ -n "${SPECENGINE_TEMPLATE_URL:-}" ]]; then
    printf '%s\n' "$SPECENGINE_TEMPLATE_URL"
    return 0
  fi

  # 3. Auto-resolve from GitHub "latest release"
  local api_url="https://api.github.com/repos/dsissoko/SpecEngine/releases/latest"
  local latest_json tag

  echo "Resolving latest SpecEngine template from GitHub API..." >&2
  latest_json="$(curl -fsSL "$api_url")" || {
    echo "Error: failed to query GitHub API at $api_url" >&2
    exit 1
  }

  tag="$(printf '%s\n' "$latest_json" \
    | sed -n 's/.*"tag_name":[[:space:]]*"\([^"]*\)".*/\1/p' \
    | head -n1)"

  if [[ -z "$tag" ]]; then
    echo "Error: could not extract tag_name from GitHub latest release response." >&2
    exit 1
  fi

  printf 'https://github.com/dsissoko/SpecEngine/releases/download/%s/specengine-template-%s.tar.gz\n' "$tag" "$tag"
}

TEMPLATE_URL="$(resolve_template_url)"

if [[ "$DEST_DIR" != "." ]]; then
  if [[ -e "$DEST_DIR" ]]; then
    if [[ -d "$DEST_DIR" && -z "$(ls -A "$DEST_DIR")" ]]; then
      # Empty directory is acceptable
      :
    else
      echo "Error: destination '$DEST_DIR' already exists and is not an empty directory." >&2
      exit 1
    fi
  else
    mkdir -p "$DEST_DIR"
  fi
else
  # Current directory: must be empty to avoid accidental overwrite.
  if [[ -n "$(ls -A "$DEST_DIR")" ]]; then
    echo "Error: current directory is not empty. Please run in an empty directory or provide a DEST_DIR." >&2
    exit 1
  fi
fi

echo "Creating SpecEngine project in '$DEST_DIR'..."
echo "  PROJECT_NAME = $PROJECT_NAME"
echo "  ORG_NAME     = $ORG_NAME"
echo "  TEMPLATE_URL = $TEMPLATE_URL"

if [[ "$AUTO_YES" != "true" ]]; then
  printf "Proceed with these settings? [y/N]: "
  read -r answer || answer=""
  case "$answer" in
    y|Y)
      ;;
    *)
      echo "Aborted by user."
      exit 1
      ;;
  esac
fi

echo "Downloading and extracting template..."
curl -fsSL "$TEMPLATE_URL" | tar xz -C "$DEST_DIR"

echo "Replacing placeholders..."
find "$DEST_DIR" -type f -print0 | while IFS= read -r -d '' file; do
  # Skip large external catalog if present
  case "$file" in
    */agents/codex/catalog.yaml)
      continue
      ;;
  esac

  # Use sed -i with backup for portability (GNU/BSD)
  sed -i.bak \
    -e "s/__PROJECT_NAME__/${PROJECT_NAME//\//\\/}/g" \
    -e "s/__ORG_NAME__/${ORG_NAME//\//\\/}/g" \
    "$file" && rm -f "${file}.bak"
done

if command -v git >/dev/null 2>&1; then
  echo "Initialising Git repository..."
  (
    cd "$DEST_DIR"
    git init -q
    git add . >/dev/null 2>&1 || true
    git commit -q -m "chore: bootstrap ${PROJECT_NAME} from SpecEngine template" || true
  )
else
  echo "Warning: git not found, skipping repository initialisation." >&2
fi

echo "Done."
echo "Project '$PROJECT_NAME' for '$ORG_NAME' is ready in '$DEST_DIR'."
