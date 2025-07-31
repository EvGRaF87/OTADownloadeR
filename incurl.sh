#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# --- НАСТРОЙКИ ---
CURL_SH_URL="https://raw.githubusercontent.com/EvGRaF87/OTADownloadeR/refs/heads/main/curl.sh"

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RED="\e[31m"
RESET="\e[0m"

# Пути
OTA_DIR="$HOME/OTA"
CURL_SH_PATH="$OTA_DIR/curl.sh"

# Вывод ошибки
handle_error() {
    echo -e "\n${RED}ОШИБКА: $1${RESET}"
    echo -e "${YELLOW}Установка прервана.${RESET}"
    exit 1
}

clear
echo -e "${BLUE}=====================================================${RESET}"
echo -e "${BLUE}==         Установщик DownloadeR by SeRViP         ==${RESET}"
echo -e "${BLUE}=====================================================${RESET}"
echo ""
echo -e "${YELLOW}Этот скрипт автоматически скачает и настроит всё необходимое.${RESET}"
read -p "Нажмите [Enter] для начала..."

echo -e "\n${GREEN}>>> Шаг 1: Загрузка скрипта (curl.sh)...${RESET}"

if [ ! -d "$OTA_DIR" ]; then
  mkdir -p "$OTA_DIR"
  if [ $? -eq 0 ]; then
    echo "Создана '$OTA_DIR' папка."
  else
    echo "Ошибка при создании папки '$OTA_DIR'."
    exit 1
  fi
else
  echo "Папка '$OTA_DIR' уже существует."
fi

curl -sL "$CURL_SH_URL" -o "$CURL_SH_PATH"

if [ $? -ne 0 ]; then
    handle_error "Не удалось скачать скрипт curl.sh!"
fi
if [ ! -f "$CURL_SH_PATH" ] || [ ! -s "$CURL_SH_PATH" ]; then
    handle_error "Файл curl.sh не был загружен или пуст! Проверьте URL и интернет-соединение."
fi
echo -e "${GREEN}Скрипт curl.sh успешно загружен в $CURL_SH_PATH${RESET}"

echo -e "\n${GREEN}>>> Шаг 2: Создание ярлыка...${RESET}"
SHORTCUT_DIR="$HOME/.shortcuts"
SHORTCUT_FILE="$SHORTCUT_DIR/Downloads"

mkdir -p "$SHORTCUT_DIR"
chmod 700 -R "$SHORTCUT_DIR"

echo -e "${BLUE}Создаем файл ярлыка: $SHORTCUT_FILE...${RESET}"

cat "$CURL_SH_PATH" >> "$SHORTCUT_FILE"

chmod +x "$SHORTCUT_FILE"
echo -e "${GREEN}Ярлык 'Downloads' успешно создан!${RESET}"

clear
echo -e "${GREEN}=============================================${RESET}"
echo -e "${GREEN}     🎉 Установка успешно завершена! 🎉      ${RESET}"
echo -e "${GREEN}=============================================${RESET}"
echo ""
echo -e "${YELLOW}Что делать дальше:${RESET}"
echo "1. Полностью закройте приложение Termux (командой 'exit')."
echo "2. Перейдите на главный экран вашего телефона."
echo "3. Добавьте виджет 'Termux'."
echo "4. В списке доступных ярлыков должен появиться 'Downloads'."
echo "5. Нажмите на него, чтобы запустить скрипт загрузки пакетов."
echo ""
echo -e "${BLUE}С Вами был${RESET}" "${RED}SeRViP!${RESET}"
