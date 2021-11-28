# Java + Elastic + Kibana Ansible playbook
Поднимает на хостах:
- Java (тег `java`). Берет скачанный JDK из директории `files`, распаковывает, задает переменные окружения.
- Elastic (тег `elastic`). Качает .tar.gz с офф сайта, распаковывает, настраивает переменные окружения и конфиг.
- Kibana (тег `kibana`). Качает .tar.gz с офф сайта, распаковывает, настраивает переменные окружения и конфиг.

## dev инфарструктура
```shell
# "инфраструктура"
docker network create elk_stack_netology

docker run --rm -d \
  --name elasticsearch \
  -p 9200:9200 \
  --network elk_stack_netology \
  python:3.9 sleep 10000
   
docker run --rm -d \
  --name kibana \
  -p 5601:5601 \
  --network elk_stack_netology \
  python:3.9 sleep 10000
```

## Ответы к ДЗ
1. ✅ `ansible-lint site.yaml`
2. ✅ `ansible-playbook -i inventory/prod.yml site.yml --check`
3. ```shell
   ansible-playbook -i inventory/prod.yml site.yml --check
   # Падает:
   # fatal: [kibana]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.13' must be an existing dir"}
   ```
4. ```shell
   ansible-playbook -i inventory/prod.yml site.yml --diff

   #  PLAY RECAP *******************************************************************************************************
   #  elasticsearch              : ok=12   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
   #  kibana                     : ok=12   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
   ```
5. ```shell
   # Повторно
   ansible-playbook -i inventory/prod.yml site.yml --check
   
   # PLAY RECAP ********************************************************************************************************
   # elasticsearch              : ok=10   changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
   # kibana                     : ok=10   changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
   ```
