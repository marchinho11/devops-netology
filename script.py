#!/usr/bin/env python3

import os
import sys
from requests import post

# Проверка на наличие GITHUB_TOKEN в env-переменных
GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")
if not GITHUB_TOKEN:
    raise RuntimeError("Please specify `GITHUB_TOKEN` in env")

# Переключение ветки и коммит всех изменений
NEW_BRANCH_NAME = sys.argv[1]
COMMIT_MESSAGE = sys.argv[2]
print(f"New branch name: {NEW_BRANCH_NAME}. Commit message: {COMMIT_MESSAGE}")
bash_command = (
    f"git checkout -b {NEW_BRANCH_NAME} && "
    "git add . && "
    f'git commit -m "{COMMIT_MESSAGE}" && '
    f"git push --set-upstream origin {NEW_BRANCH_NAME}"
)
result_os = os.popen(bash_command).read()

# Создание PR
headers = {"Authorization": f"token {GITHUB_TOKEN}"}
params = {"head": NEW_BRANCH_NAME, "base": "master", "title": COMMIT_MESSAGE}
resp = post(
    "https://api.github.com/repos/marchinho11/devops-netology/pulls",
    headers=headers,
    json=params,
).json()
if resp.get("state") == "open":
    print(
        "PR created successfully!\n"
        f"Url: {resp['html_url']}"
    )
