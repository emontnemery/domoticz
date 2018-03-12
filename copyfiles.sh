#!/bin/bash
export SSHPASS="$FTP_PASSWORD"
sshpass -e sftp -o StrictHostKeyChecking=no -q -P "$FTP_PORT" "$FTP_USER"@"$FTP_HOST" <<EOF
  quit
EOF
export FTP_DIR="/incoming/domoticz/${TRAVIS_BRANCH}/${TRAVIS_JOB_NUMBER}"
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "cd \x22$FTP_DIR\x22 || mkdir -p \x22$FTP_DIR\x22; bye"
export FTP_FILE=domoticz_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.tgz
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "put -e -O \x22$FTP_DIR\x22 \x22$FTP_FILE\x22; bye"
export FTP_FILE=domoticz_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.tgz.sha256sum
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "put -e -O \x22$FTP_DIR\x22 \x22$FTP_FILE\x22; bye"
export FTP_FILE=version_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.h
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "put -e -O \x22$FTP_DIR\x22 \x22$FTP_FILE\x22; bye"
export FTP_FILE=history_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.txt
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "put -e -O \x22$FTP_DIR\x22 \x22$FTP_FILE\x22; bye"
export FTP_FILE=History.txt
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "put -e -O \x22$FTP_DIR\x22 \x22$FTP_FILE\x22; bye"
echo "$TRAVIS_COMMIT" > SHAID.txt
export FTP_FILE=SHAID.txt
lftp sftp://"$FTP_USER":"$FTP_PASSWORD"@"$FTP_HOST":"$FTP_PORT" -e "put -e -O \x22$FTP_DIR\x22 \x22$FTP_FILE\x22; bye"
