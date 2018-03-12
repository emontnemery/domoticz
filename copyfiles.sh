#!/bin/bash
export SSHPASS="$FTP_PASSWORD"
sshpass -e sftp -o StrictHostKeyChecking=no -q -P "$FTP_PORT" "$FTP_USER"@"$FTP_HOST" <<-EOF
	quit
EOF
export FTP_DIR="/incoming/domoticz/${TRAVIS_BRANCH}/${TRAVIS_JOB_NUMBER}"
export FTP_ARGS=(cd "$FTP_DIR" "||" mkdir -p "$FTP_DIR" ";" bye)
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "${FTP_ARGS[@]}"
export FTP_FILE=domoticz_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.tgz
export FTP_ARGS=(put -e -O "$FTP_DIR" "$FTP_FILE" ";" bye)
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "${FTP_ARGS[@]}"
export FTP_FILE=domoticz_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.tgz.sha256sum
export FTP_ARGS=(put -e -O "$FTP_DIR" "$FTP_FILE" ";" bye)
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "${FTP_ARGS[@]}"
export FTP_FILE=version_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.h
export FTP_ARGS=(put -e -O "$FTP_DIR" "$FTP_FILE" ";" bye)
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "${FTP_ARGS[@]}"
export FTP_FILE=history_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.txt
export FTP_ARGS=(put -e -O "$FTP_DIR" "$FTP_FILE" ";" bye)
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "${FTP_ARGS[@]}"
export FTP_FILE=History.txt
export FTP_ARGS=(put -e -O "$FTP_DIR" "$FTP_FILE" ";" bye)
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "${FTP_ARGS[@]}"
echo "$TRAVIS_COMMIT" > SHAID.txt
export FTP_FILE=SHAID.txt
export FTP_ARGS=(put -e -O "$FTP_DIR" "$FTP_FILE" ";" bye)
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "${FTP_ARGS[@]}"
