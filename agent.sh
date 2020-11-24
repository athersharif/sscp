#!/bin/sh

COMMANDS=("upload" "download")
USER=
HOST=attu.cs.washington.edu
HOME="~"
FROM="/"
TO="/"
FPATH=$(echo $PWD)
FOLDER=

COMMAND=$1

if [ -z "$COMMAND" ]
then
  echo "command not defined (choose from upload, download)"
  exit 1
elif [[ ! " ${COMMANDS[@]} " =~ " ${COMMAND} " ]]
then
  echo "command not supported (choose from upload, download)"
  exit 1
fi

while test $# -gt 0; do
  case "$2" in
    -h|--help)
      echo "sscp - simplying scp for uploads and downloads"
      echo " "
      echo "sscp [command] [options]"
      echo " "
      echo "options:"
      echo "-h, --help                show brief help"
      echo "--user USER               login username (default: logged user on the terminal)"
      echo "--host HOST               server host (default: attu.cs.washington.edu)"
      echo "--home HOME               home directory (default: ~)"
      echo "--from FROM               relative directory path for sub folders (default: /)"
      echo "--to TO                   relative directory path for sub folders (default: /)"
      echo "--path PATH               source/destination main path (default: pwd)"                        
      echo "--folder FOLDER           folder to upload/download (default: empty, needed parameter)"      
      echo " "
      echo "written by Ather Sharif <ather.sharif@gmail.com>"
      exit 0
      ;;
    --user)
      shift
      USER=$2
      ;;
    --host)
      shift
      HOST=$2
      ;;
    --home)
      shift
      HOME=$2
      ;;
    --from)
      shift
      FROM=$2
      ;;
    --to)
      shift
      TO=$2
      ;;   
    --path)
      shift
      FPATH=$2
      ;;   
    --folder)
      shift
      FOLDER=$2
      ;;                              
    *)
      break
      ;;
  esac
done

if [ -z "$FOLDER" ]
then
  echo "folder not specified"
  exit 1
elif [[ "$COMMAND" == "upload" ]] && [ ! -d "$FPATH$FROM$FOLDER" ]
then
  echo "folder does not exist"
  exit 1
fi

if [[ "$COMMAND" == "upload" ]]
then
  echo "Uploading to $HOME$FROM$FOLDER at $HOST from $FPATH$TO$FOLDER"
  scp -r $FPATH$FROM$FOLDER $USER@$HOST:$HOME$TO$FOLDER
  echo "Done"  
elif [[ "$COMMAND" == "download" ]]
then
  echo "Downloading from $HOME$FROM$FOLDER at $HOST to $FPATH$TO$FOLDER"
  scp -r $USER@$HOST:$HOME$FROM$FOLDER $FPATH$TO$FOLDER
  echo "Done"  
fi
