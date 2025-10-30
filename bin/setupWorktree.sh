#!/bin/bash

PARENT_BRANCH="main"
SHOULD_START_PROGRAM=false
SHOULD_NOT_CHANGE_DIRECTORY=false
VERBOSE=false

function printUsageString {
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "Required options:"
  echo "  --worktree-name NAME       Enter the name for the worktree"
  echo "  --branch-name NAME         Enter the name for the git branch"
  echo ""
  echo "Optional options:"
  echo "  --parent-branch NAME       Enter the name of the parent branch (default: master)"
  echo "  --start-program            Whether this should start the program in the new worktree"
  echo "  --should-not-change-directory  Whether this script should not remain in the worktree"
  echo "  -h, --help                     Show this help message"
}

OPTS=$(getopt -o h,v -l worktree-name:,branch-name:,parent-branch:,start-program,should-not-change-directory,help -n "$0" -- "$@" 2> /dev/null)

eval set -- "$OPTS"

while true; do
  case "$1" in
    -v|--verbose)
      VERBOSE=true
      shift
      ;;
    --worktree-name)
      WORKTREE_NAME="$2"
      shift 2
      ;;
    --branch-name)
      BRANCH_NAME="$2"
      shift 2
      ;;
    --parent-branch)
      PARENT_BRANCH="$2"
      shift 2
      ;;
    --start-program)
      SHOULD_START_PROGRAM=true
      shift
      ;;
    --should-not-change-directory)
      SHOULD_NOT_CHANGE_DIRECTORY=true
      shift
      ;;
    -h|--help)
      printUsageString
      exit 0
      ;;
    --)
      shift
      break
      ;;
    *)
      echo $1
      printUsageString
      exit 1
      ;;
  esac
done

if [ -z "$WORKTREE_NAME" ]; then
  echo "Error: --worktree-name is required." >&2
  printUsageString
  exit 1
fi

if [ -z "$BRANCH_NAME" ]; then
  echo "Error: --branch-name is required." >&2
  printUsageString
  exit 1
fi

[ "$VERBOSE" = true ] && echo "Starting creating worktree '$WORKTREE_NAME' from branch '$BRANCH_NAME' with parent '$PARENT_BRANCH'"

if ! git rev-parse --is-bare-repository &>/dev/null; then
  echo "Error: Invalid working directory. Please run at the base of a bare repository" >&2
  exit 1
fi

if ! git rev-parse --quiet --verify "$BRANCH_NAME" &>/dev/null; then
  if ! git rev-parse --quiet --verify "$PARENT_BRANCH" &>/dev/null; then
    echo "Error: Invalid 'parent-branch' provided" >&2
    exit 1
  fi

  if ! git branch "$BRANCH_NAME" "$PARENT_BRANCH" &>/dev/null; then
    echo "Error: Could not create git branch '$BRANCH_NAME' from '$PARENT_BRANCH'" >&2
    exit 1
  fi
fi

[ "$VERBOSE" = true ] && echo "Created git branch '$BRANCH_NAME'"

if ! git worktree add "$WORKTREE_NAME" "$BRANCH_NAME" &>/dev/null; then
  echo "Error: Failed to create worktree $WORKTREE_NAME" >&2
  exit 1
fi

[ "$VERBOSE" = true ] && echo "Created git worktree '$WORKTREE_NAME'"

ORIGINAL_DIR=$(pwd)

cd "./$WORKTREE_NAME" || exit 1

if ! pwsh ./scripts/powershell/buildAllLocal.ps1 &>/dev/null; then
  echo "Error: Failed to build" >&2
  exit 1
else
  [ "$VERBOSE" = true ] && echo "Successfully built local program"
fi

if ! npm ci --prefix ./web/Gui/ &>/dev/null; then
  echo "Error: Failed to npm ci" >&2
  exit 1
else
  [ "$VERBOSE" = true ] && echo "Successfully completed npm ci"
fi

if [ "$SHOULD_START_PROGRAM" = true ]; then
  if ! pwsh ./scripts/powershell/startAllLocal.ps1 &>/dev/null; then
    echo "Error: Failed to start program" >&2
    exit 1
  else
    [ "$VERBOSE" = true ] && echo "Successfully started program"
  fi
fi

if [ "$SHOULD_NOT_CHANGE_DIRECTORY" = true ]; then
  cd "$ORIGINAL_DIR" || exit 1
  [ "$VERBOSE" = true ] && echo "Returned to original directory"
fi
