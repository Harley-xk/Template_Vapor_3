#!/bin/bash

DEFAULT='\033[0;39m'
WHITE='\033[0;97m'
GREEN='\033[0;32m'
LIGHTGREEN='\033[0;92m'
CYAN='\033[0;36m'
LIGHTCYAN='\033[0;96m'

echo -e "${GREEN}All files successfuly generated!"

echo -e "${CYAN}Updating Dependencies...${DEFAULT}"

vapor update --verbose

echo -e "${LIGHTGREEN}Project {{cookiecutter.product_name}} successfully generated!${DEFAULT}"
