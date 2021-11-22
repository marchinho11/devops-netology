# Основная часть
1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте какое значение имеет факт `some_fact` для указанного хоста при выполнении playbook'a.
   ```
   12
   ```
2. Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact'.
   ```
   done
   ```
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
   ```shell
   docker run --rm --name centos7 -d python:3.9 sleep 1000
   docker run --rm --name ubuntu -d python:3.9 sleep 1000
   ```
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
   ```shell
   ansible-playbook -i inventory/prod.yml site.yml
   # deb, el
   ```
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились следующие значения: для `deb` - 'deb default fact', для `el` - 'el default fact'.
   ```
   done
   ```
6. Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
   ```
   done
   ```
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
   ```shell
   ansible-vault encrypt group_vars/deb/examp.yml
   ansible-vault encrypt group_vars/centos/examp.yml
   ```
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
   ```shell
   ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
   ```
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
   ```shell
   ❗️
   ```
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
   ```
   done
   ```
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
   ```shell
   ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass 

#    ok: [localhost] => {
#      "msg": "all default fact"
#    }
#    ok: [centos7] => {
#      "msg": "el default fact"
#   }
#   ok: [ubuntu] => {
#      "msg": "deb default fact"
#   }
   ```

# Необязательная часть
1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
   ```shell
   ansible-vault decrypt group_vars/deb/examp.yml
   ansible-vault decrypt group_vars/el/examp.yml
   ```
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
   ```shell
   ansible-vault encrypt_string 'PaSSw0rd'
   ```
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
   ```shell
   ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass 
   ```

### Notes
```shell
# Inventory
ansible-inventory -i inventory --graph 
ansible-inventory -i inventory --list

ansible-vault view group_vars/deb/examp.yml
```