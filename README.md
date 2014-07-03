ingenyo_playbooks
=================

all what we need 

    ansible-playbook  ingenyo.yml -i hosts/ingenyo  --ask-sudo-pass

you dont know the sudo pass?? well is okay
you need to change the username in ingenio.yml and maybe add you host file to your repository

    - name: ingenyo
     hosts: YOUR_HOSTF_FILE
     user: YOUR_USENAME
     sudo: true

