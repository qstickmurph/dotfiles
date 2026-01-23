#!/bin/bash

PARENT_BRANCH="main"
SHOULD_NOT_CHANGE_DIRECTORY=false
VERBOSE=false

function printUsageString {
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "Required options:"
  echo "  -w, --worktree NAME           Enter the name for the worktree"
  echo "  -b, --branch NAME             Enter the name for the git branch"
  echo ""
  echo "Optional options:"
  echo "  -p --parent NAME               Enter the name of the parent branch (default: master)"
  echo "  --should-not-change-directory  Whether this script should not remain in the worktree"
  echo "  -h, --help                     Show this help message"
  echo "  -v, --verbose                  Run in verbose mode"
}

OPTS=$(getopt -o hw:b:p:v -l worktree:,branch:,parent:,should-not-change-directory,help,verbose -n "$0" -- "$@" 2> /dev/null)

eval set -- "$OPTS"

while true; do
  case "$1" in
    -v|--verbose)
      VERBOSE=true
      shift
      ;;
    -w|--worktree)
      WORKTREE_NAME="$2"
      shift 2
      ;;
    -b|--branch)
      BRANCH_NAME="$2"
      shift 2
      ;;
    -p|--parent)
      PARENT_BRANCH="$2"
      shift 2
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


if [ "$SHOULD_NOT_CHANGE_DIRECTORY" = "false" ]; then
  cd "./$WORKTREE_NAME" || exit 1
  [ "$VERBOSE" = true ] && echo "Entered worktree directory"
fi
