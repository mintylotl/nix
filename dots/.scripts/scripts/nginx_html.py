import os
from time import sleep

def walklevel(some_dir, level=1):
        some_dir = some_dir.rstrip(os.path.sep)
        assert os.path.isdir(some_dir)
        num_sep = some_dir.count(os.path.sep)
        for root, dirs, files in os.walk(some_dir):
            yield root, dirs, files
            num_sep_this = root.count(os.path.sep)
            if num_sep + level <= num_sep_this:
                del dirs[:]

os.chdir('/var/nginx')
while True:
    try:
        testy = open('index.html', 'r')
        if testy.read() == prevFile:
            sleep(15)
            continue
    except:
        pass
    
    file = open('index.html', 'w+')

    file.write('<head><link rel="stylesheet" href="./css/style.css"><title page-title>File Server</title></head>\n')
    file.write('<div class="top">Downloading Files Now For Completely Free! With ❤️ From INDIA 🇮🇳🇮🇳🇮🇳</div>\n')
    file.write('<body>\n')
    file.write('<ul>\n')

    for i in walklevel('./', 0):
        dirs = i
        break

    okay = False
    for i in dirs[2]:
        if not i == 'index.html' and not i == 'style.css':
            okay = True
            file.write('<br>\n')
            file.write(f'<div style="word-wrap: break-word"><li><a href="./{i}">{i.split("./")[0]}</a></li></div>\n')

    if okay:
        file.write('<br>\n')
    file.write('</ul>\n')
    file.write('</body>\n')
    file.write('<div class="top">100% WORKING !!!</div>')
    
    prevFile = file.read()
    file.close()

    sleep(15)
