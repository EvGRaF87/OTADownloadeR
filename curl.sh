#!/bin/bash

# 🎨 Colors
GREEN="\e[32m";
YELLOW="\e[33m"; BLUE="\e[34m"; RESET="\e[0m"

download_dir="/storage/emulated/0/Download"
argument="Dalvik/2.1.0 (Linux; U; Android 11; Pixel 3 Build/RQ3A.210705.001)"

clear
echo -e "${GREEN}================================================${RESET}"
echo -e "${GREEN}===${RESET}           ${YELLOW}DownloadeR by SeRViP${RESET}           ${GREEN}===${RESET}"
echo -e "${GREEN}================================================${RESET}"
echo -e
read -p "Введите URL: " url

if [[ -z "$url" || ! "$url" =~ ^https?:\/\/ ]]; then
  echo "Ошибка: Некорректный URL. URL должен начинаться с 'http://' или 'https://'"
  exit 1
fi
echo -e
filename=$(basename "$url")
read -p "Введите имя файла (по умолчанию: $filename): " filename_input
filename="${filename_input:-$filename}"
echo -e
echo   "Downloading....."
echo -e
curl -A "$argument" -d "$download_dir" -o "$filename" "$url"
echo -e
if [ $? -eq 0 ]; then
  echo "Загрузка завершена успешно."
  echo "Файл сохранен в: $download_dir"
else
  echo "Ошибка при загрузке. Проверьте URL и подключение к интернету."
fi
echo -e
while true; do
    echo -e "🔄 1 - Download from other URL"
    echo -e "❌ 0 - End script"
    echo -e 
    read -p "💡 Select an option (1/0): " option
    case "$option" in
        1)
            bash "$0"
            ;;
        0)
            echo -e "👋 Goodbye."
            exit 0
            ;;
        *)
            echo "❌ Invalid option."
            ;;
    esac
done
