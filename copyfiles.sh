#!/bin/bash
export SSHPASS="$FTP_PASSWORD"
sshpass -e sftp -o StrictHostKeyChecking=no -q -P $FTP_PORT $FTP_USER@$FTP_HOST <<EOF
  quit
EOF
export FTP_FILE=domoticz_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.tgz
lftp sftp://$FTP_USER:"$FTP_PASSWORD"@$FTP_HOST:$FTP_PORT -e "put -O /incoming/domoticz/ $FTP_FILE; bye"
export FTP_FILE=domoticz_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.tgz.sha256sum
lftp sftp://$FTP_USER:"$FTP_PASSWORD"@$FTP_HOST:$FTP_PORT -e "put -O /incoming/domoticz/ $FTP_FILE; bye"
export FTP_FILE=version_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.h
lftp sftp://$FTP_USER:"$FTP_PASSWORD"@$FTP_HOST:$FTP_PORT -e "put -O /incoming/domoticz/ $FTP_FILE; bye"
export FTP_FILE=history_${TRAVIS_OS_NAME}_${TARGET_ARCHITECTURE}.txt
lftp sftp://$FTP_USER:"$FTP_PASSWORD"@$FTP_HOST:$FTP_PORT -e "put -O /incoming/domoticz/ $FTP_FILE; bye"
export FTP_FILE=History.txt
lftp sftp://$FTP_USER:"$FTP_PASSWORD"@$FTP_HOST:$FTP_PORT -e "put -O /incoming/domoticz/ $FTP_FILE; bye"

