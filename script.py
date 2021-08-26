#!/usr/bin/env python3

import os
import sys
import socket
import pickle
import threading


# Локальный "сторадж" для персистентности
class JsonYamlIpStorage:
    STORAGE_NAME = "ip_storage.pickle"
    STORAGE_PATTERN_JSON = "{service_name}.json"
    STORAGE_PATTERN_YAML = "{service_name}.yaml"

    def __init__(self):
        self._storage = dict()
        self._lock = threading.Lock()
        self._load_file_storage()

    def update_service_ip(self, host, ip, check_mismatch=True):
        # Проверка на несовпадение ip сервиса
        if check_mismatch:
            current_ip = self._storage.get(host)
            if current_ip and current_ip != ip:
                print(f"[ERROR] {host} IP mismatch: {current_ip} {ip}")

        self._storage[host] = ip
        self._persist_file_storage()
        self.__persist_service_json_yaml(service=service, ip=ip)

    def get_service_ip(self, host):
        return self._storage.get(host)

    def _load_file_storage(self):
        """Проверить, есть ли файл с ip-ами на диске и по-возможности загрузить."""
        files_ = os.listdir(".")
        if self.STORAGE_NAME in files_:
            with self._lock:
                with open(self.STORAGE_NAME, "rb") as f_in:
                    self._storage = pickle.load(f_in)

    def _persist_file_storage(self):
        """Записать на диск сторадж."""
        with self._lock:
            with open(self.STORAGE_NAME, "wb") as f_in:
                pickle.dump(self._storage, f_in)

    def __persist_service_json_yaml(self, service, ip):
        import json
        with self._lock:
            with open(self.STORAGE_PATTERN_JSON.format(service_name=service), "w") as f_out:
                json.dump({service: ip}, f_out)

        import yaml
        with self._lock:
            with open(self.STORAGE_PATTERN_YAML.format(service_name=service), "w") as f_out:
                yaml.dump([{service: ip}], f_out)


# Получить сервисы для проверки
services = sys.argv[1:]

# Создадим сторадж для персистентности
ip_storage = JsonYamlIpStorage()

for service in services:
    ip_ = socket.gethostbyname(service)
    ip_storage.update_service_ip(service, ip_)
    ip = ip_storage.get_service_ip(service)
    print(f"{service} - {ip}")
