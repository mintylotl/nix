import os
import time
import subprocess

links = open('./links.txt', 'r')

print('Running Initialization Phase...')
for x in links:
    try:
        dlder = subprocess.Popen(['aria2c', f'{x}'], stdout=subprocess.PIPE, shell=True)
    except:
        pass

    (output, err) = dlder.communicate()
    time.sleep(7)
    os.system(f'kill {dlder.pid}')

print('Initialization Done.')

while True:
    for x in links:
        if x == "":
            continue

        os.chdir('./.tmp/')
        try:
            procAria = subprocess.Popen(['aria2c', f'{x}'], close_fds=True)
        except:
            pass

        time.sleep(6)
        os.system('echo 1 > file.txt')
        os.system(f'kill {procAria.pid}')
    
        for g in os.listdir():
            if ".aria2" in g:
                if os.path.isfile(f'./../{g}'):
                    os.chdir('./../')

                    try:
                        os.system(f'aria2c {x}')
                    except:
                        pass

    continU = False
    for v in os.listdir():
        if '.aria2' in v:
            continU = True

    if continU:
        continue
    else:
        os.exit(0)



