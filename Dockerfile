# Указываем ОС и версию, на которой делаем контейнер
FROM ubuntu:18.04

# устанавливаем компиляторы и cmake
RUN apt update
RUN apt install -yy gcc g++ cmake

# перемещаем всё в рабочуюю директорию print
COPY . print/
WORKDIR print

# собираем и устанавливаем программу, с которой работаем
RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
RUN cmake --build _build
RUN cmake --build _build --target install

# задаём путь, куда программа будет выводить логи
ENV LOG_PATH /home/logs/log.txt

# задаём путь, где docker будет хранить данные
VOLUME /home/logs

# переходи
WORKDIR _install/bin

ENTRYPOINT ./demo