# Elastic + Kibana + Filebeat. Ansible playbook
Поднимает на хостах:
- Elastic (тег `elastic`).
- Kibana (тег `kibana`).
- Filebeat (тег `filebeat`)

## Ответы к ДЗ
1. ✅ `ansible-lint site.yaml`
2. ✅ `ansible-playbook -i inventory/prod.yml site.yml --check`
3. ✅ `ansible-playbook -i inventory/prod.yml site.yml --diff`
