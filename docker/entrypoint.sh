#!/bin/sh
set -eu

JAR="/app/app.jar"

if [ ! -f "$JAR" ]; then
  echo "[ERROR] JAR file not found at /app/app.jar"
  exit 1
fi

echo "[INFO] ========================================"
echo "[INFO] JMusicBot Containerized"
echo "[INFO] ========================================"
echo "[INFO] Selected jar: $JAR"
echo "[INFO] Working directory: $(pwd)"
if [ -f "config.txt" ]; then
  echo "[INFO] config.txt: Found (existing)"
else
  echo "[INFO] config.txt: Not found (will be generated on first run)"
fi
echo "[INFO] ========================================"

# Default JVM options for optimal audio performance (ZGC with sub-ms pauses)
# Set JAVA_OPTS to override; add -Xms/-Xmx for heap limits if desired
: "${JAVA_OPTS:=-XX:+UseZGC -XX:+AlwaysPreTouch}"

# Build argv
set -- java -Dnogui=true --enable-native-access=ALL-UNNAMED

# Append JAVA_OPTS (either default or user-provided)
if [ -n "${JAVA_OPTS:-}" ]; then
  # shellcheck disable=SC2086
  set -- "$@" $JAVA_OPTS
fi

set -- "$@" -jar "$JAR"

# --- User handling ---------------------------------------------------------
# The bot never runs as root:
#  * Started as root (the default, or an explicit -u 0): fix ownership of
#    the working directory first (this also repairs bind-mounted volumes
#    whose host-side owner differs), then drop privileges to
#    $MUSICBOT_UID:$MUSICBOT_GID (default 10001:10001, user 'jmusicbot').
#  * Started with -u <uid>:<gid>: ownership is left untouched; the working
#    directory must already be writable by that user.
if [ "$(id -u)" = "0" ]; then
  TARGET_UID="${MUSICBOT_UID:-10001}"
  TARGET_GID="${MUSICBOT_GID:-10001}"
  if ! chown -R "${TARGET_UID}:${TARGET_GID}" "$(pwd)"; then
    echo "[ERROR] Failed to set ownership of working directory to ${TARGET_UID}:${TARGET_GID}" >&2
    exit 1
  fi
  echo "[INFO] Started as root - dropping privileges to UID ${TARGET_UID}:${TARGET_GID}"
  echo "[INFO] (change the fallback with MUSICBOT_UID / MUSICBOT_GID)"
  exec setpriv --reuid="${TARGET_UID}" --regid="${TARGET_GID}" --clear-groups env HOME="$(pwd)" "$@"
else
  if [ ! -w "$(pwd)" ]; then
    echo "[ERROR] Working directory $(pwd) is not writable by UID $(id -u) (the user specified with -u)." >&2
    echo "        Mount a directory owned by that user, e.g.:" >&2
    echo "          docker run -u \$(id -u):\$(id -g) -v \$HOME/jmusicbot:/musicbot ..." >&2
    echo "        Or omit -u: the container then fixes ownership as root and" >&2
    echo "        drops to UID ${MUSICBOT_UID:-10001} (MUSICBOT_UID / MUSICBOT_GID)." >&2
    exit 1
  fi
  echo "[INFO] Running as UID $(id -u):$(id -g) (specified at container start)"
  exec "$@"
fi
