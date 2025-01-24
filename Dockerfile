FROM node:18

# Рабочая директория
WORKDIR /app

# Копируем package.json и устанавливаем зависимости
COPY package*.json ./
RUN npm install

# Устанавливаем Newman
RUN npm install -g newman

# Устанавливаем репортер как зависимость проекта
RUN npm install --save newman-reporter-htmlextra

# Копируем весь проект
COPY . .

# Копируем базу данных из бэкапа
RUN cp mockApi/db_back_up.yaml mockApi/db_stage.yaml

# Экспонируем порт 3000
EXPOSE 3000

# Команда для запуска API-сервера
CMD ["npx", "yaml-server", "--hotReload=off", "--autoStart=off", "--port", "3000", "--database", "./mockApi/db_stage.yaml"]
